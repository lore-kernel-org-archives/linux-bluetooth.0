Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Extended functions of bluetooth keyboard (diNovo)
From: Marcel Holtmann <marcel@holtmann.org>
To: Oli Ellis <oliver.ellis@ntlworld.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <405B55EE.8060602@ntlworld.com>
References: <405B55EE.8060602@ntlworld.com>
Content-Type: text/plain
Message-Id: <1079791201.31859.35.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 20 Mar 2004 15:00:01 +0100

Hi Oli,

> kernel 2.6.4-rc1  with added mutibytes support (anyone know when that is 
> coming as standard?)

it is part of 2.6.5-rc2.

> gentoo linux with cvs utils2 and libs2. All bluetooth kernel 
> functionality compiled directly into the kernel, not as modules.
> 
> I am using bthid daemon, which I presume feeds the events from the 
> bluetooth stack into the kernel via the uinput device (correct me if I 
> am wrong). However, the multimedia keys creates up a log messages from 
> bthid - for example
> ---
> (press either mute button on keyboard or media pad)
> bthid[4128]: Unknown consumer usage 0xc00e3
> bthid[4128]: Unknown consumer usage 0xc0001
> bthid[4128]: Unknown consumer usage 0xc0001
> bthid[4128]: Unknown consumer usage 0xc0001
> ---
> Some messages are odder...
> ---
> (press sleep (crescent) button on keyboard)
> bthid[4128]: Unknown hid usage (0x10083 + 1)
> bthid[4128]: Sleep button pressesd (ignored)
> ---
> showkey reports no keycode or scancode, and obviously nothing in xev, so 
> I am guessing that this is a limitation in bthid. Is bthid configurable 
> in some way?

You have to fix bthid to send the correct key values to uinput. I have
no interest in doing it, but every patch is welcome.

> Also, does anyone know how to make the LCD panel on the media pad show 
> what you want? The calculator is hard-wired into the pad, so is 
> functional, but there is a 15 char X 3 line display and six LCD symbols. 
> Would it be possible to send arbritrary HCI commands with hcitool? I 
> have seen a rumour that it uses the hid++ spec, but where can I find 
> this? (google no help...)

Once I had hacked this stuff, but I lost my notes and my demo code for
it. Check the mailing list archive if I had posted some comments about
the media pad.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
