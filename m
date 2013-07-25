Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130725105530.GA9913@joana>
Date: Thu, 25 Jul 2013 07:51:49 -0700
Cc: =?iso-8859-1?Q?J=F6rg_Esser?= <jackfritt@boh.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <7132C3AA-597B-4209-A1B3-DC1E862C01BD@holtmann.org>
References: <51E7ED11.7010103@boh.de> <36A79410-3FA3-408F-BA16-6A30568A7035@holtmann.org> <51E8DBFF.4060702@boh.de> <5BE2601B-7C94-4C24-AB9B-EF187CAD9098@holtmann.org> <20130719162051.GA7373@x220.p-661hnu-f1> <51ECDB03.8090109@boh.de> <4A86B920-6A47-4E2D-8F6F-90A626CFC878@holtmann.org> <20130723233902.GA7835@x220.p-661hnu-f1> <51F0EB89.3050004@boh.de> <20130725105530.GA9913@joana>
To: Gustavo Padovan <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>>>>>>>>> HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.043811
>>>>>>>>     Read Local Version Information (0x04|0x0001) ncmd 1
>>>>>>>>       Status: Success (0x00)
>>>>>>>>       HCI version: 2 - 0x2006
>>>>>>>>       LMP version: 2 - 0x1806
>>>>>>>>       Manufacturer: AVM Berlin (31)
>>>>>>> it declares itself here as Bluetooth 1.2 device. Which means it is the
>>>>>>> second generation of BlueFritz! USB device.
>>>>>>> 
>>>>>>> <snip>
>>>>>>> 
>>>>>>>> < HCI Command: Read Local Supported Comm.. (0x04|0x0002) plen 0 [hci0] 0.210014
>>>>>>>>> HCI Event: Command Status (0x0f) plen 4 [hci0] 0.217361
>>>>>>>>     Read Local Supported Commands (0x04|0x0002) ncmd 1
>>>>>>>>       Status: Unknown HCI Command (0x01)
>>>>>>> And here is your failing command. Newer kernels have been strict with
>>>>>>> failing commands and will just abort the setup if anything goes wrong.
>>>>>>> 
>>>>>>> Johan, we need to figure out on how to work around this one. Might
>>>>>>> just match for the manufacturer before sending the command.
>>>>>> Either that or a quirk based on the USB id. Wouldn't matching just the
>>>>>> manufacturer be a bit problematic for any newer chips from this company,
>>>>>> or they stopped doing Bluetooth dongles after this one?
>>>>> They stopped doing Bluetooth dongles after this one. I found no more
>>>>> Product with bluetooth on their website.
>>>>> The support from AVM endet on 01.12.2009.
>>>>> As I read herehttp://www.wehavemorefun.de/fritzbox/BlueFRITZ!_USB
>>>> yes, they ever only made two products. And their baseband was based on
>>>> Silicon Wave which actually got bought by Qualcomm if I remember this
>>>> correctly. So going by the manufacturer id and adding a good comment
>>>> into the code might make this work nicely again.
>>>> 
>>>> Johan, if you prefer a quirk, then go for that one.
>>> Since we know that these are the only pieces of hardware that exist with
>>> this manufacturer id I think it's simplest to just use that instead of
>>> creating more code for this.
>>> 
>>> Attached is a patch that still needs to be tested. It might e.g. reveal
>>> other commands that also fail with this hardware.
>>> 
>>> Johan
>> After appling your patch I can use the adapter.
>> syslog says:
>> Jul 24 16:21:31 debian-capi kernel: [  153.864308] usb 1-3: new
>> full-speed USB device number 4 using ohci_hcd
>> Jul 24 16:21:31 debian-capi kernel: [  154.120244] usb 1-3: New USB
>> device found, idVendor=057c, idProduct=3800
>> Jul 24 16:21:31 debian-capi kernel: [  154.120251] usb 1-3: New USB
>> device strings: Mfr=1, Product=2, SerialNumber=3
>> Jul 24 16:21:31 debian-capi kernel: [  154.120254] usb 1-3: Product:
>> Bluetooth Device
>> Jul 24 16:21:31 debian-capi kernel: [  154.120257] usb 1-3:
>> Manufacturer: Bluetooth Device
>> Jul 24 16:21:31 debian-capi kernel: [  154.120260] usb 1-3:
>> SerialNumber: CC1C8D0E0400
>> Jul 24 16:21:31 debian-capi bluetoothd[2203]: HCI dev 0 registered
>> Jul 24 16:21:31 debian-capi bluetoothd[2203]: Listening for HCI
>> events on hci0
>> Jul 24 16:21:31 debian-capi kernel: [  154.149949] usbcore:
>> registered new interface driver btusb
>> Jul 24 16:21:31 debian-capi bluetoothd[2203]: HCI dev 0 up
>> Jul 24 16:21:31 debian-capi bluetoothd[2203]: Proximity GATT
>> Reporter Driver: Operation not permitted (1)
>> Jul 24 16:21:31 debian-capi bluetoothd[2203]: Unable to load keys to
>> adapter_ops: Function not implemented (38)
>> Jul 24 16:21:31 debian-capi bluetoothd[2203]: Adapter
>> /org/bluez/2203/hci0 has been enabled
>> 
>> after scanning with hcitool scan, it finds my BT Speaker
>> btmon says:
>> 
>> btmon
>> Bluetooth monitor ver 5.7
>> = New Index: 00:00:00:00:00:00 (BR/EDR,USB,hci0) [hci0] 0.767719
>> < HCI Command: Reset (0x03|0x0003) plen 0 [hci0] 0.773725
>>> HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.781039
>>      Reset (0x03|0x0003) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: Read Local Supported Fea.. (0x04|0x0003) plen 0
>> [hci0] 0.781774
>>> HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.785505
>>      Read Local Supported Features (0x04|0x0003) ncmd 1
>>        Status: Success (0x00)
>>        Features: 0xff 0xff 0x05 0x00 0x18 0x18 0x00 0x00
>>          3 slot packets
>>          5 slot packets
>>          Encryption
>>          Slot offset
>>          Timing accuracy
>>          Role switch
>>          Hold mode
>>          Sniff mode
>>          Park state
>>          Power control requests
>>          Channel quality driven data rate (CQDDR)
>>          SCO link
>>          HV2 packets
>>          HV3 packets
>>          u-law log synchronous data
>>          A-law log synchronous data
>>          CVSD synchronous data
>>          Power control
>>          AFH capable slave
>>          AFH classification slave
>>          AFH capable master
>>          AFH classification master
>> < HCI Command: Read Local Version Infor.. (0x04|0x0001) plen 0
>> [hci0] 0.785575
>>> HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.788286
>>      Read Local Version Information (0x04|0x0001) ncmd 1
>>        Status: Success (0x00)
>>        HCI version: 2 - 0x2006
>>        LMP version: 2 - 0x1806
>>        Manufacturer: AVM Berlin (31)
>> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0 [hci0] 0.788360
>>> HCI Event: Command Complete (0x0e) plen 10 [hci0] 0.791218
>>      Read BD ADDR (0x04|0x0009) ncmd 1
>>        Status: Success (0x00)
>>        Address: 00:04:0E:8D:1C:CC (OUI 00-04-0E)
>> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0 [hci0] 0.791858
>>> HCI Event: Command Complete (0x0e) plen 11 [hci0] 0.794638
>>      Read Buffer Size (0x04|0x0005) ncmd 1
>>        Status: Success (0x00)
>>        ACL MTU: 120  ACL max packet: 20
>>        SCO MTU: 24   SCO max packet: 5
>> < HCI Command: Read Class of Device (0x03|0x0023) plen 0 [hci0] 0.794704
>>> HCI Event: Command Complete (0x0e) plen 7 [hci0] 0.798330
>>      Read Class of Device (0x03|0x0023) ncmd 1
>>        Status: Success (0x00)
>>        Class: 0x000000
>>          Major class: Miscellaneous
>>          Minor class: 0x00
>> < HCI Command: Read Local Name (0x03|0x0014) plen 0 [hci0] 0.798394
>>> HCI Event: Command Complete (0x0e) plen 252 [hci0] 0.836309
>>      Read Local Name (0x03|0x0014) ncmd 1
>>        Status: Success (0x00)
>>        Name:
>> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0 [hci0] 0.836479
>>> HCI Event: Command Complete (0x0e) plen 6 [hci0] 0.839240
>>      Read Voice Setting (0x03|0x0025) ncmd 1
>>        Status: Success (0x00)
>>        Setting: 0x0060
>> < HCI Command: Set Event Filter (0x03|0x0005) plen 1 [hci0] 0.839409
>>        Type: 0x00
>>> HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.842197
>>      Set Event Filter (0x03|0x0005) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: Write Connection Accept... (0x03|0x0016) plen 2
>> [hci0] 0.842365
>>        Timeout: 20000.000 msec (0x7d00)
>>> HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.845015
>>      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0 [hci0] 0.845182
>>> HCI Event: Command Complete (0x0e) plen 8 [hci0] 0.849023
>>      Read Page Scan Activity (0x03|0x001b) ncmd 1
>>        Status: Success (0x00)
>>        Interval: 1280.000 msec (0x0800)
>>        Window: 11.250 msec (0x0012)
>> < HCI Command: Read Page Scan Type (0x03|0x0046) plen 0 [hci0] 0.849185
>>> HCI Event: Command Complete (0x0e) plen 5 [hci0] 0.853008
>>      Read Page Scan Type (0x03|0x0046) ncmd 1
>>        Status: Success (0x00)
>>        Type: Standard Scan (0x00)
>> < HCI Command: Set Event Mask (0x03|0x0001) plen 8 [hci0] 0.853166
>>        Mask: 0x00001807fffbffff
>>          Inquiry Complete
>>          Inquiry Result
>>          Connection Complete
>>          Connection Request
>>          Disconnection Complete
>>          Authentication Complete
>>          Remote Name Request Complete
>>          Encryption Change
>>          Change Connection Link Key Complete
>>          Master Link Key Complete
>>          Read Remote Supported Features Complete
>>          Read Remote Version Information Complete
>>          QoS Setup Complete
>>          Command Complete
>>          Command Status
>>          Hardware Error
>>          Flush Occurred
>>          Role Change
>>          Mode Change
>>          Return Link Keys
>>          PIN Code Request
>>          Link Key Request
>>          Link Key Notification
>>          Loopback Command
>>          Data Buffer Overflow
>>          Max Slots Change
>>          Read Clock Offset Complete
>>          Connection Packet Type Changed
>>          QoS Violation
>>          Page Scan Mode Change
>>          Page Scan Repetition Mode Change
>>          Flow Specification Complete
>>          Inquiry Result with RSSI
>>          Read Remote Extended Features Complete
>>          Synchronous Connection Complete
>>          Synchronous Connection Changed
>>> HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.857379
>>      Set Event Mask (0x03|0x0001) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: Write Page Timeout (0x03|0x0018) plen 2 [hci0] 0.858038
>>        Timeout: 5120.000 msec (0x2000)
>>> HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.859862
>>      Write Page Timeout (0x03|0x0018) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: Read Stored Link Key (0x03|0x000d) plen 7 [hci0] 0.859932
>>        Address: 00:00:00:00:00:00 (OUI 00-00-00)
>>        Read all: 0x01
>>> HCI Event: Command Complete (0x0e) plen 8 [hci0] 0.863627
>>      Read Stored Link Key (0x03|0x000d) ncmd 1
>>        Status: Success (0x00)
>>        Max num keys: 8
>>        Num keys: 0
>> < HCI Command: Write Local Name (0x03|0x0013) plen 248 [hci0] 0.882030
>>        Name: debian-capi-0
>>> HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.885847
>>      Write Local Name (0x03|0x0013) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: Set Event Mask (0x03|0x0001) plen 8 [hci0] 0.917369
>>        Mask: 0x00001807fffbffff
>>          Inquiry Complete
>>          Inquiry Result
>>          Connection Complete
>>          Connection Request
>>          Disconnection Complete
>>          Authentication Complete
>>          Remote Name Request Complete
>>          Encryption Change
>>          Change Connection Link Key Complete
>>          Master Link Key Complete
>>          Read Remote Supported Features Complete
>>          Read Remote Version Information Complete
>>          QoS Setup Complete
>>          Command Complete
>>          Command Status
>>          Hardware Error
>>          Flush Occurred
>>          Role Change
>>          Mode Change
>>          Return Link Keys
>>          PIN Code Request
>>          Link Key Request
>>          Link Key Notification
>>          Loopback Command
>>          Data Buffer Overflow
>>          Max Slots Change
>>          Read Clock Offset Complete
>>          Connection Packet Type Changed
>>          QoS Violation
>>          Page Scan Mode Change
>>          Page Scan Repetition Mode Change
>>          Flow Specification Complete
>>          Inquiry Result with RSSI
>>          Read Remote Extended Features Complete
>>          Synchronous Connection Complete
>>          Synchronous Connection Changed
>>> HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.924343
>>      Set Event Mask (0x03|0x0001) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: Write Default Link Polic.. (0x02|0x000f) plen 2
>> [hci0] 0.924523
>>        Link policy: 0x000f
>>> HCI Event: Command Status (0x0f) plen 4 [hci0] 0.928050
>>      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
>>        Status: Unknown HCI Command (0x01)
>> < HCI Command: Write Class of Device (0x03|0x0024) plen 3 [hci0] 0.928289
>>        Class: 0x6e0100
>>          Major class: Computer (desktop, notebook, PDA, organizers)
>>          Minor class: Uncategorized, code for device not assigned
>>          Networking (LAN, Ad hoc)
>>          Rendering (Printing, Speaker)
>>          Capturing (Scanner, Microphone)
>>          Audio (Speaker, Microphone, Headset)
>>          Telephony (Cordless telephony, Modem, Headset)
>>> HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.931044
>>      Write Class of Device (0x03|0x0024) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1 [hci0] 0.931274
>>        Scan enable: Page Scan (0x02)
>>> HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.934042
>>      Write Scan Enable (0x03|0x001a) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: Read Local Name (0x03|0x0014) plen 0 [hci0] 0.934286
>> @ New Settings: 0x0093
>>            powered connectable pairable br/edr
>>> HCI Event: Command Complete (0x0e) plen 252 [hci0] 0.974894
>>      Read Local Name (0x03|0x0014) ncmd 1
>>        Status: Success (0x00)
>>        Name: debian-capi-0
>> < HCI Command: Read Scan Enable (0x03|0x0019) plen 0 [hci0] 0.975018
>>> HCI Event: Command Complete (0x0e) plen 5 [hci0] 0.978549
>>      Read Scan Enable (0x03|0x0019) ncmd 1
>>        Status: Success (0x00)
>>        Scan enable: Page Scan (0x02)
>> < HCI Command: Inquiry (0x01|0x0001) plen 5 [hci0] 159.025599
>>        Access code: 0x9e8b33 (General Inquiry)
>>        Length: 10.24s (0x08)
>>        Num responses: 0
>>> HCI Event: Command Status (0x0f) plen 4 [hci0] 159.033290
>>      Inquiry (0x01|0x0001) ncmd 1
>>        Status: Success (0x00)
>> @ Discovering: 0x01 (0)
>>> HCI Event: Inquiry Result (0x02) plen 15 [hci0] 165.868687
>>        Num responses: 1
>>        Address: A0:E9:DB:00:B5:BB (OUI A0-E9-DB)
>>        Page scan repetition mode: R1 (0x01)
>>        Page period mode: P2 (0x02)
>>        Page scan mode: Mandatory (0x00)
>>        Class: 0x240404
>>          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
>>          Minor class: 0x01
>>          Rendering (Printing, Speaker)
>>          Audio (Speaker, Microphone, Headset)
>>        Clock offset: 0x14a9
>> @ Device Found: A0:E9:DB:00:B5:BB (0) rssi 0 flags 0x0003
>>        04 0d 04 04 24                                   ....$
>>> HCI Event: Inquiry Complete (0x01) plen 1 [hci0] 169.281636
>>        Status: Success (0x00)
>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10 [hci0] 169.282228
>>        Address: A0:E9:DB:00:B5:BB (OUI A0-E9-DB)
>>        Page scan repetition mode: R1 (0x01)
>>        Page scan mode: Mandatory (0x00)
>>        Clock offset: 0x94a9
>>> HCI Event: Command Status (0x0f) plen 4 [hci0] 169.288567
>>      Remote Name Request (0x01|0x0019) ncmd 1
>>        Status: Success (0x00)
>>> HCI Event: Remote Name Req Complete (0x07) plen 255 [hci0] 169.877365
>>        Status: Success (0x00)
>>        Address: A0:E9:DB:00:B5:BB (OUI A0-E9-DB)
>>        Name: RAIKKO BT Speaker
>> 
>> 
>> Playing Audio with
>> mplayer -ao alsa:device=btheadset 05N\ The\ Race\ -\ .mp3
>> 
>> Also works nicely. Let me know if I should test anything else.
>> 
>> Thx for this good and fast support.
> 
> Patch has been applied to bluetooth.git. Thanks everyone.

can you please explain to me why the important part of the btmon trace is not part of the commit message. I mentioned this before that patches that go in after the merge window closes especially are suppose to have as much information as possible and we should record as much information about the bug as possible.

If I ever want to figure out with what error code the BlueFritz! failed this command, I have to dig into the mailing list archive to hopefully find it. This is all silly. We can be plenty verbose in the commit messages. And you as maintainer need to enforce this.

Since Johan send this as a test patch, this is a bit premature to just apply it. You could have at least waited until he send a dedicated patch and me complaining that the btmon trace was missing in the commit message. I am so not happy about just applying this patch and sending out a pull request minutes later.

Regards

Marcel

