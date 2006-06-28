Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44A29F2F.7020801@xmission.com>
Date: Wed, 28 Jun 2006 09:24:31 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <BAY116-DAV738BD697D0EDB18FB509AC77F0@phx.gbl>	<6297d67c0606272049g55cc14cby52254c90863e727f@mail.gmail.com>	<BAY116-DAV22C2B995073A52F8216D6C77F0@phx.gbl>
	<6297d67c0606280257y1cda0a8bj5ebdec42e3b1079@mail.gmail.com>
In-Reply-To: <6297d67c0606280257y1cda0a8bj5ebdec42e3b1079@mail.gmail.com>
Subject: Re: [Bluez-devel] A2DP a2play and a2recv
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

guys

first off, make sure you configure with --enable-fixed so you get the
fixed-point sbc library.

>          Thanks for reply. can a2play run on OSS too?

not directly.

if you know what you're doing, you could use dynamic loading tricks to
make writes to /dev/dsp go to custom code based on a2play.

it would be easier to modify the audio apps themselves. you may be able
to do that on your embedded platform.

>          I ported BlueZ on an embeded ARM7 running at 80 MHz.
>     I also try a2recv on embeded board with sound chip using OSS
>     driver. Printout looks ok, but can't hear anything:

it could be the cpu is too busy or the oss writes aren't right. I'm not
sure 80Mhz is fast enough.

There are a couple more sbc optimizations in the list of things to do.

- rework encoder to avoid moving values around (follow model from decoder)
- use a log2 table for byte integer scale factors calculation (sum log2
results for high and low bytes)
- fill bitpool by 16 bits instead of one at a time in bits
allocation/bitpool generation

Brad

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
