Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU117-W24F980AF55D11A07E6B6E688590@phx.gbl>
From: Benson Dong <dongas86.dev@hotmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 24 Dec 2007 10:09:12 +0800
In-Reply-To: <d89ddf300712210752p24070ee5i33d17a427e3c31c@mail.gmail.com>
References: <BLU117-W236D38B8C3E38C09A75D83885E0@phx.gbl>
	<d89ddf300712210752p24070ee5i33d17a427e3c31c@mail.gmail.com>
MIME-Version: 1.0
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
Content-Type: multipart/mixed; boundary="===============1747443002=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1747443002==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit



Hi Brad,

I get info as follows when i run 'hcitool con' while the audio is playing.

# hcitool con
Connections:
< ACL 00:0D:3C:EB:53:F0 handle 1 state 1 lm SLAVE ENCRYPT

It do show slave connections.What shall i do next?
Thank you for your help!

--
Benson

> Date: Fri, 21 Dec 2007 08:52:43 -0700
> From: bmidgley@gmail.com
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] a2dp choppy sound problem
>
> Benson
>
>> I get very choppy sound when playback audio through A2DP. Even the application shows playback ends,the headset could still hear the intermittent choppy sound for a few seconds.
>
> can tell us what you get when you run 'hcitool con' while the audio is
> playing? Does it show slave connections?
>
> --
> Brad
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/


--===============1747443002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1747443002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1747443002==--
