Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: =?iso-8859-1?q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: HDP proposed API(0.5)
Date: Mon, 17 May 2010 23:40:55 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201005171654.36923.jcaden@libresoft.es> <AANLkTikCmZydkLG863_MbrMhiNlWx5GecQaXitr1q0xX@mail.gmail.com>
In-Reply-To: <AANLkTikCmZydkLG863_MbrMhiNlWx5GecQaXitr1q0xX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005172340.56271.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Monday 17 May 2010 23:17:58 João Paulo Rechi Vita escribió:
> On Mon, May 17, 2010 at 11:54, José Antonio Santos Cadenas
> 
> <jcaden@libresoft.es> wrote:
> > Hope the last one :)
> > 
> > ----------------------------
> > 
> > BlueZ D-Bus Health API description
> > **********************************
> > 
> >        Santiago Carot-Nemesio <sancane@gmail.com>
> >        José Antonio Santos-Cadenas <santoscadenas@gmail.com>
> >        Elvis Pfützenreuter <epx@signove.com>
> > 
> > Health Device Profile hierarchy
> > ===============================
> > 
> > Service         org.bluez
> > Interface       org.bluez.HealthAdapter
> > Object path     [variable prefix]/{hci0,hci1,...}
> > 
> > Methods         object CreateInstance(object path, dict config)
> > 
> >                        Returns the path for the new HealthInstance
> > object. The path parameter is the path of the remote object with the
> > callbacks to notify events (see
> >                        org.bluez.HealthAgent at the end of this document)
> >                        This petition starts an mcap instance and also
> > register in the SDP if is needed
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
> >                        Instance will be closed by the call or implicitly
> > when the programs leaves the bus.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> > 
> >                void CloseInstance(object path)
> > 
> >                        Closes the HDP instance identified by the object
> > path. Also instance will be closed if the process that started leaves
> > the bus. If there is a SDP record associated to this instance it will be
> > removed.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                        org.bluez.Error.NotFound
> > 
> > -------------------------------------------------------------------------
> > -------
> > 
> > Service         org.bluez
> > Interface       org.bluez.HealthDevice
> > Object path     [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > 
> > Methods         array GetHealthInstances()
> > 
> >                        Gets the information of the remote instances
> > present in this device and published on its SDP record. The returned
> > data follows this format.
> > 
> >                        [{"id": "an instance identification as string",
> >                         "data_spec" : data spec,
> >                         "end_points":
> >                                ["mdepid": uint8,
> >                                 "role"  : "source" or "sink" ,
> >                                 "specs" : [{
> >                                        "dtype"       : uint16,
> >                                        "description" : string, (optional)
> >                                 }]
> >                                ]
> >                        }];
> > 
> > -------------------------------------------------------------------------
> > -------
> > 
> > Service         org.bluez
> > Interface       org.bluez.HealthInstance
> > Object path     [variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}
> > 
> >                object Connect(remote_instance_id)
> > 
> >                        Connects with the remote instance and returns its
> > object path. To get the session ids on a remote device, you must run the
> > GetHealthInstances in the HealthDevice object.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                        org.bluez.Error.HealthError
> > 
> >                void Disconnect(object device, boolean cache)
> > 
> >                        Disconnect from the remote device. If chahe is
> > false, state will also be deleted. Otherwise, the state will be kept for
> > allowing future reconnections until the adapter is removed.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                        org.bluez.Error.NotFound
> >                                        org.bluez.Error.HealthError
> > 
> > -------------------------------------------------------------------------
> > -------
> > 
> > Service         org.bluez
> > Interface       org.bluez.HealthLink
> > Object path     [variable
> > prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}/rem_inst_id
> > 
> >                boolean Echo(array{byte})
> > 
> >                        Sends an echo petition to the remote intance.
> > Returns True if response matches with the buffer sent. If some error is
> > detected False value is returned and the associated MCL is closed.
> > 
> >                uint16 OpenDataChannel(byte mdepid, byte config)
> > 
> >                        Creates a new data channel with the indicated
> > config to the remote MCAP Data End Point (MDEP). The configuration
> > should indicate the channel quality of service. In the current version
> > of HDP, valid values are 0x01 for reliable channels and 0x02 for
> > streaming data channel.
> > 
> >                        Returns the data channel id.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                        org.bluez.Error.HealthError
> > 
> >                array GetDataChannelFileDescriptor(uint16 mdlid)
> 
> Wouldn't be better to pass the fd through the LinkConnected call on
> Agent? Doing it here allows any process to get the fds.

Originally we thought about doing like that. But Elvis suggested to centralize 
all the ways that you get the file descriptor in just one place and we thought 
that it was a great idea. In addition, think that you will need this call 
because the LinkConnected call is only called when the connection is initiated 
by the remote HDP instance but the connections initiated by your side will not 
be notified. About the "security" issue you mentioned, we are planing to 
control who can call this methods only the process that initiated the HDP 
instance will receive a response to this methods, any other process will 
receive an error.

> 
> >                        Gets a file descriptor where data can be read or
> >                        written for receive or sent by the data channel.
> >                        Returns an array of file descriptors one for write
> >                        and other for read.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                        org.bluez.Error.NotFound
> >                                        org.bluez.Error.HealthError
> > 
> >                void DeleteDataChannel(uint16 mdlid)
> > 
> >                        Deletes a data channel so it will not be available
> > for use.
> > 
> >                        Possible errors: org.bluez.Error.InvalidArguments
> >                                        org.bluez.Error.NotFound
> >                                        org.bluez.Error.HealthError
> > 
> >                void DeleteAllDataChannels()
> > 
> >                        Deletes all data channels so it will not be
> > available for use. Typically this function is called when the connection
> > with the remote device will be closed permanently
> > 
> >                        Possible errors: org.bluez.Error.HealthError
> > 
> >                dict GetDataChannelStatus()
> > 
> >                        Return a dictionary with all the data channels
> > that can be used to send data right now. The dictionary is formed like
> > follows:
> >                        {
> >                                "reliable": [mdlid_r1, mdlid_r2, ...],
> >                                "streaming" : [mdlid_s1, mdlid_s2, ...]
> >                        }
> > 
> >                        The fist reliable data channel will always be the
> > first data channel in reliable array.
> > 
> > HealthAgent hierarchy
> > ==================
> > 
> > (this object is implemented by the HDP client an receives notifications)
> > 
> > Service         unique name
> > Interface       org.bluez.HealthAgent
> > Object path     freely definable
> > 
> >                void LinkConnected(object path)
> > 
> >                        This method is called whenever a new connection
> >                        has been established over the control channel of
> > the current HDP instance. The object path paremeter contains the object
> > path of the created HealthLink.
> > 
> >                void LinkDisconnected(object path)
> > 
> >                        This method is called when a remote device is
> >                        disconnected definitively. Any future
> > reconnections will fail. Also all data channels associated to this
> > device will be closed.
> > 
> >                void CreatedDataChannel(object path, uint16 mdlid, byte
> > conf)
> > 
> >                        This method is called when a new data channel is
> > created The path contains the object path of the HealthLink where the
> > new connection is created, the mdlid is the data channel identificator
> > and conf is the que quality of service of the data channel (0x01
> > reliable, 0x02 streaming).
> > 
> >                void DeletedDataChannel(object path, uint16 mdlid)
> > 
> >                        This method is called when a data channel is
> > closed. After this call the data channel will not be valid and can be
> > reused for future created data channels. --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
