Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1272959741.2182.123.camel@mosquito>
References: <1272959741.2182.123.camel@mosquito>
Date: Tue, 4 May 2010 13:04:31 +0300
Message-ID: <m2u2d5a2c101005040304ke238595n54b8584dd78b8f37@mail.gmail.com>
Subject: Re: HDP proposed API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Santiago Carot-Nemesio <scarot@libresoft.es>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 4, 2010 at 10:55 AM, Santiago Carot-Nemesio
<scarot@libresoft.es> wrote:
> Hello,
> Next is the API wich we have been working last weeks.
>
> Regards.
>
>
> BlueZ D-Bus HDP API description
> ***********************************
>
> Authors:
> Santiago Carot-Nemesio          sancane@gmail.com
> Jose Antonio Santos-Cadenas     santoscadenas@gmail.com
>
>
> Health Device Profile hierarchy
> ===============================
>
> Service         org.bluez
> Interface       org.bluez.Hdp
> Object path     [variable prefix]/{hci0,hci1,...}
>
> Methods         object CreateSession(object path, byte data_spec)
>
>                        Returns the object path for the new HDP session.
>                        The path parameter is the path of the remote object
>                        with the callbacks to nofity events (see
>                        org.bluez.HdpAgent at the end of this document)
>                        The data_spec is the data exchange specficication
>                        (see section 5.2.10 of the specification document)
>
>                        Possible errors: org.bluez.Error.InvalidArguments
>
>                void DeleteSession(object path)
>
>                        Delete the HDP session identified by the object path.
>
>                        Possible errors: org.bluez.Error.InvalidArguments
>                                         org.bluez.Error.NotFound
>
>
> --------------------------------------------------------------------------------
>
> Service         org.bluez
> Interface       org.bluez.HdpSession
> Object path     [variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}
>
>                uint8 AllocateMdep(uint8 role)
>
>                        This method allocates a logical end point. Valids values
>                        for MDEP roles are:
>                                * 0x00 For source
>                                * 0x01 For sink
>
>                        The return value is the allocated MDEP.
>
>                void AddFeature(uint8 mdepid, uint16 dtype, string dscr)
>
>                        Add a new entry in the HDP supported feature list with
>                        the role given in the MDEP id.
>
>                        If the new feature has the same data type as other
>                        previusly added feature for the same MDEP id, the old
>                        feature will be overwritten.
>
>                void Start()
>
>                        Starts the associated MCAP layer and set up the SDP
>                        registry with all supported features.
>
>                        Possible errors: org.bluez.Error.HdpError
>
>                object Connect(string btaddr)
>
>                        Connect with the device and returns the object path of
>                        the remote device.
>                        To call this method, the session must be started.
>
>                        Possible errors: org.bluez.Error.InvalidArguments
>                                         org.bluez.Error.HdpError
>
>                void Disconnect(object device, boolean delete)
>
>                        Disconnect from the remote device. If delete is true, any
>                        status will also be deleted. Otherwise, the status will
>                        be keeped for allowing future reconnections.
>                        To call this method, the session must be started.
>
>                        Possible errors: org.bluez.Error.InvalidArguments
>                                         org.bluez.Error.NotFound
>                                         org.bluez.Error.HdpError
>
> --------------------------------------------------------------------------------
>
> Service         org.bluez
> Interface       org.bluez.HdpDevice
> Object path     [variable prefix]/{hci0,hci1,...}/{hdp0,hdp1,...}/dev_XX_XX_XX_XX_XX_XX
>
>                boolean Echo(array{byte})
>
>                        Sends an echo petition to the remote device. Return True
>                        if response matches with the buffer sended. If some error
>                        is detected False value is returned and the associated
>                        MCL is closed.
>
>                uint16 OpenDc(byte mdepid, byte config)
>
>                        Creates a new data channel with the indicated config
>                        to the remote MCAP Data End Point (MDEP).
>                        The configuration should indicate the channel quality of
>                        service.
>                        Returns the data channel id.
>
>                        Possible errors: org.bluez.Error.InvalidArguments
>                                         org.bluez.Error.HdpError
>
>                file_descriptor GetDcFd(uint16 mdlid)
>
>                        Gets a file descriptor where data can be readed or
>                        writed for receive or sent by the data channel.
>                        Returns the file descriptor
>
>                        Possible errors: org.bluez.Error.InvalidArguments
>                                         org.bluez.Error.NotFound
>                                         org.bluez.Error.HdpError
>
>                void DeleteDc(uint16 mdlid)
>
>                        Deletes a data channel so it will not be available for
>                        use.
>
>                        Possible errors: org.bluez.Error.InvalidArguments
>                                         org.bluez.Error.NotFound
>                                         org.bluez.Error.HdpError
>
>                void DeleteAllDc()
>
>                        Deletes all data channels so it will not be available
>                        for use. Typically this function is called when the
>                        connection with the remote device will be closed
>                        permanently
>
>                        Possible errors: org.bluez.Error.HdpError
>
>                uint16 FirstRelDc()
>
>                        Returns the identificator of the first reliable data
>                        channel connected for this device.
>
>                        Possible errors: org.bluez.Error.HdpError
>
> HDPAgent hierarchy
> ==================
>
> Service         unique name
> Interface       org.bluez.HdpAgent
> Object path     freely definable
>
>                void DeviceConnected(object path)
>
>                        This method is called whenever a new device connection
>                        has been established over the control channel of the
>                        current HDP session. The objectpath contains the object
>                        path of the remote device.
>
>                void DeviceDisconnected(object path)
>
>                        This method is called when a remote device is
>                        disconnected definitively. Any future reconnections
>                        will fail. Also all data channels associated to this
>                        device will be closed.
>
>                void CreatedDc(object path, uint16 mdlid, filedescriptor fd)
>
>                        This method is called when a new data channel is created
>                        The path contains the object path of the device whith
>                        the new connection is created, the mdlid the data
>                        channel identificator and the fd is the file descriptor
>                        where the data can be readed or writed.
>
>                void DeletedDc(object path, uint16 mdlid)
>
>                        This method is called when a data channel is closed.
>                        After this call the data channel will not be valid and
>                        can be reused for future created data channels.
>
>                void DataReady(object path, uint16 mdlid, filedescriptor fd)
>
>                        This method is called when there is new data that can be
>                        readed in a data channel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

This sounds a little too complicated for me, my suggestion for you
guys is to first discuss a python script for the supported use cases
to figure out what is the best approach here, a tool written in C
would be nice too, so you will notice how much logic will got
duplicate if someone has to do the same thing as the script does. Also
I must say that this API goes against the design of our current 4.x
API, since it creates its own device representation.


-- 
Luiz Augusto von Dentz
Computer Engineer
