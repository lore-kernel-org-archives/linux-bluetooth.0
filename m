Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can only start Bluetooth once on my Sony Picturebook
References: <200405101325.18922.tim@birdsnest.maths.tcd.ie> <1084193820.4017.25.camel@pegasus>
In-Reply-To: <1084193820.4017.25.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200405102257.57941.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 10 May 2004 22:57:57 +0200

Hi Marcel,

>
> you can keep every Bluetooth daemon running even if no device is
> attached. They will re-init themself if you power-up your internal
> Bluetooth device. What I think that happens is that the stopping with
> spicctrl is the same as a physical unplug and this causes a kernel oops.
> Check if you have CONFIG_BT_HCIUSB_SCO enabled, if yes, disable for now
> or apply the attached patch.
>
> Regards
>
> Marcel

Have you done some research in hcitool cc cc dc bug?

Michal


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
