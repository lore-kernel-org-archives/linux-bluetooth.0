Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 13 Feb 2007 20:07:09 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070213190709.GC14202@suse.de>
References: <45CC5281.9090209@voelkers.org> <20070209114308.GA16231@suse.de>
	<1171309299.11774.18.camel@violet>
MIME-Version: 1.0
In-Reply-To: <1171309299.11774.18.camel@violet>
Subject: Re: [Bluez-devel] Two sticks for a developer
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

On Mon, Feb 12, 2007 at 08:41:38PM +0100, Marcel Holtmann wrote:
> Hi Stefan,
> 
> > > many annoying messages about unknown sco packages in the syslog (>1000/min)
> > 
> > This one can probably be fixed by using
> > modprobe hci_usb isoc=1
> 
> actually it would be isoc=0.

Oops. Lucky me, i have all my adapters already blacklisted, so i did not need
this parameter for a long time now ;-)
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out." 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
