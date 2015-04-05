Return-Path: <cyrus@holtmann.org>
From: Freek de Kruijf <f.de.kruijf@gmail.com>
To: "Chanyeol,Park" <chanyeol.park@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Problem with bluetooth device Broadcom Corp. BCM20702A0
Date: Sun, 05 Apr 2015 17:37:30 +0200
Message-ID: <23039502.lZB8K2ymtF@eik132.beelaertsict.nl>
In-Reply-To: <CAJx1FMM4Bvb0cmk+WNr3nM4DsbF+SMp8QYwqq7Vs5Wu7yKLEtg@mail.gmail.com>
References: <CAJx1FMM4Bvb0cmk+WNr3nM4DsbF+SMp8QYwqq7Vs5Wu7yKLEtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Op dinsdag 31 maart 2015 15:54:42 schreef Chanyeol, Park:
> Hi
> 
> 2015. 3. 31. 오전 1:11에 "Freek de Kruijf" <f.de.kruijf@gmail.com>님이 작성:
> > Hello all,
> > 
> > I have a Bluetooth dongle in a Raspberry Pi which identifies itself via
> 
> lsusb
> 
> > as: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0
> > 
> > This device is used in a Rapberry Pi and uses bluez-5.23-1.2
> > 
> > After some days working OK. It suddenly does not work anymore. A command
> > "hcitool scan" hangs and produces only lines showing "scanning...". It
> 
> even
> 
> > blocks and hangs the system. Putting "timeout -k 10s 1m" in front of that
> > command makes the system to continue. The command "hciconfig hci0 down"
> 
> seems
> 
> > to work. At least the device status is down. However "hciconfig hci0 up"
> 
> does
> 
> > not bring the device up. I tried "modprobe -f btusb" and after that
> 
> "hciconfig
> 
> > hci0 up" and the device status became up and the device did work again.
> > 
> > Any suggestion?
> 
> Could you share btmon log?

I don't know how to use btmon log?
 
> > --
> > fr.gr.
> > 
> > Freek de Kruijf
> Thanks
> Chanyeol

In dmesg I found:
[36631.721870] Bluetooth: RFCOMM TTY layer initialized
[36631.722003] Bluetooth: RFCOMM socket layer initialized
[36631.722109] Bluetooth: RFCOMM ver 1.11
[40230.966288] Bluetooth: hci0 ACL packet for unknown connection handle 21
[40272.479748] Bluetooth: hci0 command 0x0408 tx timeout

and the last one repeated quite a lot until I do:
modprobe -r btusb
modprobe -i btusb
hciconfig hci0 up

After which things went OK again.


-- 
fr.gr.

Freek de Kruijf

