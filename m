Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5256d0b0608080813r4d47ca8p6e55fcd91a2175df@mail.gmail.com>
Date: Tue, 8 Aug 2006 16:13:05 +0100
From: "Peter Robinson" <pbrobinson@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44D8A430.6080502@palmsource.com>
MIME-Version: 1.0
References: <056BF200E9632F4285220E570FEED673D7AE42@GBMDDMH202AMSX.gb001.siemens.net>
	<44D8A430.6080502@palmsource.com>
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus
	xmmserror(trials and tribulations) how cool is this!!! new patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On 8/8/06, Fr=E9d=E9ric DALLEAU <frederic.dalleau@palmsource.com> wrote:
> Andrew,
>
> I ran the test you told me, on my computer I noticed the process started
> using 100% cpu time after 35 mins. Two hours later the computer was
> still alive. Certainly an overflow when calculating delays. The relation
> with the freeze is not clear. My only assumption for now is that taking
> so much cpu time can overheat a computer. It should not freeze, but it
> is not excluded. Are you using an overclocked computer? Fan lowering
> software?
>
> The mail thread clearly state the problem is 2.6.17 mh3+ related. If
> you're not already 2.6.17, there  need to try 2.6.16.
>
> I'm isolating the cpu time prob, this is long but easy to reproduce. So
> it should be corrected soon.
>
> Thank you for all your patience :D

Could you not use gdb, or various other debugging tools to catch these?

Peter

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
