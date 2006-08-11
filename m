Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 11 Aug 2006 13:44:34 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060811134434.7da5cab0@McGee-XPC>
In-Reply-To: <c5cec3110608110427m6669470bt629c145b717a1a1e@mail.gmail.com>
References: <c5cec3110608110427m6669470bt629c145b717a1a1e@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcid problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Hi,

The hcid.conf configures the hcid (HCI Daemon). You need to let that
program know that you changed the config file, maby by simply restarting
it or sending a HUP Signal too it (killall -HUP hcid). Re-Plugging your
device shoud do it too.

Greetings

Andy

On Fri, 11 Aug 2006 19:27:14 +0800
bees <guoqibi@gmail.com> wrote:

> Hi All
> 
>     when I modified the /etc/bluetooth/hcid.conf, the output of "hciconfig
> -a" keep unchanged. Why???
> 
> Regards
> 
> Bees

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
