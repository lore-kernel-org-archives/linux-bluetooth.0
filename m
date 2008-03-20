Return-Path: <cyrus@holtmann.org>
Message-ID: <310e0a8d0803200701r4277dd6p3fa88c76e1d4a09d@mail.gmail.com>
Date: Thu, 20 Mar 2008 16:01:10 +0200
From: "Stanislav Popov" <stancho@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1206021288.7678.14.camel@californication>
MIME-Version: 1.0
References: <310e0a8d0803160610pa6e8dfcs1669c67f25d30117@mail.gmail.com>
	<1206021288.7678.14.camel@californication>
Subject: Re: [Bluez-users] bluez-utils - PIN Helper without GTK
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

Thank you for your answer!

Actually I managed to install bluez-utils and anyremote (control my pc
via bluetooth).
but when I up the hci0 interface with auth or encrypt flags then my pc
is not discovered by my phone.

If only iscan and piscan flags are set, then everything works, but it
not requires auth.

I remembed that some months ago PIN auth was working for me but using
compiled bluez-libs and bluez-utils
packages on OpenWRT distro.

Regards,
Stanislav Popov

On Thu, Mar 20, 2008 at 3:54 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>
>
>  > I installed my bluetooth successfully and now I am able to use it.
>  >
>  > I would like to support auth connection
>  > but I do not have python gtk support.
>  >
>  > Some times ago I used a pin helper which does not depends on python gtk support.
>  >
>  > It was a simple bash script.
>  >
>  > Where can I download bluez-utils package which supports auth and does
>  > not depend on python GTK
>
>  nothing depends on a Python GTK pin helper (actually it is called
>  passkey agent).
>
>  Regards
>
>  Marcel
>
>
>
>  -------------------------------------------------------------------------
>  This SF.net email is sponsored by: Microsoft
>  Defy all challenges. Microsoft(R) Visual Studio 2008.
>  http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>  _______________________________________________
>  Bluez-users mailing list
>  Bluez-users@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Regards,
St. Popov

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
