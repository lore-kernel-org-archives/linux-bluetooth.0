Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: Don Alexander <bluez-dev@roosoft.ltd.uk>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46988514.9000601@roosoft.ltd.uk>
References: <46988514.9000601@roosoft.ltd.uk>
Date: Tue, 24 Jul 2007 00:32:00 +0100
Message-Id: <1185233520.3641.85.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Configuration for a Linux Bluetooth print Server
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sat, 2007-07-14 at 09:11 +0100, Don Alexander wrote:
> Hi All,
> 
> I know it is perhaps breaking etiquette as this really ought to be a
> user issue. But I have to say I cannot find anywhere in the code or in
> the documentation how to achieve  the above task. Simply put, should
> we not be able to set up the stack to emulate a Bluetooth enable
> printer and be able to pass print data onto the normal printer
> functions of CUPS etc. ? Now before anyone starts misunderstanding me
> I am NOT talking about printing TO bluetooth printers (using the CUPS
> driver) but printing TO a Linux box that identifies itself as being a
> compatible bluetooth printer. Obviously the advantages of this are
> enormous by converting any CUPS attached printer into being a
> bluetooth enabled one.
> 
> So my question are :
> 
> 1) Is this feasible to implement a printer class into the Bluez stack
> or it is a userspace problem?

User-space.

> 2) If it is the right thing to do via the stack how would it best be
> implemented?
> 
> 3) What extensions/ API's ought we attach to a generic printer class
> so that data can be exported to the normal print subsystem.

You need to implement a full SPP or HCRP server. HCRP is probably
easier, as you would just push everything to the CUPS server as-is.

Both specs are available on the Bluetooth SIG website.

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
