Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300711191224r62590f98xf44060aa52fa30f8@mail.gmail.com>
Date: Mon, 19 Nov 2007 13:24:28 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <c74b6b3d0711180941j33e07d11j8083973dde8047df@mail.gmail.com>
MIME-Version: 1.0
References: <c74b6b3d0711180941j33e07d11j8083973dde8047df@mail.gmail.com>
Subject: Re: [Bluez-users] Can't use bt mouse and a2dp together
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

if you have "master" in hcid.conf's lm setting and you take "rswitch"
and "sniff" out of the lp setting, you are making the pc prefer to be
master and to hopefully behave better. This can eliminate choppiness.

On Nov 18, 2007 10:41 AM, Adam Strojek <zwierzak2003@gmail.com> wrote:
> OK I do more tests and I can't use my bluetooth headset with any other
> bluetooth device! Probably a2dp service take whole bt transfer because
> it don't compress it. When I used old bluetooth-alsa service I could
> connect and use more then only headset!
>
> Btw. How to start AVRCP service?
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



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
