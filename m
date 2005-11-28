Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multiple RFCOMM disconnection problem
From: Agustin Fusaro <afusaro@apexar.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1132944279.5577.33.camel@blade>
References: <1132928387.3260.11.camel@localhost.localdomain>
	 <1132944279.5577.33.camel@blade>
Content-Type: text/plain
Message-Id: <1133181787.3047.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 28 Nov 2005 09:43:07 -0300

Hi Marcel,
Here is the data you requested:

lsmod:

Module                  Size  Used by
parport_pc             28933  1
lp                     13001  0
parport                40585  2 parport_pc,lp
autofs4                29253  2
rfcomm                 42333  0
l2cap                  30661  5 rfcomm
bluetooth              56133  6 rfcomm,l2cap
sunrpc                167813  1
dm_mod                 58101  0
video                  15941  0
button                  6609  0
battery                 9413  0
ac                      4805  0
md5                     4033  1
ipv6                  268097  8
uhci_hcd               35152  0
ehci_hcd               41037  0
i2c_viapro              8017  0
i2c_core               21569  1 i2c_viapro
snd_via82xx            30081  1
gameport               18633  1 snd_via82xx
snd_ac97_codec         75961  1 snd_via82xx
snd_seq_dummy           3653  0
snd_seq_oss            37057  0
snd_seq_midi_event      9153  1 snd_seq_oss
snd_seq                62289  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            51185  0
snd_mixer_oss          17857  2 snd_pcm_oss
snd_pcm               100169  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              33605  2 snd_seq,snd_pcm
snd_page_alloc          9669  2 snd_via82xx,snd_pcm
snd_mpu401_uart        10049  1 snd_via82xx
snd_rawmidi            30305  1 snd_mpu401_uart
snd_seq_device          8781  4
snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidisnd
57157  11
snd_via82xx,snd_ac97_codec,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore              10913  2 snd
via_rhine              28361  0
mii                     5441  1 via_rhine
floppy                 65269  0
ext3                  132553  1
jbd                    86233  1 ext3

modinfo rfcomm:

filename:       /lib/modules/2.6.11-1.1369_FC4/kernel/net/bluetooth/rfcomm/rfcomm.ko
author:         Maxim Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann
<marcel@holtmann.org>
description:    Bluetooth RFCOMM ver 1.5
version:        1.5
license:        GPL
alias:          bt-proto-3
vermagic:       2.6.11-1.1369_FC4 686 REGPARM 4KSTACKS gcc-4.0
depends:        bluetooth,l2cap
srcversion:     0F01C84C05D0CC738907E51

uname -a

Linux lab04l 2.6.11-1.1369_FC4 #1 Thu Jun 2 22:55:56 EDT 2005 i686
athlon i386 GNU/Linux

This data is for the Fedora 4 distribution. I downloaded and installed
the latest BlueZ library and utilities.

Thanks very much for your time

Regards,
Agustin


On Fri, 2005-11-25 at 19:44 +0100, Marcel Holtmann wrote:
> Hi Augustin,
> 
> > When I try to connect more than 2 RFCOMM connections (on different
> > ports), everything works fine until I disconnect the last connection:
> > 
> > In other words, I can create multiple RFCOMM connections on different
> > ports, but when I try and disconnect, the computer freezes (on fedora 4
> > kernel 2.6.11) or just displays a segfault and I can't kill the process
> > (o Knoppix kernel 2.6.14).
> > 
> > I tried with different USB dongles, updated to the last release of Bluez
> > (rfcomm version 2.22) and nothing changes...
> > 
> > This is a very strange problem... and only ocurrs when I try to connect
> > to more then 2 BT devices.
> > 
> > Here's what I do:
> > I have two computers, each one with one dongle. On the listener side I
> > run on different terminals:
> > 
> > >rfcomm listen 1 1
> > >rfcomm listen 2 2
> > >rfcomm listen 3 3
> > and so on...
> > 
> > on the client side I run
> > 
> > >rfcomm connect 1 <bdaddress> 1
> > >rfcomm connect 2 <bdaddress> 2
> > >rfcomm connect 3 <bdaddress> 3
> > 
> > everything works fine until I disconnect (CTRL+C from the client side)
> > the 3rd connection. I tried with more than 3 connections and the system
> > freezes when I disconnect the last connection.
> > 
> > I'd really appreciate any feedback on this problem... I am at a lost
> > here... Has this ever happened to you?
> 
> I need some details of your kernel. Send in "lsmod" and "modinfo rfcomm"
> and also "uname -a". Do you see an oops in the logs?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
