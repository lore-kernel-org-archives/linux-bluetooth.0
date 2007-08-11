Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46B737E8.5060106@idlum.be>
References: <46B737E8.5060106@idlum.be>
Date: Sat, 11 Aug 2007 20:18:39 +0200
Message-Id: <1186856319.6698.35.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] What does error 110 actually mean? What is
	it	caused by?
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

Hi Pierre-Yves,

> I keep getting this error in hcid output now and then, and for various 
> calls:
> 
> (hcid stderr) hcid[32196]: connect(): Connection timed out (110)
> 
>  From my limited understanding, this error happens when a hci call to 
> the dongle times out. Is it right?
> 
> I observed that on some computers, this error happens very often when 
> kernel module ehci_hcd is loaded. It is generally coming up less often 
> when it is not loaded.
> 
> Also, I failed to find any way to have any influence on those errors. I 
> start getting them suddenly, and also suddenly, I stop getting them. I 
> can have none for hours, and then suddenly lots of them for 5 minutes, 
> and afterwards everything works properly again. I can also get one or 
> two every few minutes. Really, I can't find a pattern for their appearence.
> 
> So what's happening there? Any feedback on this issue would be really 
> appreciated.

no idea. Are you running a 2.6.22 kernel and bluez-utils-3.14? If not,
please re-test and try to figure out which part of the code is causing
them. Look through the code for "connect()".

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
