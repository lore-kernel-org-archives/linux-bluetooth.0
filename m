Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Florian Echtler <floe@butterbrot.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1142259275.19093.10.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Bluez for Motorola EZX mobile phones
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 13 Mar 2006 15:14:34 +0100

Hi everybody,

there already was a thread a while ago about BlueZ on the Motorola EZX
phones, and in the motorolafans.com forum, one can download a binary
package containing the modules. However, I wanted a) to look at the
source code and b) to have the newest BlueZ modules available, so I
backported the modules from 2.4.31-mh1 to the custom Motorola kernel,
which is based on 2.4.20. 

My question is now what to do with the patch. I don't think it would
make sense to integrate it into the main Bluez tree, would it? Perhaps
it would be best to create a separate patch against the Motorola custom
kernel tree? (There are some nasty little hacks involved so that the 
kernel itself doesn't have to be recompiled, which could only be updated
by flashing the phone - that's a big "DON'T" for me :-)

Yours, Florian



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
