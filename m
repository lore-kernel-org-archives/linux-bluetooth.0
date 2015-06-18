Return-Path: <cyrus@holtmann.org>
Message-ID: <55823473.8040400@battlepenguin.com>
Date: Thu, 18 Jun 2015 11:01:07 +0800
From: Sumit's Mailing Lists <lists@battlepenguin.com>
MIME-Version: 1.0
To: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 "Huang, Rick" <rickh@qti.qualcomm.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: ath3k Bluetooth adapter not loading: [0cf3:3004] Atheros Communications,
 Inc. AR3012 Bluetooth 4.0
References: <556486B0.1020104@battlepenguin.com> <EEAFDBFC-C252-4843-A9E0-3E74EA21B665@holtmann.org> <557EBF98.2000701@battlepenguin.com> <A93AF220-83E9-4FC3-BC07-18B285E5FA3D@holtmann.org> <557EDE40.7070006@battlepenguin.com> <557F03E2.3000001@qca.qualcomm.com> <557F0FD2.7000000@battlepenguin.com> <55808CAB.3020205@qca.qualcomm.com> <55816C31.3050008@battlepenguin.com> <55816F6D.3030706@battlepenguin.com> <5581C269.5020401@qca.qualcomm.com>,<55822E92.60609@battlepenguin.com> <53369F14-1B95-40B4-AAB1-3181ED18CFD7@qca.qualcomm.com>
In-Reply-To: <53369F14-1B95-40B4-AAB1-3181ED18CFD7@qca.qualcomm.com>
Content-Type: multipart/alternative;
 boundary="------------080102070503050704020203"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080102070503050704020203
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 18/06/15 10:53, Kim, Ben Young Tae wrote:
> Hi Sumit,
>
> On Jun 17, 2015, at 7:36 PM, Sumit's Mailing Lists
> <lists@battlepenguin.com <mailto:lists@battlepenguin.com>> wrote:
>
>> On 18/06/15 02:54, Ben Young Tae Kim wrote:
>>> Hi Sumit,
>>>
>>> On 06/17/15 06:00, Sumit Khanna wrote:
>>>> On 17/06/15 20:46, Sumit's Mailing Lists wrote:
>>>>> On 17/06/15 04:52, Ben Young Tae Kim wrote:
>>>>>> Hi Sumit,
>>>>>>
>>>>>> On 06/15/15 10:48, Sumit's Mailing Lists wrote:
>>>>>>> On 16/06/15 00:57, Ben Young Tae Kim wrote:
>>>>>>>> Hi Sumit,
>>>>>>>>
>>>>>>>>
>>>>>>>> On 06/15/15 07:16, Sumit's Mailing Lists wrote:
>>>>>>>>> On 15/06/15 21:55, Marcel Holtmann wrote:
>>>>>>>>>> Hi Smuit,
>>>>>>>>>>
>>>>>>>>>>>>> I'm currently using an MSI WS60 laptop which contains the
>>>>>>>>>>>>> following
>>>>>>>>>>>>> Bluetooth controller (from lsusb):
>>>>>>>>>>>>>
>>>>>>>>>>>>> Bus 003 Device 003: ID 0cf3:3004 Atheros Communications,
>>>>>>>>>>>>> Inc. AR3012
>>>>>>>>>>>>> Bluetooth 4.0
>>>>>>>>>>>> assuming that the firmware is present, this is most likely
>>>>>>>>>>>> just missing the right VID/PID additions in the drivers.
>>>>>>>>>>>> Please prepare a patch for that.
>>>>>>>>>>>>
>>>>>>>>>>>>> and the more detailed version:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Bus 003 Device 003: ID 0cf3:3004 Atheros Communications,
>>>>>>>>>>>>> Inc. AR3012
>>>>>>>>>>>>> Bluetooth 4.0
>>>>>>>>>>>>> Device Descriptor:
>>>>>>>>>>>>> bLength                18
>>>>>>>>>>>>> bDescriptorType         1
>>>>>>>>>>>>> bcdUSB               1.10
>>>>>>>>>>>>> bDeviceClass          224 Wireless
>>>>>>>>>>>>> bDeviceSubClass         1 Radio Frequency
>>>>>>>>>>>>> bDeviceProtocol         1 Bluetooth
>>>>>>>>>>>>> bMaxPacketSize0        64
>>>>>>>>>>>>> idVendor           0x0cf3 Atheros Communications, Inc.
>>>>>>>>>>>>> idProduct          0x3004 AR3012 Bluetooth 4.0
>>>>>>>>>>>>> bcdDevice            0.01
>>>>>>>>>>>>> iManufacturer           0
>>>>>>>>>>>>> iProduct                0
>>>>>>>>>>>>> iSerial                 0
>>>>>>>>>>>>> bNumConfigurations      1
>>>>>>>>>>>>> Configuration Descriptor:
>>>>>>>>>>>> I actually prefer /sys/kernel/debug/usb/devices output for
>>>>>>>>>>>> the devices.
>>>>>>>>>>>>
>>>>>>>>>>>> Regards
>>>>>>>>>>>>
>>>>>>>>>>>> Marcel
>>>>>>>>>>>>
>>>>>>>>>>> Here is the output from /sys/kernel/debug/usb/devices for my
>>>>>>>>>>> ath3k (also
>>>>>>>>>>> added it to the kernel bugzilla):
>>>>>>>>>>>
>>>>>>>>>>> T:  Bus=03 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  3 Spd=12
>>>>>>>>>>>   MxCh= 0
>>>>>>>>>>> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>>>>>>>>>>> P:  Vendor=0cf3 ProdID=3004 Rev= 0.01
>>>>>>>>>>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>>>>>>>>>>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>> Driver=(none)
>>>>>>>>>>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>>>>>>>>>>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>>>>>>>>>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>>>>>>>>>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>> Driver=(none)
>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>>>>>>>>>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>> Driver=(none)
>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>>>>>>>>>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>> Driver=(none)
>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>>>>>>>>>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>> Driver=(none)
>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>>>>>>>>>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>> Driver=(none)
>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>>>>>>>>>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>> Driver=(none)
>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>>>>>>>>>>
>>>>>>>>>>> and the firmware the kernel is trying to load:
>>>>>>>>>>>
>>>>>>>>>>> [  762.729370] usb 3-1.3: Direct firmware load for
>>>>>>>>>>> ar3k/AthrBT_0x00000200.dfu failed with error -2
>>>>>>>>>>> [  762.729373] Bluetooth: Patch file not found
>>>>>>>>>>> ar3k/AthrBT_0x00000200.dfu
>>>>>>>>>>> [  762.729374] Bluetooth: Loading patch file failed
>>>>>>>>>>> [  762.729381] ath3k: probe of 3-1.3:1.0 failed with error -2
>>>>>>>>>>> [  762.729411] usbcore: registered new interface driver ath3k
>>>>>>>>>> I fail to see that firmware in linux-firmware tree. However
>>>>>>>>>> this up to Atheros / Qualcomm to submit there. I can not do
>>>>>>>>>> much about this.
>>>>>>>>>>
>>>>>>>>>> Regards
>>>>>>>>>>
>>>>>>>>>> Marcel
>>>>>>>>>>
>>>>>>>>> Marcel,
>>>>>>>>>
>>>>>>>>> So it's pulling the right firmware file for my device, but It just
>>>>>>>>> hasn't been released yet?
>>>>>>>>>
>>>>>>>>> I know with the Wi-Fi firmware, the ath10k devs had python
>>>>>>>>> scripts to
>>>>>>>>> extract the firmware binaries from the Windows drivers
>>>>>>>>> (mentioned in
>>>>>>>>> here
>>>>>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1383184). Has
>>>>>>>>> anyone done that before with the bluetooth firmware, or do you
>>>>>>>>> typically
>>>>>>>>> just wait for atheros/qualcom to release official ones?
>>>>>>>> Where did you get your atheros board/card since I couldn't find
>>>>>>>> that board here. Is it a laptop? The BT firmware driver was
>>>>>>>> trying to load AthrBT_0x00000200.dfu file and it got failed
>>>>>>>> because no firmware file was present. But 0x00000200 means
>>>>>>>> fw_version.rom_version which coming from controller chip,
>>>>>>>> however, I haven't seen this version on Atheros chipset.
>>>>>>>>
>>>>>>>> I'm adding my friend - Rick Huang here. He may help you out
>>>>>>>>
>>>>>>>> Hi Rick,
>>>>>>>>
>>>>>>>> Have you seen rom_version as 0x00000200?
>>>>>>>>
>>>>>>>>> Sumit
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>> linux-bluetooth" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> <mailto:majordomo@vger.kernel.org>
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>> Thanks
>>>>>>>> -- Ben Kim
>>>>>>>>
>>>>>>> Yes, It's an MSI WS-60 Laptop, purchased two months ago in
>>>>>>> Australia. Is
>>>>>>> there any other debugging information I need to pull for you?
>>>>>>>
>>>>>>> Sumit
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>> linux-bluetooth" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> <mailto:majordomo@vger.kernel.org>
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>> According to my colleague, it is not AR chip but QCA ROME core
>>>>>> inside even though they're sharing same VID/PID with AR/QCA
>>>>>> ROME(version 2). That's why you cannot bring up your card with
>>>>>> ath3k driver. I knew it was not a good idea as it was early stage
>>>>>> to develop the card so that next version of ROME USB card(v3.0 or
>>>>>> v3.2) will use different PID/VID as you can see below.
>>>>>>
>>>>>> Can you follow up these instructions to see whether or not it can
>>>>>> be addressed on your setup?
>>>>>>
>>>>>> --
>>>>>> 1. put this code in drivers/bluetooth/btusb.c
>>>>>>
>>>>>> static const struct usb_device_id blacklist_table[] = {
>>>>>> ...
>>>>>>    /* QCA ROME chipset */
>>>>>>    { USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
>>>>>>    { USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
>>>>>>    { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },
>>>>>> // <-- add new VID/PID here
>>>>>> ...
>>>>>>
>>>>>> 2. Copy firmware files into /lib/firmware/qca
>>>>>> - nvm_usb_00000200.bin
>>>>>> - rampatch_usb_00000200.bin
>>>>>> Those FW files won't be available on linux-firmware.git til today
>>>>>> but it it will be available soon I believe.
>>>>>> --
>>>>>>
>>>>>> Thanks
>>>>>> -- Ben Kim
>>>>>>
>>>>>>
>>>>>>
>>>>> Hi Ben,
>>>>>
>>>>> I added that line to my btusb.c; did a mrpropery, copied my
>>>>> .config back
>>>>> into the source tree, disabled ATH3K in menucofnig, made the
>>>>> bzImage and
>>>>> rebooted. The firmware you attached is in /lib/firmware/qca.
>>>>>
>>>>> I enabled debugging (FLAGS_btusb.o := -DDEBUG in the Makefile) so I
>>>>> could get some more info, and discovered I also have to delete
>>>>> this line
>>>>> or it will match the ath first:
>>>>>
>>>>> { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 }
>>>>>
>>>>> So then I saw
>>>>>
>>>>> [    1.263991] usb 3-1.3: new full-speed USB device number 3 using
>>>>> ehci-pci
>>>>> [    1.277022] usb 4-1.8: new full-speed USB device number 3 using
>>>>> ehci-pci
>>>>> [    1.350050] usb 3-1.3: New USB device found, idVendor=0cf3,
>>>>> idProduct=3004
>>>>> [    1.350051] usb 3-1.3: New USB device strings: Mfr=0, Product=0,
>>>>> SerialNumber=0
>>>>> [    1.350461] intf ffff88041bf62400 id ffffffff81d83bc0
>>>>> [    1.350462] BT Device Info 0
>>>>> [    1.350463] BT Device Info (after matching) 32768
>>>>> [    1.350466] In Rome Block
>>>>> [    1.350546] input: ETPS/2 Elantech Touchpad as
>>>>> /devices/platform/i8042/serio1/input/input10
>>>>> [    1.350671] hci0
>>>>> [    1.350879] Bluetooth: hci0: don't support firmware rome 0x200
>>>>> [    1.364795] usb 4-1.8: New USB device found, idVendor=1770,
>>>>> idProduct=ff00
>>>>> [    1.364797] usb 4-1.8: New USB device strings: Mfr=1, Product=1,
>>>>> SerialNumber=1
>>>>> [    1.364798] usb 4-1.8: Product: MSI EPF USB
>>>>> [    1.364799] usb 4-1.8: Manufacturer: MSI EPF USB
>>>>> [    1.364800] usb 4-1.8: SerialNumber: MSI EPF USB
>>>>>
>>>>> So those BT Device Info statements I added in the probe function. "In
>>>>> Rome Block" I added right after "if (id->driver_info &
>>>>> BTUSB_QCA_ROME) "
>>>>> and you can see where that error comes from.
>>>>>
>>>>> And that comes from...oh it checks another table...okay so I added the
>>>>> following to qca_device_info
>>>>>
>>>>>        { 0x00000200, 28, 4, 18 },
>>>>>
>>>>> and now I get;
>>>>>
>>>>> [    1.357942] intf ffff88041ba5bc00 id ffffffff81d83bc0
>>>>> [    1.357943] BT Device Info 0
>>>>> [    1.357944] BT Device Info (after matching) 32768
>>>>> [    1.357946] In Rome Block
>>>>> [    1.358113] hci0
>>>>> [    1.358516] bluetooth hci0: Direct firmware load for
>>>>> qca/rampatch_usb_00000200.bin failed with error -2
>>>>> [    1.358517] Bluetooth: hci0: failed to request rampatch file:
>>>>> qca/rampatch_usb_00000200.bin (-2)
>>>>>
>>>>> So progress. It's attempting to load the firmware and failing. Are
>>>>> those
>>>>> the right numbers for the device_info block?
>>>>>
>>>>> Sumit
>>>> Just remembered -2 is when it can't even find the firmware. But I think
>>>> I have it installed right. Is this correct:
>>>>
>>>> catelyn linux # ls /lib/firmware/qca/ -l
>>>> total 60
>>>> -rw-r--r-- 1 root root  1859 Jun 17 18:07 nvm_usb_00000200.bin
>>>> -rw-r--r-- 1 root root 54432 Jun 17 18:07 rampatch_usb_00000200.bin
>>>>
>>>> catelyn linux # sha256sum /lib/firmware/qca/*
>>>> 50cddc73c1a7c90bb3338941785d46088374b2aebf5dd1679c23145e39ad5087
>>>> /lib/firmware/qca/nvm_usb_00000200.bin
>>>> 7551fc3a01fe46514d4da265095aabf07371cf17418a9f238e51b0fc4e83cfc5
>>>> /lib/firmware/qca/rampatch_usb_00000200.bin
>>>>
>>> You did right thing. I cannot understand why driver couldn't access
>>> firmware file which is in /lib/firmware/qca. Did you check each
>>> folder has right permission to access?
>>>
>>> Thanks
>>> -- Ben Kim
>>>
>>
>> Ah I'm dumb. I'm using an initrd. :) So I've recompiled btusb as a
>> module and it loads the firmware! :)
>>
>> [  108.599370] intf ffff8800c9d2b800 id ffffffffa0005f50
>> [  108.599733] usbcore: registered new interface driver btusb
>> [  108.599769] hci0
>> [  108.602907] Bluetooth: hci0: using rampatch file:
>> qca/rampatch_usb_00000200.bin
>> [  108.602909] Bluetooth: hci0: QCA: patch rome 0x200 build 0x299,
>> firmware rome 0x200 build 0x111
>> [  108.658716] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000200.bin
>>
>> and I checked rfkill to make sure I wasn't soft/hard blocked:
>>
>> sudo rfkill list
>> 0: msi-bluetooth: Bluetooth
>>    Soft blocked: no
>>    Hard blocked: no
>> 1: msi-wlan: Wireless LAN
>>    Soft blocked: no
>>    Hard blocked: no
>> 2: hci0: Bluetooth
>>    Soft blocked: no
>>    Hard blocked: no
>> 3: phy0: Wireless LAN
>>    Soft blocked: no
>>    Hard blocked: no
>>
>> Sumit
>>
>>
>>
>> However, upon attempting to turn on bluetooth, either via the blueman
>> applet or the bluetoothctl command line like so:
>>
>> bluetoothctl
>> [NEW] Controller 2C:33:7A:00:05:DA BlueZ 5.25 [default]
>> [bluetooth]# select 2C:33:7A:00:05:DA
>> [bluetooth]# power on
>> Failed to set power on: org.bluez.Error.Failed
>> [bluetooth]#
>>
>> I get the following kernel error:
>>
>> [ 1172.484075] hci0
>> [ 1172.484097] Bluetooth: hci0: Failed to access otp area (-108)
>>
>
> Why does it try to load firmware again since it is already done on
> previous logs. I haven't used bluetoothctrl command. Can you follow up
> this step?
>
> 1. Make sure to load firmware files on the kernel message
>> Bluetooth: hci0: QCA: patch rome 0x200 build 0x299,
>> firmware rome 0x200 build 0x111
>
> 2. # hciattach hci0 up
> 3. # hcitool inq
>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> <mailto:majordomo@vger.kernel.org>
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks
> --Ben Kim

Oh I rebooted; so this is a fresh log. As far as I can tell, it only
tries to load the firmware once.

Huh, odd. When I try to use hcitool, it can't find hci0:

# hciattach hci0 up
Unknown device type or id
# hcitool inq
Inquiring ...
Inquiry failed.: No such device
# hcitool dev
Devices:

Here's a pastbin or my current dmesg:
https://bpaste.net/show/76b3ab48f222 (towards the bottom is where I
modprobe btusb)

Sumit


--------------080102070503050704020203
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">On 18/06/15 10:53, Kim, Ben Young Tae
      wrote:<br>
    </div>
    <blockquote
      cite=3D"mid:53369F14-1B95-40B4-AAB1-3181ED18CFD7@qca.qualcomm.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3Dwindows-1252">
      <div>Hi Sumit,<br>
      </div>
      <div><br>
        On Jun 17, 2015, at 7:36 PM, Sumit's Mailing Lists &lt;<a
          moz-do-not-send=3D"true" href=3D"mailto:lists@battlepenguin.com=
">lists@battlepenguin.com</a>&gt;
        wrote:<br>
        <br>
      </div>
      <blockquote type=3D"cite">
        <div><span>On 18/06/15 02:54, Ben Young Tae Kim wrote:</span><br>
          <blockquote type=3D"cite"><span>Hi Sumit,</span><br>
          </blockquote>
          <blockquote type=3D"cite"><span></span><br>
          </blockquote>
          <blockquote type=3D"cite"><span>On 06/17/15 06:00, Sumit Khanna
              wrote:</span><br>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>On 17/06/15 20:46, Sumit's
                Mailing Lists wrote:</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>On 17/06/15 04:52, Ben Youn=
g
                  Tae Kim wrote:</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>Hi Sumit,</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span></span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>On 06/15/15 10:48, Sumit'=
s
                    Mailing Lists wrote:</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite"><span>On 16/06/15 00:57, Ben
                      Young Tae Kim wrote:</span><br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span>Hi Sumit,</span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span></span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span></span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span>On 06/15/15 07:16,
                        Sumit's Mailing Lists wrote:</span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>On 15/06/15 21:55,
                          Marcel Holtmann wrote:</span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite"><span>Hi Smuit,</span><=
br>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite"><span></span><br>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>I'm
                                  currently using an MSI WS60 laptop
                                  which contains the following</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>Bluetooth
                                  controller (from lsusb):</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span></span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>Bus 003
                                  Device 003: ID 0cf3:3004 Atheros
                                  Communications, Inc. AR3012</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>Bluetooth
                                  4.0</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite"><span>assuming that
                                the firmware is present, this is most
                                likely just missing the right VID/PID
                                additions in the drivers. Please prepare
                                a patch for that.</span><br>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite"><span></span><br>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>and the mor=
e
                                  detailed version:</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span></span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>Bus 003
                                  Device 003: ID 0cf3:3004 Atheros
                                  Communications, Inc. AR3012</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>Bluetooth
                                  4.0</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>Device
                                  Descriptor:</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>bLength
                                  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A018</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>bDescriptor=
Type
                                  =A0=A0=A0=A0=A0=A0=A0=A01</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>bcdUSB
                                  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A01.10</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>bDeviceClas=
s
                                  =A0=A0=A0=A0=A0=A0=A0=A0=A0224 Wireless=
</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>bDeviceSubC=
lass
                                  =A0=A0=A0=A0=A0=A0=A0=A01 Radio Frequen=
cy</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>bDeviceProt=
ocol
                                  =A0=A0=A0=A0=A0=A0=A0=A01 Bluetooth</sp=
an><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>bMaxPacketS=
ize0
                                  =A0=A0=A0=A0=A0=A0=A064</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>idVendor
                                  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0cf3 At=
heros
                                  Communications, Inc.</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>idProduct
                                  =A0=A0=A0=A0=A0=A0=A0=A0=A00x3004 AR301=
2 Bluetooth 4.0</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>bcdDevice
                                  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00.01</=
span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>iManufactur=
er
                                  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A00</span><=
br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>iProduct
                                  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A00</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>iSerial
                                  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A00</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>bNumConfigu=
rations
                                  =A0=A0=A0=A0=A01</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite">
                              <blockquote type=3D"cite"><span>Configurati=
on
                                  Descriptor:</span><br>
                              </blockquote>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite"><span>I actually
                                prefer /sys/kernel/debug/usb/devices
                                output for the devices.</span><br>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite"><span></span><br>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite"><span>Regards</span=
><br>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite"><span></span><br>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite"><span>Marcel</span>=
<br>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <blockquote type=3D"cite"><span></span><br>
                            </blockquote>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>Here is the
                              output from /sys/kernel/debug/usb/devices
                              for my ath3k (also</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>added it to the
                              kernel bugzilla):</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span></span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>T: =A0Bus=3D03
                              Lev=3D02 Prnt=3D02 Port=3D02 Cnt=3D01 Dev#=3D=
 =A03
                              Spd=3D12 =A0=A0MxCh=3D 0</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>D: =A0Ver=3D 1.=
10
                              Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D6=
4
                              #Cfgs=3D =A01</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>P: =A0Vendor=3D=
0cf3
                              ProdID=3D3004 Rev=3D 0.01</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>C:* #Ifs=3D 2
                              Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>I:* If#=3D 0 Al=
t=3D
                              0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D=
01
                              Driver=3D(none)</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D81(I=
)
                              Atr=3D03(Int.) MxPS=3D =A016 Ivl=3D1ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D82(I=
)
                              Atr=3D02(Bulk) MxPS=3D =A064 Ivl=3D0ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D02(O=
)
                              Atr=3D02(Bulk) MxPS=3D =A064 Ivl=3D0ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>I:* If#=3D 1 Al=
t=3D
                              0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D=
01
                              Driver=3D(none)</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D83(I=
)
                              Atr=3D01(Isoc) MxPS=3D =A0=A00 Ivl=3D1ms</s=
pan><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D03(O=
)
                              Atr=3D01(Isoc) MxPS=3D =A0=A00 Ivl=3D1ms</s=
pan><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>I: =A0If#=3D 1 =
Alt=3D
                              1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D=
01
                              Driver=3D(none)</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D83(I=
)
                              Atr=3D01(Isoc) MxPS=3D =A0=A09 Ivl=3D1ms</s=
pan><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D03(O=
)
                              Atr=3D01(Isoc) MxPS=3D =A0=A09 Ivl=3D1ms</s=
pan><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>I: =A0If#=3D 1 =
Alt=3D
                              2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D=
01
                              Driver=3D(none)</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D83(I=
)
                              Atr=3D01(Isoc) MxPS=3D =A017 Ivl=3D1ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D03(O=
)
                              Atr=3D01(Isoc) MxPS=3D =A017 Ivl=3D1ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>I: =A0If#=3D 1 =
Alt=3D
                              3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D=
01
                              Driver=3D(none)</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D83(I=
)
                              Atr=3D01(Isoc) MxPS=3D =A025 Ivl=3D1ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D03(O=
)
                              Atr=3D01(Isoc) MxPS=3D =A025 Ivl=3D1ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>I: =A0If#=3D 1 =
Alt=3D
                              4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D=
01
                              Driver=3D(none)</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D83(I=
)
                              Atr=3D01(Isoc) MxPS=3D =A033 Ivl=3D1ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D03(O=
)
                              Atr=3D01(Isoc) MxPS=3D =A033 Ivl=3D1ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>I: =A0If#=3D 1 =
Alt=3D
                              5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D=
01
                              Driver=3D(none)</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D83(I=
)
                              Atr=3D01(Isoc) MxPS=3D =A049 Ivl=3D1ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>E: =A0Ad=3D03(O=
)
                              Atr=3D01(Isoc) MxPS=3D =A049 Ivl=3D1ms</spa=
n><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span></span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>and the firmwar=
e
                              the kernel is trying to load:</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span></span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>[ =A0762.729370=
]
                              usb 3-1.3: Direct firmware load for</span><=
br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>ar3k/AthrBT_0x0=
0000200.dfu
                              failed with error -2</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>[ =A0762.729373=
]
                              Bluetooth: Patch file not found
                              ar3k/AthrBT_0x00000200.dfu</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>[ =A0762.729374=
]
                              Bluetooth: Loading patch file failed</span>=
<br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>[ =A0762.729381=
]
                              ath3k: probe of 3-1.3:1.0 failed with
                              error -2</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite"><span>[ =A0762.729411=
]
                              usbcore: registered new interface driver
                              ath3k</span><br>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite"><span>I fail to see tha=
t
                            firmware in linux-firmware tree. However
                            this up to Atheros / Qualcomm to submit
                            there. I can not do much about this.</span><b=
r>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite"><span></span><br>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite"><span>Regards</span><br=
>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite"><span></span><br>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite"><span>Marcel</span><br>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite">
                        <blockquote type=3D"cite"><span></span><br>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>Marcel,</span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span></span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>So it's pulling the
                          right firmware file for my device, but It just<=
/span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>hasn't been release=
d
                          yet?</span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span></span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>I know with the
                          Wi-Fi firmware, the ath10k devs had python
                          scripts to</span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>extract the firmwar=
e
                          binaries from the Windows drivers (mentioned
                          in</span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>here <a
                            moz-do-not-send=3D"true"
                            href=3D"https://bugs.launchpad.net/ubuntu/+so=
urce/linux/+bug/1383184">
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1383184</a>). Has</s=
pan><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>anyone done that
                          before with the bluetooth firmware, or do you
                          typically</span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>just wait for
                          atheros/qualcom to release official ones?</span=
><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span>Where did you get you=
r
                        atheros board/card since I couldn't find that
                        board here. Is it a laptop? The BT firmware
                        driver was trying to load AthrBT_0x00000200.dfu
                        file and it got failed because no firmware file
                        was present. But 0x00000200 means
                        fw_version.rom_version which coming from
                        controller chip, however, I haven't seen this
                        version on Atheros chipset.</span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span></span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span>I'm adding my friend =
-
                        Rick Huang here. He may help you out</span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span></span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span>Hi Rick,</span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span></span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span>Have you seen
                        rom_version as 0x00000200?</span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span></span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>Sumit</span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>--</span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>To unsubscribe from
                          this list: send the line "unsubscribe
                          linux-bluetooth" in</span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>the body of a
                          message to <a moz-do-not-send=3D"true"
                            href=3D"mailto:majordomo@vger.kernel.org">
                            majordomo@vger.kernel.org</a></span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite">
                      <blockquote type=3D"cite"><span>More majordomo info
                          at =A0<a moz-do-not-send=3D"true"
                            href=3D"http://vger.kernel.org/majordomo-info=
.html">http://vger.kernel.org/majordomo-info.html</a></span><br>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span>Thanks</span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span>-- Ben Kim</span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite">
                    <blockquote type=3D"cite"><span></span><br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite"><span>Yes, It's an MSI WS-60
                      Laptop, purchased two months ago in Australia. Is</=
span><br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite"><span>there any other
                      debugging information I need to pull for you?</span=
><br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite"><span></span><br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite"><span>Sumit</span><br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite"><span>--</span><br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite"><span>To unsubscribe from thi=
s
                      list: send the line "unsubscribe linux-bluetooth"
                      in</span><br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite"><span>the body of a message t=
o
                      <a moz-do-not-send=3D"true"
                        href=3D"mailto:majordomo@vger.kernel.org">
                        majordomo@vger.kernel.org</a></span><br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <blockquote type=3D"cite"><span>More majordomo info at =
=A0<a
                        moz-do-not-send=3D"true"
                        href=3D"http://vger.kernel.org/majordomo-info.htm=
l">http://vger.kernel.org/majordomo-info.html</a></span><br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>According to my colleague=
,
                    it is not AR chip but QCA ROME core inside even
                    though they're sharing same VID/PID with AR/QCA
                    ROME(version 2). That's why you cannot bring up your
                    card with ath3k driver. I knew it was not a good
                    idea as it was early stage to develop the card so
                    that next version of ROME USB card(v3.0 or v3.2)
                    will use different PID/VID as you can see below.</spa=
n><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span></span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>Can you follow up these
                    instructions to see whether or not it can be
                    addressed on your setup?</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span></span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>--</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>1. put this code in
                    drivers/bluetooth/btusb.c</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span></span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>static const struct
                    usb_device_id blacklist_table[] =3D {</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>...</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>=A0=A0=A0/* QCA ROME chip=
set */</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>=A0=A0=A0{ USB_DEVICE(0x0=
cf3,
                    0xe300), .driver_info =3D BTUSB_QCA_ROME },</span><br=
>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>=A0=A0=A0{ USB_DEVICE(0x0=
cf3,
                    0xe360), .driver_info =3D BTUSB_QCA_ROME },</span><br=
>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>=A0=A0=A0{ USB_DEVICE(0x0=
cf3,
                    0x3004), .driver_info =3D BTUSB_QCA_ROME }, // &lt;--
                    add new VID/PID here</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>...</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span></span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>2. Copy firmware files
                    into /lib/firmware/qca</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>- nvm_usb_00000200.bin</s=
pan><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>-
                    rampatch_usb_00000200.bin</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>Those FW files won't be
                    available on linux-firmware.git til today but it it
                    will be available soon I believe.</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>--</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span></span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>Thanks</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span>-- Ben Kim</span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span></span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span></span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <blockquote type=3D"cite"><span></span><br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>Hi Ben,</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>I added that line to my
                  btusb.c; did a mrpropery, copied my .config back</span>=
<br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>into the source tree,
                  disabled ATH3K in menucofnig, made the bzImage and</spa=
n><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>rebooted. The firmware you
                  attached is in /lib/firmware/qca.</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>I enabled debugging
                  (FLAGS_btusb.o :=3D -DDEBUG in the Makefile) so I</span=
><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>could get some more info,
                  and discovered I also have to delete this line</span><b=
r>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>or it will match the ath
                  first:</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>{ USB_DEVICE(0x0cf3,
                  0x3004), .driver_info =3D BTUSB_ATH3012 }</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>So then I saw</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.263991] usb 3-=
1.3:
                  new full-speed USB device number 3 using ehci-pci</span=
><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.277022] usb 4-=
1.8:
                  new full-speed USB device number 3 using ehci-pci</span=
><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.350050] usb 3-=
1.3:
                  New USB device found, idVendor=3D0cf3,</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>idProduct=3D3004</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.350051] usb 3-=
1.3:
                  New USB device strings: Mfr=3D0, Product=3D0,</span><br=
>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>SerialNumber=3D0</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.350461] intf
                  ffff88041bf62400 id ffffffff81d83bc0</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.350462] BT Dev=
ice
                  Info 0</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.350463] BT Dev=
ice
                  Info (after matching) 32768</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.350466] In Rom=
e Block</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.350546] input:=
 ETPS/2
                  Elantech Touchpad as</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>/devices/platform/i8042/ser=
io1/input/input10</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.350671] hci0</=
span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.350879] Blueto=
oth:
                  hci0: don't support firmware rome 0x200</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.364795] usb 4-=
1.8:
                  New USB device found, idVendor=3D1770,</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>idProduct=3Dff00</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.364797] usb 4-=
1.8:
                  New USB device strings: Mfr=3D1, Product=3D1,</span><br=
>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>SerialNumber=3D1</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.364798] usb 4-=
1.8:
                  Product: MSI EPF USB</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.364799] usb 4-=
1.8:
                  Manufacturer: MSI EPF USB</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.364800] usb 4-=
1.8:
                  SerialNumber: MSI EPF USB</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>So those BT Device Info
                  statements I added in the probe function. "In</span><br=
>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>Rome Block" I added right
                  after "if (id-&gt;driver_info &amp; BTUSB_QCA_ROME) "</=
span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>and you can see where that
                  error comes from.</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>And that comes from...oh it
                  checks another table...okay so I added the</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>following to qca_device_inf=
o</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>=A0=A0=A0=A0=A0=A0=A0{ 0x00=
000200, 28, 4,
                  18 },</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>and now I get;</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.357942] intf
                  ffff88041ba5bc00 id ffffffff81d83bc0</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.357943] BT Dev=
ice
                  Info 0</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.357944] BT Dev=
ice
                  Info (after matching) 32768</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.357946] In Rom=
e Block</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.358113] hci0</=
span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.358516] blueto=
oth
                  hci0: Direct firmware load for</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>qca/rampatch_usb_00000200.b=
in
                  failed with error -2</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>[ =A0=A0=A01.358517] Blueto=
oth:
                  hci0: failed to request rampatch file:</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>qca/rampatch_usb_00000200.b=
in
                  (-2)</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>So progress. It's attemptin=
g
                  to load the firmware and failing. Are those</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>the right numbers for the
                  device_info block?</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span></span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"><span>Sumit</span><br>
              </blockquote>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>Just remembered -2 is when it
                can't even find the firmware. But I think</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>I have it installed right. Is
                this correct:</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span></span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>catelyn linux # ls
                /lib/firmware/qca/ -l</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>total 60</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>-rw-r--r-- 1 root root =A0185=
9
                Jun 17 18:07 nvm_usb_00000200.bin</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>-rw-r--r-- 1 root root 54432
                Jun 17 18:07 rampatch_usb_00000200.bin</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span></span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>catelyn linux # sha256sum
                /lib/firmware/qca/*</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>50cddc73c1a7c90bb3338941785d4=
6088374b2aebf5dd1679c23145e39ad5087
              </span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>/lib/firmware/qca/nvm_usb_000=
00200.bin</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>7551fc3a01fe46514d4da265095aa=
bf07371cf17418a9f238e51b0fc4e83cfc5
              </span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span>/lib/firmware/qca/rampatch_us=
b_00000200.bin</span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite"><span></span><br>
            </blockquote>
          </blockquote>
          <blockquote type=3D"cite"><span>You did right thing. I cannot
              understand why driver couldn't access firmware file which
              is in /lib/firmware/qca. Did you check each folder has
              right permission to access?</span><br>
          </blockquote>
          <blockquote type=3D"cite"><span></span><br>
          </blockquote>
          <blockquote type=3D"cite"><span>Thanks</span><br>
          </blockquote>
          <blockquote type=3D"cite"><span>-- Ben Kim</span><br>
          </blockquote>
          <blockquote type=3D"cite"><span></span><br>
          </blockquote>
          <span></span><br>
          <span>Ah I'm dumb. I'm using an initrd. :) So I've recompiled
            btusb as a</span><br>
          <span>module and it loads the firmware! :)</span><br>
          <span></span><br>
          <span>[ =A0108.599370] intf ffff8800c9d2b800 id ffffffffa0005f5=
0</span><br>
          <span>[ =A0108.599733] usbcore: registered new interface driver
            btusb</span><br>
          <span>[ =A0108.599769] hci0</span><br>
          <span>[ =A0108.602907] Bluetooth: hci0: using rampatch file:</s=
pan><br>
          <span>qca/rampatch_usb_00000200.bin</span><br>
          <span>[ =A0108.602909] Bluetooth: hci0: QCA: patch rome 0x200
            build 0x299,</span><br>
          <span>firmware rome 0x200 build 0x111</span><br>
          <span>[ =A0108.658716] Bluetooth: hci0: using NVM file:
            qca/nvm_usb_00000200.bin</span><br>
          <span></span><br>
          <span>and I checked rfkill to make sure I wasn't soft/hard
            blocked:</span><br>
          <span></span><br>
          <span>sudo rfkill list</span><br>
          <span>0: msi-bluetooth: Bluetooth</span><br>
          <span>=A0=A0=A0Soft blocked: no</span><br>
          <span>=A0=A0=A0Hard blocked: no</span><br>
          <span>1: msi-wlan: Wireless LAN</span><br>
          <span>=A0=A0=A0Soft blocked: no</span><br>
          <span>=A0=A0=A0Hard blocked: no</span><br>
          <span>2: hci0: Bluetooth</span><br>
          <span>=A0=A0=A0Soft blocked: no</span><br>
          <span>=A0=A0=A0Hard blocked: no</span><br>
          <span>3: phy0: Wireless LAN</span><br>
          <span>=A0=A0=A0Soft blocked: no</span><br>
          <span>=A0=A0=A0Hard blocked: no</span><br>
          <span></span><br>
          <span>Sumit</span><br>
          <span></span><br>
          <span></span><br>
          <span></span><br>
          <span>However, upon attempting to turn on bluetooth, either
            via the blueman</span><br>
          <span>applet or the bluetoothctl command line like so:</span><b=
r>
          <span></span><br>
          <span>bluetoothctl</span><br>
          <span>[NEW] Controller 2C:33:7A:00:05:DA BlueZ 5.25 [default]</=
span><br>
          <span>[bluetooth]# select 2C:33:7A:00:05:DA</span><br>
          <span>[bluetooth]# power on</span><br>
          <span>Failed to set power on: org.bluez.Error.Failed</span><br>
          <span>[bluetooth]#</span><br>
          <span></span><br>
          <span>I get the following kernel error:</span><br>
          <span></span><br>
          <span>[ 1172.484075] hci0</span><br>
          <span>[ 1172.484097] Bluetooth: hci0: Failed to access otp
            area (-108)</span><br>
          <span></span><br>
        </div>
      </blockquote>
      <div><br>
      </div>
      Why does it try to load firmware again since it is already done on
      previous logs. I haven't used bluetoothctrl command. Can you
      follow up this step?
      <div><br>
      </div>
      <div>1. Make sure to load firmware files on the kernel message</div=
>
      <div>
        <blockquote type=3D"cite"><font color=3D"#000000"><span
              style=3D"background-color: rgba(255, 255, 255, 0);">Bluetoo=
th:
              hci0: QCA: patch rome 0x200 build 0x299,<br>
              firmware rome 0x200 build 0x111</span></font></blockquote>
        <br>
      </div>
      <div>2. # hciattach hci0 up</div>
      <div>3. # hcitool inq</div>
      <div><br>
        <blockquote type=3D"cite">
          <div><span></span><br>
            <span>--</span><br>
            <span>To unsubscribe from this list: send the line
              "unsubscribe linux-bluetooth" in</span><br>
            <span>the body of a message to <a moz-do-not-send=3D"true"
                href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.=
kernel.org</a></span><br>
            <span>More majordomo info at =A0<a moz-do-not-send=3D"true"
                href=3D"http://vger.kernel.org/majordomo-info.html">http:=
//vger.kernel.org/majordomo-info.html</a></span><br>
          </div>
        </blockquote>
        <br>
      </div>
      <div>Thanks</div>
      <div>--Ben Kim</div>
    </blockquote>
    <br>
    Oh I rebooted; so this is a fresh log. As far as I can tell, it only
    tries to load the firmware once. <br>
    <br>
    Huh, odd. When I try to use hcitool, it can't find hci0:<br>
    <br>
    # hciattach hci0 up<br>
    Unknown device type or id<br>
    # hcitool inq<br>
    Inquiring ...<br>
    Inquiry failed.: No such device<br>
    # hcitool dev<br>
    Devices:<br>
    <br>
    Here's a pastbin or my current dmesg:
    <a class=3D"moz-txt-link-freetext" href=3D"https://bpaste.net/show/76=
b3ab48f222">https://bpaste.net/show/76b3ab48f222</a> (towards the bottom =
is where I
    modprobe btusb)<br>
    <br>
    Sumit <br>
    <br>
  </body>
</html>

--------------080102070503050704020203--
