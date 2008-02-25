Return-Path: <cyrus@holtmann.org>
Message-ID: <d5d240eb0802242209m24c8d228m135896dae55b4a4c@mail.gmail.com>
Date: Mon, 25 Feb 2008 11:39:58 +0530
From: "rohit puri" <rohitpuri.rohit@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <200802231738.51656.Jens-E.Hansen@gis.de>
MIME-Version: 1.0
References: <200802231738.51656.Jens-E.Hansen@gis.de>
Subject: Re: [Bluez-users] ad-47w Cambridge Silicon Radio not recognized
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0813087965=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0813087965==
Content-Type: multipart/alternative;
	boundary="----=_Part_8139_28518017.1203919798472"

------=_Part_8139_28518017.1203919798472
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi jens

You should run the command "hciconfig hci0 up"

Regards
Rohit

On Sat, Feb 23, 2008 at 10:08 PM, Jens-Erik Hansen <Jens-E.Hansen@gis.de>
wrote:

> Hello,
>
> I'm trying to get a nokia ad-47w bluetooth dongle recognized by bluez but
> hcitool scan says that there is no device available. I'm a bit surprised
> by
> that because another cambridge silicon radio based dongle (SHB6101
> manufacured by philips) works with bluez.
>
> Unfortunately searching the web was of no avail, so maybe someone on the
> list
> can give me a hint how to get the nokia dongle working with a 2.6.23kernel.
>
>
> Greetings
> Jens
>
>
>
> The output from lsusb -v shows:
>
> Bus 001 Device 007: ID 0a12:1004 Cambridge Silicon Radio, Ltd
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               2.00
>  bDeviceClass            0 (Defined at Interface level)
>  bDeviceSubClass         0
>  bDeviceProtocol         0
>  bMaxPacketSize0        64
>  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
>  idProduct          0x1004
>  bcdDevice           28.77
>  iManufacturer           0
>  iProduct                2 Nokia Wireless Audio Adapter
>  iSerial                 0
>  bNumConfigurations      1
>  Configuration Descriptor:
>    bLength                 9
>    bDescriptorType         2
>    wTotalLength          125
>    bNumInterfaces          3
>    bConfigurationValue     1
>    iConfiguration          0
>    bmAttributes         0x80
>      (Bus Powered)
>    MaxPower              100mA
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        0
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      1 Control Device
>      bInterfaceProtocol      0
>      iInterface              0
>      AudioControl Interface Descriptor:
>        bLength                 9
>        bDescriptorType        36
>        bDescriptorSubtype      1 (HEADER)
>        bcdADC               1.00
>        wTotalLength           30
>        bInCollection           1
>        baInterfaceNr( 0)       1
>      AudioControl Interface Descriptor:
>        bLength                12
>        bDescriptorType        36
>        bDescriptorSubtype      2 (INPUT_TERMINAL)
>        bTerminalID             1
>        wTerminalType      0x0101 USB Streaming
>        bAssocTerminal          0
>        bNrChannels             2
>        wChannelConfig     0x0003
>          Left Front (L)
>          Right Front (R)
>        iChannelNames           0
>        iTerminal               2 Nokia Wireless Audio Adapter
>      AudioControl Interface Descriptor:
>        bLength                 9
>        bDescriptorType        36
>        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>        bTerminalID             2
>        wTerminalType      0x0302 Headphones
>        bAssocTerminal          0
>        bSourceID               1
>         iTerminal               2 Nokia Wireless Audio Adapter
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       1
>      bNumEndpoints           1
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>      AudioStreaming Interface Descriptor:
>        bLength                 7
>        bDescriptorType        36
>        bDescriptorSubtype      1 (AS_GENERAL)
>        bTerminalLink           1
>        bDelay                  0 frames
>        wFormatTag              1 PCM
>      AudioStreaming Interface Descriptor:
>        bLength                11
>        bDescriptorType        36
>        bDescriptorSubtype      2 (FORMAT_TYPE)
>        bFormatType             1 (FORMAT_TYPE_I)
>        bNrChannels             2
>        bSubframeSize           2
>        bBitResolution         16
>        bSamFreqType            1 Discrete
>        tSamFreq[ 0]        48000
>      ** UNRECOGNIZED:  07 25 01 81 02 00 00
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x03  EP 3 OUT
>        bmAttributes            1
>          Transfer Type            Isochronous
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x00c0  1x 192 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        2
>      bAlternateSetting       0
>      bNumEndpoints           1
>      bInterfaceClass         3 Human Interface Device
>      bInterfaceSubClass      0 No Subclass
>      bInterfaceProtocol      0 None
>      iInterface              0
>        HID Device Descriptor:
>          bLength                 9
>          bDescriptorType        33
>          bcdHID               1.11
>          bCountryCode            0 Not supported
>          bNumDescriptors         1
>          bDescriptorType        34 Report
>          wDescriptorLength      48
>          Report Descriptor: (length is 48)
>            Item(Global): Usage Page, data= [ 0x0c ] 12
>                            Consumer
>            Item(Local ): Usage, data= [ 0x01 ] 1
>                            Consumer Control
>            Item(Main  ): Collection, data= [ 0x01 ] 1
>                            Application
>            Item(Global): Usage Page, data= [ 0x0c ] 12
>                            Consumer
>            Item(Global): Logical Minimum, data= [ 0x00 ] 0
>            Item(Global): Logical Maximum, data= [ 0x01 ] 1
>            Item(Local ): Usage, data= [ 0xcd ] 205
>                            Play/Pause
>            Item(Local ): Usage, data= [ 0xb5 ] 181
>                            Scan Next Track
>            Item(Local ): Usage, data= [ 0xb6 ] 182
>                            Scan Previous Track
>            Item(Local ): Usage, data= [ 0xb7 ] 183
>                            Stop
>            Item(Local ): Usage, data= [ 0xb3 ] 179
>                            Fast Forward
>            Item(Local ): Usage, data= [ 0xb4 ] 180
>                            Rewind
>            Item(Global): Report Size, data= [ 0x01 ] 1
>            Item(Global): Report Count, data= [ 0x06 ] 6
>            Item(Main  ): Input, data= [ 0x02 ] 2
>                            Data Variable Absolute No_Wrap Linear
>                            Preferred_State No_Null_Position Non_Volatile
> Bitfield
>            Item(Global): Report Size, data= [ 0x01 ] 1
>            Item(Global): Report Count, data= [ 0x02 ] 2
>            Item(Main  ): Input, data= [ 0x01 ] 1
>                            Constant Array Absolute No_Wrap Linear
>                            Preferred_State No_Null_Position Non_Volatile
> Bitfield
>            Item(Global): Usage Page, data= [ 0x00 0xff ] 65280
>                            (null)
>            Item(Local ): Usage, data= [ 0x01 ] 1
>                            (null)
>            Item(Global): Report Count, data= [ 0x01 ] 1
>            Item(Global): Report Size, data= [ 0x40 ] 64
>            Item(Main  ): Feature, data= [ 0x02 ] 2
>                            Data Variable Absolute No_Wrap Linear
>                            Preferred_State No_Null_Position Non_Volatile
> Bitfield
>            Item(Main  ): End Collection, data=none
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x81  EP 1 IN
>        bmAttributes            3
>          Transfer Type            Interrupt
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0010  1x 16 bytes
>        bInterval               1
> Device Status:     0x0000
>  (Bus Powered)
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_8139_28518017.1203919798472
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi jens<br><br>You should run the command &quot;hciconfig hci0 up&quot;<br><br>Regards<br>Rohit<br><br><div class="gmail_quote">On Sat, Feb 23, 2008 at 10:08 PM, Jens-Erik Hansen &lt;<a href="mailto:Jens-E.Hansen@gis.de">Jens-E.Hansen@gis.de</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello,<br>
<br>
I&#39;m trying to get a nokia ad-47w bluetooth dongle recognized by bluez but<br>
hcitool scan says that there is no device available. I&#39;m a bit surprised by<br>
that because another cambridge silicon radio based dongle (SHB6101<br>
manufacured by philips) works with bluez.<br>
<br>
Unfortunately searching the web was of no avail, so maybe someone on the list<br>
can give me a hint how to get the nokia dongle working with a 2.6.23 kernel.<br>
<br>
<br>
Greetings<br>
Jens<br>
<br>
<br>
<br>
The output from lsusb -v shows:<br>
<br>
Bus 001 Device 007: ID 0a12:1004 Cambridge Silicon Radio, Ltd<br>
Device Descriptor:<br>
 &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;18<br>
 &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp;bcdUSB &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2.00<br>
 &nbsp;bDeviceClass &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 (Defined at Interface level)<br>
 &nbsp;bDeviceSubClass &nbsp; &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp;bDeviceProtocol &nbsp; &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp;bMaxPacketSize0 &nbsp; &nbsp; &nbsp; &nbsp;64<br>
 &nbsp;idVendor &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0a12 Cambridge Silicon Radio, Ltd<br>
 &nbsp;idProduct &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x1004<br>
 &nbsp;bcdDevice &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 28.77<br>
 &nbsp;iManufacturer &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp;iProduct &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2 Nokia Wireless Audio Adapter<br>
 &nbsp;iSerial &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp;bNumConfigurations &nbsp; &nbsp; &nbsp;1<br>
 &nbsp;Configuration Descriptor:<br>
 &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9<br>
 &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp; 2<br>
 &nbsp; &nbsp;wTotalLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;125<br>
 &nbsp; &nbsp;bNumInterfaces &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;3<br>
 &nbsp; &nbsp;bConfigurationValue &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp;iConfiguration &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp;bmAttributes &nbsp; &nbsp; &nbsp; &nbsp; 0x80<br>
 &nbsp; &nbsp; &nbsp;(Bus Powered)<br>
 &nbsp; &nbsp;MaxPower &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;100mA<br>
 &nbsp; &nbsp;Interface Descriptor:<br>
 &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9<br>
 &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp; 4<br>
 &nbsp; &nbsp; &nbsp;bInterfaceNumber &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp;bAlternateSetting &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp; &nbsp; &nbsp;bNumEndpoints &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp; &nbsp; &nbsp;bInterfaceClass &nbsp; &nbsp; &nbsp; &nbsp; 1 Audio<br>
 &nbsp; &nbsp; &nbsp;bInterfaceSubClass &nbsp; &nbsp; &nbsp;1 Control Device<br>
 &nbsp; &nbsp; &nbsp;bInterfaceProtocol &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp;iInterface &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp;AudioControl Interface Descriptor:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp;36<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorSubtype &nbsp; &nbsp; &nbsp;1 (HEADER)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bcdADC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1.00<br>
 &nbsp; &nbsp; &nbsp; &nbsp;wTotalLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 30<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bInCollection &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp;baInterfaceNr( 0) &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp;AudioControl Interface Descriptor:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;12<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp;36<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorSubtype &nbsp; &nbsp; &nbsp;2 (INPUT_TERMINAL)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bTerminalID &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp;wTerminalType &nbsp; &nbsp; &nbsp;0x0101 USB Streaming<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bAssocTerminal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bNrChannels &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2<br>
 &nbsp; &nbsp; &nbsp; &nbsp;wChannelConfig &nbsp; &nbsp; 0x0003<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Left Front (L)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Right Front (R)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;iChannelNames &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp; &nbsp; &nbsp; &nbsp;iTerminal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2 Nokia Wireless Audio Adapter<br>
 &nbsp; &nbsp; &nbsp;AudioControl Interface Descriptor:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp;36<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorSubtype &nbsp; &nbsp; &nbsp;3 (OUTPUT_TERMINAL)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bTerminalID &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2<br>
 &nbsp; &nbsp; &nbsp; &nbsp;wTerminalType &nbsp; &nbsp; &nbsp;0x0302 Headphones<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bAssocTerminal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bSourceID &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; iTerminal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2 Nokia Wireless Audio Adapter<br>
 &nbsp; &nbsp;Interface Descriptor:<br>
 &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9<br>
 &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp; 4<br>
 &nbsp; &nbsp; &nbsp;bInterfaceNumber &nbsp; &nbsp; &nbsp; &nbsp;1<br>
 &nbsp; &nbsp; &nbsp;bAlternateSetting &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp; &nbsp; &nbsp;bNumEndpoints &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp; &nbsp; &nbsp;bInterfaceClass &nbsp; &nbsp; &nbsp; &nbsp; 1 Audio<br>
 &nbsp; &nbsp; &nbsp;bInterfaceSubClass &nbsp; &nbsp; &nbsp;2 Streaming<br>
 &nbsp; &nbsp; &nbsp;bInterfaceProtocol &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp;iInterface &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp;Interface Descriptor:<br>
 &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9<br>
 &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp; 4<br>
 &nbsp; &nbsp; &nbsp;bInterfaceNumber &nbsp; &nbsp; &nbsp; &nbsp;1<br>
 &nbsp; &nbsp; &nbsp;bAlternateSetting &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp;bNumEndpoints &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp;bInterfaceClass &nbsp; &nbsp; &nbsp; &nbsp; 1 Audio<br>
 &nbsp; &nbsp; &nbsp;bInterfaceSubClass &nbsp; &nbsp; &nbsp;2 Streaming<br>
 &nbsp; &nbsp; &nbsp;bInterfaceProtocol &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp;iInterface &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp;AudioStreaming Interface Descriptor:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 7<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp;36<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorSubtype &nbsp; &nbsp; &nbsp;1 (AS_GENERAL)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bTerminalLink &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDelay &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 frames<br>
 &nbsp; &nbsp; &nbsp; &nbsp;wFormatTag &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1 PCM<br>
 &nbsp; &nbsp; &nbsp;AudioStreaming Interface Descriptor:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;11<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp;36<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorSubtype &nbsp; &nbsp; &nbsp;2 (FORMAT_TYPE)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bFormatType &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1 (FORMAT_TYPE_I)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bNrChannels &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bSubframeSize &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bBitResolution &nbsp; &nbsp; &nbsp; &nbsp; 16<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bSamFreqType &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1 Discrete<br>
 &nbsp; &nbsp; &nbsp; &nbsp;tSamFreq[ 0] &nbsp; &nbsp; &nbsp; &nbsp;48000<br>
 &nbsp; &nbsp; &nbsp;** UNRECOGNIZED: &nbsp;07 25 01 81 02 00 00<br>
 &nbsp; &nbsp; &nbsp;Endpoint Descriptor:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp; 5<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bEndpointAddress &nbsp; &nbsp; 0x03 &nbsp;EP 3 OUT<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bmAttributes &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Transfer Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Isochronous<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Synch Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; None<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Usage Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Data<br>
 &nbsp; &nbsp; &nbsp; &nbsp;wMaxPacketSize &nbsp; &nbsp; 0x00c0 &nbsp;1x 192 bytes<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bInterval &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bRefresh &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bSynchAddress &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp; &nbsp;Interface Descriptor:<br>
 &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9<br>
 &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp; 4<br>
 &nbsp; &nbsp; &nbsp;bInterfaceNumber &nbsp; &nbsp; &nbsp; &nbsp;2<br>
 &nbsp; &nbsp; &nbsp;bAlternateSetting &nbsp; &nbsp; &nbsp; 0<br>
 &nbsp; &nbsp; &nbsp;bNumEndpoints &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp;bInterfaceClass &nbsp; &nbsp; &nbsp; &nbsp; 3 Human Interface Device<br>
 &nbsp; &nbsp; &nbsp;bInterfaceSubClass &nbsp; &nbsp; &nbsp;0 No Subclass<br>
 &nbsp; &nbsp; &nbsp;bInterfaceProtocol &nbsp; &nbsp; &nbsp;0 None<br>
 &nbsp; &nbsp; &nbsp;iInterface &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &nbsp; &nbsp; &nbsp; &nbsp;HID Device Descriptor:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp;33<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bcdHID &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1.11<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bCountryCode &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 Not supported<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bNumDescriptors &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp;34 Report<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;wDescriptorLength &nbsp; &nbsp; &nbsp;48<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Report Descriptor: (length is 48)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Usage Page, data= [ 0x0c ] 12<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Consumer<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Local ): Usage, data= [ 0x01 ] 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Consumer Control<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Main &nbsp;): Collection, data= [ 0x01 ] 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Application<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Usage Page, data= [ 0x0c ] 12<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Consumer<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Logical Minimum, data= [ 0x00 ] 0<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Logical Maximum, data= [ 0x01 ] 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Local ): Usage, data= [ 0xcd ] 205<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Play/Pause<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Local ): Usage, data= [ 0xb5 ] 181<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Scan Next Track<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Local ): Usage, data= [ 0xb6 ] 182<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Scan Previous Track<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Local ): Usage, data= [ 0xb7 ] 183<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Stop<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Local ): Usage, data= [ 0xb3 ] 179<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Fast Forward<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Local ): Usage, data= [ 0xb4 ] 180<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Rewind<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Report Size, data= [ 0x01 ] 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Report Count, data= [ 0x06 ] 6<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Main &nbsp;): Input, data= [ 0x02 ] 2<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Data Variable Absolute No_Wrap Linear<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Preferred_State No_Null_Position Non_Volatile<br>
Bitfield<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Report Size, data= [ 0x01 ] 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Report Count, data= [ 0x02 ] 2<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Main &nbsp;): Input, data= [ 0x01 ] 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Constant Array Absolute No_Wrap Linear<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Preferred_State No_Null_Position Non_Volatile<br>
Bitfield<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Usage Page, data= [ 0x00 0xff ] 65280<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(null)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Local ): Usage, data= [ 0x01 ] 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(null)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Report Count, data= [ 0x01 ] 1<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Global): Report Size, data= [ 0x40 ] 64<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Main &nbsp;): Feature, data= [ 0x02 ] 2<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Data Variable Absolute No_Wrap Linear<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Preferred_State No_Null_Position Non_Volatile<br>
Bitfield<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Item(Main &nbsp;): End Collection, data=none<br>
 &nbsp; &nbsp; &nbsp;Endpoint Descriptor:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bLength &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 7<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bDescriptorType &nbsp; &nbsp; &nbsp; &nbsp; 5<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bEndpointAddress &nbsp; &nbsp; 0x81 &nbsp;EP 1 IN<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bmAttributes &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;3<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Transfer Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Interrupt<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Synch Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; None<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Usage Type &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Data<br>
 &nbsp; &nbsp; &nbsp; &nbsp;wMaxPacketSize &nbsp; &nbsp; 0x0010 &nbsp;1x 16 bytes<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bInterval &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
Device Status: &nbsp; &nbsp; 0x0000<br>
 &nbsp;(Bus Powered)<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br>

------=_Part_8139_28518017.1203919798472--


--===============0813087965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0813087965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0813087965==--
