Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46B737E8.5060106@idlum.be>
Date: Mon, 06 Aug 2007 17:02:00 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] What does error 110 actually mean? What is it caused
	by?
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

Hello,

I keep getting this error in hcid output now and then, and for various 
calls:

(hcid stderr) hcid[32196]: connect(): Connection timed out (110)

 From my limited understanding, this error happens when a hci call to 
the dongle times out. Is it right?

I observed that on some computers, this error happens very often when 
kernel module ehci_hcd is loaded. It is generally coming up less often 
when it is not loaded.

Also, I failed to find any way to have any influence on those errors. I 
start getting them suddenly, and also suddenly, I stop getting them. I 
can have none for hours, and then suddenly lots of them for 5 minutes, 
and afterwards everything works properly again. I can also get one or 
two every few minutes. Really, I can't find a pattern for their appearence.

So what's happening there? Any feedback on this issue would be really 
appreciated.

Best Reagrds,
Pierre-Yves


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
