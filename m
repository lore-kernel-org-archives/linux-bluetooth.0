Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 10 Jul 2006 13:35:08 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060710123507.GA20928@srcf.ucam.org>
References: <20060707192112.GA26163@srcf.ucam.org>
	<1152300678.3693.17.camel@localhost>
Mime-Version: 1.0
In-Reply-To: <1152300678.3693.17.camel@localhost>
Subject: Re: [Bluez-devel] Dbus RFCOMM interface
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

On Fri, Jul 07, 2006 at 09:31:18PM +0200, Marcel Holtmann wrote:

> I marked it as experimental, because we might have to change that
> interface and it is not all of the RFCOMM and SDP stuff is fully
> implemented. However if you start hcid with -x you will get what is
> currently implemented.

Ok. I'll take a look at what's needed in order to implement some of the 
missing RFCOMM methods.

-- 
Matthew Garrett | mjg59@srcf.ucam.org


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
