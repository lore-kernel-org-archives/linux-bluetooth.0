Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <7E3B31FF-53A2-443D-86DC-0F663B3F6D03@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <9a119b3c0711230400l2885eccei3b32efb152ddec0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Fri, 23 Nov 2007 14:32:37 +0200
References: <9a119b3c0711220826u405b3845pb1101fcfb2c42e3c@mail.gmail.com>
	<1c9b31320711220913r1f89aafgcf88c0927bfb1c1@mail.gmail.com>
	<9a119b3c0711230400l2885eccei3b32efb152ddec0@mail.gmail.com>
Subject: Re: [Bluez-users] Using AVRCP with current BlueZ
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Nov 23, 2007, at 14:00, Csillag Krist=F3f wrote:
> One more question: what was the reason to use
>
> KEY_NEXT and KEY_PREVIOUS, instead of
> KEY_NEXTSONG and KEY_PREVIOUSSONG?

No special reason, except that the names of the key codes matched more  =

precisely the AVRCP spec.

> The latter are below-256 keycodes (like KEY_PLAYPAUSE,
> which is used by BlueZ for pause) handled nicely by
> all applications (like keytouch), where the former, which
> are currently used, are extended codes, mostly unsupported
> in user-space.

If this improves interoperability with existing applications then it's  =

probably a good idea to apply your patch. I'll commit it to CVS later  =

today unless somebody has a good reason why it shouldn't be done.

Johan
-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
