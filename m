Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300712232026y32878c5x4b1e61ac0cee712c@mail.gmail.com>
Date: Sun, 23 Dec 2007 21:26:20 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <BLU117-W1270E7F77535BE008FEAF288590@phx.gbl>
MIME-Version: 1.0
References: <BLU117-W236D38B8C3E38C09A75D83885E0@phx.gbl>
	<d89ddf300712210752p24070ee5i33d17a427e3c31c@mail.gmail.com>
	<BLU117-W24F980AF55D11A07E6B6E688590@phx.gbl>
	<d89ddf300712231836m32ea9778o72a300c47cac18e@mail.gmail.com>
	<BLU117-W1270E7F77535BE008FEAF288590@phx.gbl>
Subject: Re: [Bluez-users] a2dp choppy sound problem
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

Benson

> It seems no difference and chopyy as before.
> Anything else could do ?

you can try all three config changes above together.

what version of bluez-utils is this? Have you tried cvs head?

are you getting interference? If it's a 1.2 or newer bt adapter, you
could check the afh map to see if it's detecting and trying to avoid
interference:

hcitool afh 00:0D:3C:EB:53:F0

If the adapter on your computer is bt 1.2+ and the headset is older
than 1.2, afh might be another advantage to run the computer's adapter
as master.

is it running on a slow computer or an embedded computer?

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
