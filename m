Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300712231836m32ea9778o72a300c47cac18e@mail.gmail.com>
Date: Sun, 23 Dec 2007 19:36:34 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <BLU117-W24F980AF55D11A07E6B6E688590@phx.gbl>
MIME-Version: 1.0
References: <BLU117-W236D38B8C3E38C09A75D83885E0@phx.gbl>
	<d89ddf300712210752p24070ee5i33d17a427e3c31c@mail.gmail.com>
	<BLU117-W24F980AF55D11A07E6B6E688590@phx.gbl>
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

Benson,

Can you try these in /etc/bluetooth/hcid.conf one at a time,
restarting hcid each time and tell us if anything improves the
choppiness?

put "master" in hcid.conf's lm setting
take "rswitch" out of the lp setting
take "sniff" out of the lp setting

Brad

On Dec 23, 2007 7:09 PM, Benson Dong <dongas86.dev@hotmail.com> wrote:
>
>
> Hi Brad,
>
> I get info as follows when i run 'hcitool con' while the audio is playing.
>
> # hcitool con
> Connections:
> < ACL 00:0D:3C:EB:53:F0 handle 1 state 1 lm SLAVE ENCRYPT
>
> It do show slave connections.What shall i do next?
> Thank you for your help!
>
> --
> Benson
>
> > Date: Fri, 21 Dec 2007 08:52:43 -0700
> > From: bmidgley@gmail.com
> > To: bluez-users@lists.sourceforge.net
> > Subject: Re: [Bluez-users] a2dp choppy sound problem
>
> >
> > Benson
> >
> >> I get very choppy sound when playback audio through A2DP. Even the application shows playback ends,the headset could still hear the intermittent choppy sound for a few seconds.
> >
> > can tell us what you get when you run 'hcitool con' while the audio is
> > playing? Does it show slave connections?
> >
> > --
> > Brad
> >
> > -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Microsoft
> > Defy all challenges. Microsoft(R) Visual Studio 2005.
> > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
> _________________________________________________________________
> Express yourself instantly with MSN Messenger! Download today it's FREE!
> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
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
