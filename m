Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Audio & Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099954588.6339.144.camel@loke>
References: <418FC205.7070102@tootai.net>
	 <1099943857.29330.27.camel@pegasus>  <1099954588.6339.144.camel@loke>
Content-Type: text/plain
Message-Id: <1099956503.29330.35.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Nov 2004 00:28:22 +0100

Hi Martin,

> > > I have a question: for my mobile I use an HAMA Bluetooth headset. If I 
> > > buy a bluetooth PCMCIA card for my notebook, will I be able to use this 
> > > headset with this card? recognized as a second soundcard? as a normal 
> > > headset for my integrate soundcard? recognized by my software phone 
> > > clients? If I buy an USB bluetooth device, would it be the same? better?
> > 
> > actually this is not an easy to answer question. First thing is that you
> > should get a Bluetooth device with a CSR chip and at least HCI 16.x
> > firmware on it. The second is that it must route the SCO traffic through
> > the HCI and via a PCM. Then it should be possible.
> 
> How to identify version 16.x or higher ? hciconfig -a only gives a
> hexadecimal value, that not really gives me get a clue on the firmware
> version.
> 
> HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc

you are kidding me? Use "hciconfig hci0 revision" or look at my webpage
where most of the build ids are decoded.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
