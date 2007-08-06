Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46B6D6B1.5030007@idlum.be>
References: <46B6CC07.9010105@idlum.be> <1186386755.20129.1.camel@violet>
	<46B6D6B1.5030007@idlum.be>
Date: Mon, 06 Aug 2007 10:14:31 +0200
Message-Id: <1186388071.20129.4.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] "Invalid CID in request"
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

> > what kernel are you using? And I need the full trace from the HCI create
> > connection to the HCI disconnect.
> 
> The kernel used is 2.6.21-2-486 (from debian).
> 
> The file I attached to my last e-mail (re-attached to this one) contains 
> the output of "hcidump -XV", are you requesting something else?

this is unlikely, but try it with only one adapter attached to your
system. I don't expect that to be a problem, because the kernel is
designed to handle the case. However I wanna rule out that it is a
multiple adapter issue.

Second, please try a 2.6.23-rc2 kernel. My wild guess is that the L2CAP
configuration process screws up the phone. We added a fix for that to
make it fully specification compliant.

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
