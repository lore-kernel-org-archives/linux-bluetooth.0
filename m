Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44B6400E.9040305@xmission.com>
Date: Thu, 13 Jul 2006 06:43:58 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E85@eumonex01.palmsource.com>
	<20060713105346.GA22651@srcf.ucam.org>
In-Reply-To: <20060713105346.GA22651@srcf.ucam.org>
Subject: Re: [Bluez-devel] RE : A2DP plugin success with HP
	bluetooth	headphones
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

Matthew

>> Could you give it a try with a2dpd plugin and see if these problems remains?
>> You will not have the same audio quality, but those start/stop problems may disappear.
> 
> Ok, that seems better, but the audio quality is pretty dreadful - what 
> recognisable bits there are are running slightly too slowly, followed by 
> a brief burst of static.

fwiw, in my experience, the hp set was the least forgiving of timing
problems in our software. it "pops" when frames are too fast and has
even nastier "snaps" when it's so slow that the stream runs dry.

brad


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
