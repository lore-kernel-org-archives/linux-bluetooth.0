Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <pan.2007.08.19.18.35.25@yahoo.com>
References: <pan.2007.08.19.18.35.25@yahoo.com>
Date: Fri, 24 Aug 2007 14:31:47 +0200
Message-Id: <1187958707.15402.173.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SCO flow control status
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

Hi Johan,

> I'm one of those unfortunates who have a Broadcom bluetooth 
> controller and as a consequence I have to use the SCO flow control kernel 
> patch to be able to use my headset.
> 
> This issue does not appear to be have been fixed in the latest (2.6.23-
> rc3) kernel but the bluetooth subsystem has changed enough for the patch 
> not to apply cleanly anymore.
> 
> Is a fix for this issue in the works? I remember seeing a message by 
> Marcel Holtmann where he said he preferred a different fix, but I haven't 
> seen anything since then.

it currently conflicts with may work on full eSCO support.

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
