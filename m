Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluepin with SuSE 9.0
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FE5D72B.2000108@nue.et-inf.uni-siegen.de>
References: <3FE5D72B.2000108@nue.et-inf.uni-siegen.de>
Content-Type: text/plain
Message-Id: <1072032518.2684.90.camel@pegasus>
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
Date: Sun, 21 Dec 2003 19:48:38 +0100

Hi Michael,

> I think I have a working 'bluepin' script (the one which is responsible 
> for the PIN entry GUI during pairing) for SuSE 9.0, which hopefully 
> addresses all the problems several folks have suffered from in the last 
> weeks. The Script is attached to this note.
> 
> I have made the following changes to the script from 
> http://bluez.sourceforge.net/download/bluepin:
> 
> - moved the "import gtk" statement behind the "set_display ()" call
>    (as this is the case in the current script in cvs).
> - replaced the "if arg[i][0] != '-' and i==1:" line with
>    "if i==1 and arg[i][0] == ':':"
>    (as proposed by Jean-Marc Autexier
>     http://www.autexier.de/jmau/linux/Bluetooth.html
>     and others)
> 
> Furthermore, the following packages need to be present on the SuSE 9.0 
> box (which are normally not installed):
> 
> - python-gtk (bindings)
> - python-numeric
> 
> These changes may apply accordingly to earlier versions of SuSE Linux, 
> too (I have observed similar problems with 'bluepin' in SuSE 8.x, too).
> 
> 
> Maybe someone out of the BlueZ community may put this script on his web 
> site for the public (my institute home page won't live very much longer).

My plan is to make a last bluez-utils release for this version of the
Bluetooth library. It should address exactly these problems with the
pin_helper. Please send me confirmations that these modification are
working fine on other distributions.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
