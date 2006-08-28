Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 28 Aug 2006 19:20:22 +0200
From: Jimmi <jimmi@bglug.it>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060828172022.GA5370@jimmi.home>
References: <20060805103737.GB6035@jimmi.home> <44D489D5.2040509@schugy.de>
	<20060805131519.GA6170@jimmi.home>
	<20060817115818.GA6365@jimmi.home>
MIME-Version: 1.0
In-Reply-To: <20060817115818.GA6365@jimmi.home>
Subject: Re: [Bluez-users] Again down with Jabra BT250V
Reply-To: jimmi@bglug.it, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 170806 alle 13:58, Jimmi wrote:
> I did several  attempts without results. I will thank  anybody for any
> suggestion :)

After reading  some post  here it  came in my  mind to  try reinstalling
bluez-pin. I purged the Debian package and installed again and magically
it started working! 8)

The difference is that now the device is /dev/dsp2 instead of /dev/dsp1.

Hope this may help somebody ;)
-- 
   ---         _   o       | If God had intended man to use the metric |
   / immi   ---  _/\_>     |   system, Jesus would have only had ten   |
(_/          -  O,> / O    |                disciples.                 |

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
