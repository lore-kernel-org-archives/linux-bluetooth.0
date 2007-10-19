Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <Pine.LNX.4.64.0710190839510.16412@simba.math.ucla.edu>
References: <20071018114517.4b6d1850@ghistelwchlohm.scrye.com>
	<Pine.LNX.4.64.0710181052500.28683@simba.math.ucla.edu>
	<20071018124830.58d558be@ghistelwchlohm.scrye.com>
	<Pine.LNX.4.64.0710190839510.16412@simba.math.ucla.edu>
Message-Id: <C8CB368F-A413-442E-99FA-CF006830DB35@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Fri, 19 Oct 2007 19:42:35 +0300
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth headset not working
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


On Oct 19, 2007, at 19:03, Jim Carter wrote:
> I've seen a similar message when I didn't have bluetoothd-service- 
> audio
> configured to autostart and forgot to start it manually.  Do you  
> have the
> corresponding protocol/profile daemon running?  I don't have my laptop
> handy to look up the name of this daemon but I think it's
> bluetoothd-service-sco.

Actually bluetoothd-service-audio takes care of both A2DP and HSP.  
Unless you specified explicitly the profile to use in your .asoundrc  
(e.g. "profile a2dp") the selection process goes as such that A2DP is  
used if available and otherwise HSP.

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
