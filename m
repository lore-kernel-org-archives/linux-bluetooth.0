Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 13 Jul 2006 08:27:43 +0200
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E85@eumonex01.palmsource.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE : A2DP plugin success with HP bluetooth headphones
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

Hi Matthew,

> Also, hitting "stop" in beep-media-player (using the alsa output plugin) 
> seems to make things unhappy - the next time I hit play, everything 
> looks normal, I get plenty of "SBC Bandwidth =" messages and no audio 
> appears. The log from hitting stop is:

Could you give it a try with a2dpd plugin and see if these problems remains?
You will not have the same audio quality, but those start/stop problems may disappear.

Thanks,
Frederic


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
