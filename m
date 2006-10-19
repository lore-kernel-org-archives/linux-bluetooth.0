Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 19 Oct 2006 15:35:16 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061019123516.GA19233@localhost.localdomain>
References: <20061019115608.GB31910@suse.de>
	<1161259469.27710.40.camel@localhost>
	<20061019123133.GA18838@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20061019123133.GA18838@localhost.localdomain>
Subject: Re: [Bluez-users] DiscoverDevices with apitest?
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

Should have actually tested the patch first...

On Thu, Oct 19, 2006, Johan Hedberg wrote:
> +        else if not self.listen:

This should of course be "elif not self.listen:"

Johan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
