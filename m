Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU117-W35384D9D521C82D28811E588590@phx.gbl>
From: Benson Dong <dongas86.dev@hotmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 24 Dec 2007 14:54:51 +0800
In-Reply-To: <d89ddf300712232026y32878c5x4b1e61ac0cee712c@mail.gmail.com>
References: <BLU117-W236D38B8C3E38C09A75D83885E0@phx.gbl>
	<d89ddf300712210752p24070ee5i33d17a427e3c31c@mail.gmail.com>
	<BLU117-W24F980AF55D11A07E6B6E688590@phx.gbl>
	<d89ddf300712231836m32ea9778o72a300c47cac18e@mail.gmail.com>
	<BLU117-W1270E7F77535BE008FEAF288590@phx.gbl>
	<d89ddf300712232026y32878c5x4b1e61ac0cee712c@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0368051916=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0368051916==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Brad,

> Date: Sun, 23 Dec 2007 21:26:20 -0700
> From: bmidgley@gmail.com
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] a2dp choppy sound problem
> 
> Benson
> 
>> It seems no difference and chopyy as before.
>> Anything else could do ?
> 
> you can try all three config changes above together.

I have tried ,still choppy sound.

> what version of bluez-utils is this? Have you tried cvs head?

I have not tried cvs head  and the version of bluez-utils i use is 3.22.

> are you getting interference? If it's a 1.2 or newer bt adapter, you
> could check the afh map to see if it's detecting and trying to avoid
> interference:
> 
> hcitool afh 00:0D:3C:EB:53:F0

I could not check the afh map ,
I got this:

#hcitool afh 00:0D:3C:EB:53:F0
HCI read AFH map request failed: Connection timed out

It seems there's some errors,is it?

> If the adapter on your computer is bt 1.2+ and the headset is older
> than 1.2, afh might be another advantage to run the computer's adapter
> as master.

The adapter is bt 1.2 and the headset is 2.0.

> is it running on a slow computer or an embedded computer?

It is running on CentOS 5.0(VMware) on x86 , 1G Mem ,PD3.2GHz .
I just compiled and installed bluez-libs 3.22 and bluez-utils 3.22 .

Then ,

#hcid -s -n -f /etc/bluetooth/hcid.conf

#aplay -D bluetooth 1.wav

Got choppy sound.

Configure Option:
bluez-libs 3.22
./configure --prefix=/usr

bluez-utils 3.22
configure --prefix=/usr --enable-test --enable-usb --enable-input --enable-serial --enable-initscripts --enable-bccmd --enable-cups --disable-pcmia --enable-alsa --enable-audio --enable-shared PKG_CONFIG=pkg-config --enable-obex --enable-avctrl --enable-network


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


--===============0368051916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0368051916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0368051916==--
