Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46B6CC07.9010105@idlum.be>
References: <46B6CC07.9010105@idlum.be>
Date: Mon, 06 Aug 2007 09:52:35 +0200
Message-Id: <1186386755.20129.1.camel@violet>
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

> Trying to perform a full SDP extraction on a nokia N70, I got several 
> time the error below (full hcidump log attached).
> 
>    > ACL data: handle 11 flags 0x02 dlen 14
>        L2CAP(s): Command rej: reason 2 dcid 0x0000 scid 0x0040
>          Invalid CID in request
>    > ACL data: handle 11 flags 0x02 dlen 14
>        L2CAP(s): Command rej: reason 2 dcid 0x0000 scid 0x0040
>          Invalid CID in request
> 
> In don't understand what happens here, nor the meaning of this error. 
> Could someone please explain it?

what kernel are you using? And I need the full trace from the HCI create
connection to the HCI disconnect.

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
