Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <00ef01c8214f$1f9cc580$0200a8c0@jester>
References: <000001c8212f$58c2cc80$0a486580$@savary@kerlink.fr>
	<00ef01c8214f$1f9cc580$0200a8c0@jester>
Date: Wed, 07 Nov 2007 19:28:21 +0100
Message-Id: <1194460101.4635.3.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bluez libs 3.22 & hci_read_remote_name
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

Hi Olivier,

> I have big problems making "hci_read_remote_name" work using libs 3.22, it 
> is very long or blocking.

I have seen that issue, too. However right now, I don't know what is
wrong with the code. It looks good to me. Must be some obvious thinko.

> I had to roll back to 3.20 which is working fine.

The 3.21 should be fine, too.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
