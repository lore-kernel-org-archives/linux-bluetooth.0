Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Daniel Abraham <daniel.shrugged@gmail.com>
Subject: Re: HDP proposed API (ver 0.3)
Date: Wed, 12 May 2010 13:25:26 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>,
	Santiago Carot <sancane@gmail.com>,
	Raul Herbster <raul.herbster@signove.com>
References: <201005121126.12859.jcaden@libresoft.es> <AANLkTik5a4HBJZ_FYZ00xdnTiOtGmsdatn0EnV_joHjx@mail.gmail.com>
In-Reply-To: <AANLkTik5a4HBJZ_FYZ00xdnTiOtGmsdatn0EnV_joHjx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005121325.26454.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

first of all thanks for your comments.

El Wednesday 12 May 2010 12:45:28 Daniel Abraham escribió:
> On Wed, May 12, 2010 at 12:26 PM, José Antonio Santos Cadenas
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
> > 
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
> > 
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
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                         org.bluez.Error.NotFound
> > 
> > -------------------------------------------------------------------------
> > -------
> > 
> > Service         org.bluez
> > Interface       org.bluez.Hdp
> > Object path     [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > 
> > Methods array GetSessions()
> > 
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
> > 
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
> > 
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
> 
> "getdcfd" doesn't seem to me as a "friendly" name. Any way to make it
> better, please?

You are right, I forgot to change this name, thank you for the notice. I 
suggest:

GetDataChannelFileDescriptor

Which is more compliant with the rest of the API.

> 
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
> 
> Question from a user's perspective: why define an agent? Why not
> define the above as signal callbacks in the relevant object? (same as
> most APIs in "bluez/docs").

Because the this notifications are only relevant for the process that created 
the session and this process should be the unique that receives this events. 
If you define signals, everybody in the bus can be subscribed to them, this is 
a problem in two ways:
	- Noise in the bus
	- "Privacy" issue because just the owner of the session should be notified 
of the session events.

> 
> The only places I saw where agents are used are: BlueZ pairing (remote
> device object doesn't necessarily exist yet, so no way to register for
> its events, so an agent is required), and obexd (callback methods for
> authroization of transactions return a significant value, i.e. not a
> simple signal, so an agent is also required).
> 
> But none of these conditions apply in the HDP agent above. So is there
> another reason?

I explained above.

If we are wrong and signals can be cached only by one process it is OK for us 
to change this.

> 
> Also, why not add properties for
> connected/disconnected/opened/closed/etc. states? (And then
> "GetProperties()" method, and "PropertyChanged(name, value)" signal).
> For example, see "bluez/docs/network-api.txt"...

Because this notifications concern to objects that are being created and 
destroyed (in the case of devices) and created or closed data channels, so new 
data channels ids are created or destroyed when this method are called. I 
can't see how properties can help here. The channel may exist or not I think 
that properties are not a good option in this case.

Regards.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
