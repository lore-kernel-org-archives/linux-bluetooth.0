Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: =?iso-8859-1?q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: HDP proposed API (ver 0.3)
Date: Thu, 13 May 2010 10:02:24 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>,
	Santiago Carot <sancane@gmail.com>,
	Raul Herbster <raul.herbster@signove.com>
References: <201005121126.12859.jcaden@libresoft.es> <AANLkTilxSqkcpovtfgB9WntnB0UEIf3DdZAmobbrAiUK@mail.gmail.com>
In-Reply-To: <AANLkTilxSqkcpovtfgB9WntnB0UEIf3DdZAmobbrAiUK@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005131002.24806.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João,

Thank you very much for you comments :)

El Thursday 13 May 2010 00:03:51 João Paulo Rechi Vita escribió:
> Hello Jose!
> 
> On Wed, May 12, 2010 at 06:26, José Antonio Santos Cadenas
> 
> <jcaden@libresoft.es> wrote:
> > This api is a clean up of the previous one the changes.
> > 
> > We've added a new object that uses device path to get the sessions
> > allocated on this device (as somebody recommended in other thread,
> > I think Luiz, Elvis or both, but I can't find the exact email). The
> > discovery of new remote session should be done using device drivers,
> > which is compliant with the BlueZ style.
> > 
> > Discussions still in progress:
> > 
> > - Fd-passing issue: As Elvis, Santiago and I discussed yesterday on
> > IRC we think that the best propose is as follows (please Elvis correct
> > me if I misunderstood something yesterday):
> >        Reconnections should be implicit and the data channel should
> > be perceived by the application layer as connected all the time.
> >        When the application tries to write in a closed data channel, HDP
> > will perform the data channel reconnection and if it fails, then the
> > channel will be present as closed.
> >        The implementation for this this behaviour will use pipes. Each
> > data channel will use 2 pipes to do fd-passing to the application. The
> > upper layer will write in this pipes and HDP will redirect it through
> > the l2cap socket, in this operation, HDP can reconnect if th l2cap
> > socket is closed.
> > 
> > - Sessions issues: We still think that session are necessary because they
> > are mentioned in the standard and in the whitepaper and we think that
> > bluez should follow the standards in order to pass PTS for allow
> > Bluetooth SIG certifications. Any comment in this respect are welcome to
> > improve the API usability and conformity with Bluez APIs.
> > 
> > - Paths issues: It will be great to find names and paths that are good
> > for everybody, comments and suggestion on this respect are also welcome.
> > 
> > I hope we can fix this API asap. All comments or ideas are welcome.
> 
> It would be much better if you could bring this API near to other
> BlueZ APIs. All comments I'll do right now is regarding this matter.
> 
> > Regards.
> > 
> > --------------------------------------------------
> > 
> > BlueZ D-Bus HDP API description
> > ***********************************
> > 
> >        Santiago Carot-Nemesio <sancane@gmail.com>
> >        José Antonio Santos-Cadenas <santoscadenas@gmail.com>
> >        Elvis Pfützenreuter <epx@signove.com>
> > 
> > Health Device Profile hierarchy
> > ===============================
> > 
> > Service         org.bluez
> > Interface       org.bluez.Hdp
> 
> If you look on other profile interfaces you'll see that we never use
> the profile acronym for interface names, but the content type (and
> role, where applicable). So this will be better as org.bluez.Health.
> 
> Moreover, I see you're using the same interface name to describe two
> different interfaces. This is just wrong. An interface should be a
> description of an unique group of methods and signals signatures. You
> can refer to [0] for a description on interfaces.
> 
> [0] http://dbus.freedesktop.org/doc/dbus-tutorial.html#interfaces

Ok, regarding the above comments, this interface changes to:

Interface	org.bluez.HealthAdapter

> 
> > Object path     [variable prefix]/{hci0,hci1,...}
> > 
> > Methods         object CreateSession(object path, dict config)
> > 
> >                        Returns the object path for the new HDP session.
> >                        The path parameter is the path of the remote
> > object with the callbacks to notify events (see
> >                        org.bluez.HdpAgent at the end of this document)
> >                        This petition starts an mcap session and also
> > register in the SDP is needed
> >                        Dict is defined as bellow:
> >                        { "data_spec" : The data_spec is the data exchange
> >                                        specification (see section 5.2.10
> > of the specification document) possible values:
> >                                                0x00 = reserved,
> >                                                0x01 [IEEE 11073-20601],
> >                                                0x02..0xff reserved,
> >                                        (optional)
> >                          "end_points" : [{ (optional)
> >                                "mdepid" : uint8, (optional)
> >                                "role" : ("source" or "sink"), (mandatory)
> >                                "specs" :[{ (mandatory)
> >                                        "data_type" : uint16, (mandatory)
> >                                        "description" : string, (optional)
> >                                }]
> >                          }]
> >                        }
> 
> Couldn't this be moved as properties on the session object? So after
> creating a session you just go on it's object path and set the desired
> properties with SetProperty(). This will be much more aligned with
> other BlueZ APIs.

We thought about doing something similar to this you propose, but we see some 
promen, that makes the API more difficult to use:
	- Session will need another method in order to start it once you have 
configured it. With this method, configuration and session start are done in 
just one method call. This implies that the other methods (connect and 
disconnect to a remote session) could not be called until the session is 
started, this quite strange.
	- As you can see, the dictionary has only two members, "data_spec" and 
"end_points". So, you will have to pass a dictionary to set end_points too.

> 
> >                        if "data_spec" is not set, no SDP record will be
> >                        registered, so all the other data in the
> > dictionary will be ignored
> > 
> >                        Session will be closed by the call or implicitly
> > when the programs leaves the bus.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> > 
> >                void CloseSession(object path)
> > 
> >                        Closes the HDP session identified by the object
> > path. Also session will be closed if the process that started it is
> > removed from the D-Bus.
> 
> s/D-Bus/bus. Also, would be good to keep the description consistent
> between methods. Previous description says "the programs leaves" and
> here "process is removed". IMHO "the process leaves the bus" will be
> the more accurate.

Ok, I'll try to be more consistent in the next revision, using the text that 
you suggested.

> 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                         org.bluez.Error.NotFound
> > 
> > -------------------------------------------------------------------------
> > -------
> > 
> > Service         org.bluez
> > Interface       org.bluez.Hdp

Chage this to:

Interface org.bluez.HdpDevice

> > Object path     [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > 
> > Methods array GetSessions()
> 
> It would be better if this method return the session object path, then
> you can get this information with GetProperties() on the session
> object.

Do you mean creating a new object that holds the remote sessions?
Right now the  org.bluez.HdpSession Objects holds only local sessions. Remote 
session will be a bit different. See below.

> 
> >                        Gets the information of the remote sessions
> > present in this device and published on its SDP record. The returned
> > data follows this format.
> > 
> >                        [{"session_id": "a session identification as
> > string", "data_spec" : session data spec,
> >                         "end_points":
> >                                 ["mdepid": uint8,
> >                                  "role"  : "source" or "sink" ,
> >                                  "specs" : [{
> >                                          "dtype"       : uint16,
> >                                          "description" : string,
> > (optional) }]
> >                                 ]
> >                        }]
> > 
> > -------------------------------------------------------------------------
> > -------
> > 
> > Service         org.bluez
> > Interface       org.bluez.HdpSession
> > Object path     [variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}
> 
> From the previous interface (the one that defines the GetSessions()
> method) it seems that sessions are tied to a specific device. If so,
> the session objects should be under the device object, not under the
> adapter object.

See below the Session explanation.
> 
> >                object Connect(remote_session_id)
> > 
> >                        Connects with the remote session and returns its
> > object path.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                         org.bluez.Error.HdpError
> > 
> >                void Disconnect(object device, boolean delete)
> > 
> >                        Disconnect from the remote device. If delete is
> > true, any status will also be deleted. Otherwise, the status will be
> > kept for allowing future reconnections.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                         org.bluez.Error.NotFound
> >                                         org.bluez.Error.HdpError
> > 
> > -------------------------------------------------------------------------
> > -------
> > 
> > Service         org.bluez
> > Interface       org.bluez.HdpRemoteSession
> > Object path     [variable
> > prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}/rem_session_id
> 
> Could you please elaborate more on what does HdpSession and
> HdpRemoteSessions tries to abstract? It still not clear to me and
> depending on this we may find a better name for it.

I think that the most estrange part of the protocol is this and I failed with 
my explanations.

HDP uses MCAP that uses what we called "sessions" in the MCAP standard the 
called them instances (refer to section 2.1.7 of the MCAP specification for 
more details).

A MCAP session/instance is just a tuple of two PSM waiting for connections one 
for control channels (mcl) and the other for data channels (mdl) this session 
can connect to a remote MCAP session or be connected by them, this connections 
is called mcap control link (mcl). Just one connection between two instances 
can be established.

As HDP uses MCAP, HDP inherits this "session" behaviour. Each HDP session 
starts a MCAP session and also could create a SDP record (mandatory for sinks) 
to anounce its attributes (mdeps, psms) to other devices.

The thing that we called HdpSession is a MCAP session (PSM's waiting for 
connections) created locally and, optionally a SDP record. HdpSession can 
connect to other devices' sessions.

The thing that we called HdpRemoteSession represents a connection between a 
local session and a session in other device, in other words is a extension of 
a MCAP mcl.

> 
> >                boolean Echo(array{byte})
> > 
> >                        Sends an echo petition to the remote session.
> > Return True if response matches with the buffer sent. If some error is
> > detected False value is returned and the associated MCL is closed.
> > 
> >                uint16 OpenDataChannel(byte mdepid, byte config)
> > 
> >                        Creates a new data channel with the indicated
> > config to the remote MCAP Data End Point (MDEP). The configuration
> > should indicate the channel quality of service.
> >                        Returns the data channel id.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                         org.bluez.Error.HdpError
> > 
> >                array GetDcFd(uint16 mdlid)
> > 
> >                        Gets a file descriptor where data can be read or
> >                        written for receive or sent by the data channel.
> >                        Returns an array of file descriptors one for write
> >                        and other for read.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                         org.bluez.Error.NotFound
> >                                         org.bluez.Error.HdpError
> > 
> >                void DeleteDataChannel(uint16 mdlid)
> > 
> >                        Deletes a data channel so it will not be available
> > for use.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                         org.bluez.Error.NotFound
> >                                         org.bluez.Error.HdpError
> > 
> >                void DeleteAllDataChannels()
> > 
> >                        Deletes all data channels so it will not be
> > available for use. Typically this function is called when the connection
> > with the remote device will be closed permanently
> > 
> >                        Possible errors: org.bluez.Error.HdpError
> > 
> >                dict GetDataChannelStatus()
> > 
> >                        Return a dictionary with all the data channels
> > that can be used to send data right now. The dictionary is formed like
> > follows:
> >                        {
> >                                "reliable": [id1, ..., idz],
> >                                "best_effort" : [idx, ..., idy]
> >                        }
> > 
> >                        The fist reliable data channel will always be the
> > first data channel in reliable array.
> > 
> > HDPAgent hierarchy
> > ==================
> > 
> > (this object is implemented by the HDP client an receives notifications)
> > 
> > Service         unique name
> > Interface       org.bluez.HdpAgent
> > Object path     freely definable
> > 
> >                void DeviceConnected(object path)
> > 
> >                        This method is called whenever a new device
> > connection has been established over the control channel of the current
> > HDP session. The object path contains the object path of the remote
> > device.
> > 
> >                void DeviceDisconnected(object path)
> > 
> >                        This method is called when a remote device is
> >                        disconnected definitively. Any future
> > reconnections will fail. Also all data channels associated to this
> > device will be closed.
> > 
> >                void CreatedDataChannel(object path, uint16 mdlid)
> > 
> >                        This method is called when a new data channel is
> > created The path contains the object path of the device whith the new
> > connection is created and the mdlid the data channel identificator.
> > 
> >                void DeletedDataChannel(object path, uint16 mdlid)
> > 
> >                        This method is called when a data channel is
> > closed. After this call the data channel will not be valid and can be
> > reused for future created data channels.

