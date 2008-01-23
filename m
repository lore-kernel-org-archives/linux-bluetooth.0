Return-Path: <cyrus@holtmann.org>
From: Brian Sammon <bluez-users@brisammon.fastmail.fm>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-reply-to: <20080122212531.2515.qmail@station192.com> 
References: <20080122212531.2515.qmail@station192.com>
Mime-Version: 1.0
Date: Tue, 22 Jan 2008 23:35:09 -0500
Message-Id: <E1JHXKQ-0003dT-1Q@necz1>
Subject: Re: [Bluez-users] All connections disconnect immediately
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

>      'It is not pairing. Bluez site has info that describe how pairing can be
> achieved.'
>     I have searched high and low but failed to find this information.  Would
> you or someone be so kind as to point me to the relevant documentation?
>     Has someone translated the python scripts offered in the documentation
> into commands one can merely run on the command line?

I found that the dbus-send commands specified in the "dbus-send" section of 
http://wiki.bluez.org/wiki/HOWTO/Bonding were successful in manually 
initiating the bonding process.
In my case, I had to manually start the passkey app first.

I agree that bluez information for the non-programmer is rather hard to 
find/navigate.  It would be nice if someone (preferably someone who knows more 
about it than me) could split http://wiki.bluez.org/wiki/HOWTO/Bonding into a 
"pairing-for-users" page and a "pairing-for-programmers" page.
As it is, it gives the impression that bluez is not quite ready for 
non-programmer use yet.




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
