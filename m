Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <407195F7.4020907@pobox.com>
From: Daniel Jimenez <djimenez@pobox.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] BT950_CS
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
Date: Mon, 05 Apr 2004 12:23:03 -0500

Hi all. I apologize in advanced for the noobish question. I tried 
RTFMing but couldn't find what I needed.

I have an Ambicom BT2000-CF. According to cardctl ident its:

Socket 0:
   product info: "AmbiCom,Inc", "BT2000E", "Bluetooth PC/CF Card"
   manfid: 0x022d, 0x2000
   function: 2 (serial)

--

The driver I need is either BT950_CS 
(http://www.holtmann.org/linux/bluetooth/bt950.html) or BT2000E 
(http://www.iral.com/~albertr/linux/bt2000e/).

I'm running a vanilla Kernel 2.6.5 with all the bluetooth options 
compiled in (except no drivers).

...

I've downloaded the source for both of these packages but cannot figure 
out how to compile the modules.

  BT950 came with a make file, but a TON of errors were returned when I 
attempted to make it. I assume it was built for another kernel series 
(maybe 2.4?).

  BT2000E just came with a changelog and a .c file. I did gcc bt2000e.c 
and it returned a whole hell of allot more errors.


...

Is there something I'm missing/not doing? I have bluez-libs installed as 
well. I can post the output of the compiles to a web server if needed.

Thanks!,
-- 
Daniel Jimenez <djimenez[at]pobox[dot]com>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
