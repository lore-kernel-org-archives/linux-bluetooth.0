Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPcThSG+7dEmy=MpJnzYFTb+o__j=mZncjxKyQNqOfPYGdzTTg@mail.gmail.com>
References: <CAPcThSG+7dEmy=MpJnzYFTb+o__j=mZncjxKyQNqOfPYGdzTTg@mail.gmail.com>
Date: Fri, 20 May 2016 10:52:55 +1000
Message-ID: <CAPcThSG5AhO3tczS-D3QBptafg=6dabrkizOx-cT+1S2Cxpv4g@mail.gmail.com>
Subject: Re: How to enable hci0 for bcm4356 chip on htc m9?
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I've figured out how to enable hci0 for bcm4356 chipset on Linux other
than android. Turns out the bluedroid in CyanogenMod android for htc
m9 phone no longer uses bluez and its dbus interfaces any longer, no
wonder there is no hci0 found there.

Turns out broadcom wifi/bt/fm chipset needs a special program to
download the required "mini driver" or *.hcd file to it at system
startup. Previously I tried to extract relevant code from broadcom's
libbt-vendor.so implementation for bluedroid, it was on the correct
direction but I hadn't unveiled all needed code. Turns out there is a
open source program for this purpose already, brcm_patchram_plus,
which could bring about the hci0 interface by the following command:

./brcm_patchram_plus -d --patchram
/system/etc/firmware/BCM4354A2_001.003.015.0064.0175.hcd --no2bytes
--baudrate 4000000 --use_baudrate_for_download --bd_addr
90:E7:C4:F3:F7:09 --enable_hci --scopcm=0,4,0,0,0,1,0,3,0,0
/dev/ttyHS0 &

Please note that bluetooth kernel driver needs to enable HCIUART and
HCIUART_H4 options to  activate relevant tty driver for the HCI-UART
interface. Of course, before running the above program, the bluetooth
hardware functionality should be powered on by "rfkill unblock
bluetooth" command, or directly writing 1 into relevant
/sys/class/rfkill/rfkillN/state file.

Moreover, if the --scopcm option needs to be changed, the process of
brcm_patchram_plus can be killed and restarted, however, I found that
I also need to block and then unblock the bluetooth via rfkill command
otherwise it will fail to download the mini drivers in the hcd file.

Last but not least, please note that the --scopcm option is not
working for me at the time being. I've already specified SCORouting =
PCM in audio.conf, but SCO-over-PCM doesn't work for me and I can't
hear anything from a connected bluetooth headset. Only change the SCO
routing to HCI (also requires the first byte, sco_routing, in the
--scopcm option, set to 1) would I hear some sound through the
headset, however, unfortunately, they are simply noise.

Cheers,
Harry

On Fri, May 13, 2016 at 2:57 PM, Qingtao Cao <qingtao.cao.au@gmail.com> wrote:
> Dear community,
>
> I am trying to enable hci0 on the htc m9 phone. Of course, the
> bluetooth functionality on that phone with the original CyanogenMod
> Android works well. To my surprise, after I mounted a yocto
> rootfs(with bluez built in), setup needed pseudo filesystems such as
> proc  and chroot into it, the hciconfig finds no hci0 device at all.
>
> So how could I enable the hci0 interface for the bcm4356 chipset? Also
> doesn't bluedroid manipulate it at all?
>
> BTW, the /dev/ttyHS0 is available on CyanogenMod Android, I also found
> how bluedroid and broadcom's libbt repo (implements the
> libbt-vendor.so library) setup its baud rate and writes into it the
> content of a firmware patchfile, so I tried to abstract relevant logic
> into the attached c file and run it on my own Linux (derived from 3.10
> mainline kernel) with bluetooth and /dev/ttyHS0 drivers all enabled,
> however, again, I failed to run hciattach to attach /dev/ttyHS0 to
> further bring about hci0, despite that this simple c file can achieve
> similar result.
>
> The results of bluetooth related commands on my tailored linux on htc
> m9 are as followed.
>
> Many thanks for any advice or comment!
>
> Cheers,
> Harry
>
>
>
> / # hciconfig hci0
> Can't get device info: No such device
> / #
>
> / # ls -l /dev/ttyHS0
> crw-rw----    1 root     dialout   236,   0 May 13 04:50 /dev/ttyHS0
> / # grep 236 /proc/devices
> 236 ttyHS
> / #
>
> / # rfkill list
> 0: bt_power: bluetooth
>     Soft blocked: no
>     Hard blocked: no
> 1: bcm4356: bluetooth
>     Soft blocked: no
>     Hard blocked: no
> 2: phy0: wlan
>     Soft blocked: no
>     Hard blocked: no
> 3: brcmfmac-wifi: wlan
>     Soft blocked: no
>     Hard blocked: no
> / #
>
> / # ./bcm4356_init
> userial vendor open: opening /dev/ttyHS0
> device fd = 3 open
> bt vendor lib: set UART baud 4000000
> HCI_VSC_LAUNCH_RAM received!
> bt vendor lib: set UART baud 115200
> bt vendor lib: set UART baud 4000000
> Setting local bd addr to 90:E7:C4:F3:F7:09
> vendor lib fwcfg completed
> / #
>
> / # hciattach -n /dev/ttyHS0 any 4000000 90:E7:C4:F3:F7:09
> Device setup complete
> (blocked, pressed ctrl + c to terminate)
