Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.de>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	"Grumbach\, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: autosuspend issues with the Intel Bluetooth device [8087:07dc]
References: <87obajn8wv.fsf@nemi.mork.no> <2178464.gnEadSyMSQ@linux-5eaq.site>
Date: Wed, 03 Jul 2013 14:56:44 +0200
In-Reply-To: <2178464.gnEadSyMSQ@linux-5eaq.site> (Oliver Neukum's message of
	"Wed, 03 Jul 2013 14:29:28 +0200")
Message-ID: <877gh7n6nn.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Oliver Neukum <oneukum@suse.de> writes:

> On Wednesday 03 July 2013 14:08:00 Bjørn Mork wrote:
>> But this just does not seem right? Any modern USB device is supposed to
>> support autosuspend, right? I am using the firmware patch included in
>
> What should be and what is may be different although it oughn't be.
>
>> the latest public firmware repo:
>
> Does the device respond to standard request, that is what does lsusb do?

Yes, it does. Standard USB requests seems to wake the device.  Running
"lsusb -vd 8087:07dc" from suspended state works fine for example:

nemi:/tmp# grep . /sys/bus/usb/devices/7-1/power/runtime_status; lsusb -vd 8087:07dc >/dev/null ;  grep . /sys/bus/usb/devices/7-1/power/runtime_status
suspended
active


usbmon trace of this:

nemi:/tmp# cat /sys/kernel/debug/usb/usbmon/7t 
ffff88021ae42680 3655354231 S Ci:001:00 s a3 00 0000 0001 0004 4 <
ffff88021ae42680 3655354476 C Ci:001:00 0 4 = 07010000
ffff88021ae42680 3655354683 S Ci:001:00 s a3 00 0000 0002 0004 4 <
ffff88021ae42680 3655354825 C Ci:001:00 0 4 = 00010000
ffff8802300c1680 3655354960 S Ii:001:01 -115 2 <
ffff88021ae42680 3655355508 S Ci:001:00 s a3 00 0000 0001 0004 4 <
ffff88021ae42680 3655355903 C Ci:001:00 0 4 = 07010000
ffff88021ae42680 3655356070 S Co:001:00 s 23 01 0002 0001 0000 0
ffff88021ae42680 3655356248 C Co:001:00 0 0
ffff88022cac6ec0 3655386101 S Ci:001:00 s a3 00 0000 0001 0004 4 <
ffff88022cac6ec0 3655386152 C Ci:001:00 0 4 = 03010400
ffff88021ae42680 3655402102 S Co:001:00 s 23 01 0012 0001 0000 0
ffff88021ae42680 3655402133 C Co:001:00 0 0
ffff88021ae42680 3655402178 S Ci:002:00 s 80 00 0000 0000 0002 2 <
ffff88021ae42680 3655404198 C Ci:002:00 0 2 = 0300
ffff88021ae42680 3655404311 S Co:002:00 s 00 01 0001 0000 0000 0
ffff88021ae42680 3655405219 C Co:002:00 0 0
ffff88021ae42680 3655405422 S Ii:002:01 -115 64 <
ffff88022cac6ec0 3655405459 S Bi:002:02 -115 1028 <
ffff88022cac6e00 3655405510 S Bi:002:02 -115 1028 <
ffff88022cac6d40 3655407116 S Ci:002:00 s 80 06 0600 0000 000a 10 <
ffff88022cac6c80 3655407277 S Co:002:00 s 01 0b 0000 0001 0000 0
ffff88022cac6d40 3655408225 C Ci:002:00 -32 0
ffff88022cac6d40 3655408514 S Ci:002:00 s 80 06 0a00 0000 0004 4 <
ffff88022cac6c80 3655409220 C Co:002:00 0 0
ffff88022cac6d40 3655409258 C Ci:002:00 0 0
ffff88022cac6d40 3655409528 S Ci:002:00 s 80 00 0000 0000 0002 2 <
ffff88022cac6d40 3655410194 C Ci:002:00 0 2 = 0100

And then when suspending:

ffff88021ae42680 3657411219 C Ii:002:01 -2 0
ffff88021ae42680 3657411253 S Ii:002:01 -115 64 <
ffff88021ae42680 3657411298 E Ii:002:01 -1 0
ffff88022cac6e00 3657412234 C Bi:002:02 -2 0
ffff88022cac6e00 3657412261 S Bi:002:02 -115 1028 <
ffff88022cac6e00 3657412280 E Bi:002:02 -1 0
ffff88022cac6ec0 3657413234 C Bi:002:02 -2 0
ffff88022cac6ec0 3657413261 S Bi:002:02 -115 1028 <
ffff88022cac6ec0 3657413281 E Bi:002:02 -1 0
ffff88022cac6ec0 3657413557 S Co:002:00 s 00 03 0001 0000 0000 0
ffff88022cac6ec0 3657414209 C Co:002:00 0 0
ffff88022cac6ec0 3657414531 S Co:001:00 s 23 03 0002 0001 0000 0
ffff88022cac6ec0 3657414565 C Co:001:00 0 0
ffff8802300c1680 3657430065 C Ii:001:01 -2 0



Ah, this is probably a timing issue.  The HCI commands also wake the
device, but too late most of the time. This fails:

nemi:/tmp# grep . /sys/bus/usb/devices/7-1/power/runtime_status; hciconfig hci1 version ;  grep . /sys/bus/usb/devices/7-1/power/runtime_status
suspended
Can't read version info hci1: Connection timed out (110)
active


But repeating the command makes the second attempt work:

nemi:/tmp# grep . /sys/bus/usb/devices/7-1/power/runtime_status; hciconfig hci1 version;  hciconfig hci1 version ;  grep . /sys/bus/usb/devices/7-1/power/runtime_status
suspended
Can't read version info hci1: Connection timed out (110)
hci1:   Type: BR/EDR  Bus: USB
        BD Address: 0C:8B:FD:08:09:75  ACL MTU: 1021:5  SCO MTU: 96:5
        HCI Version: 4.0 (0x6)  Revision: 0x500
        LMP Version: 4.0 (0x6)  Subversion: 0x500
        Manufacturer: Intel Corp. (2)
active


Bjørn
