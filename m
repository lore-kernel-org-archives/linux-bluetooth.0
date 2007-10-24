Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@kernel.org>
In-Reply-To: <20071024162635.GM30533@stusta.de>
References: <20071024162635.GM30533@stusta.de>
Date: Wed, 24 Oct 2007 18:39:26 +0200
Message-Id: <1193243966.6184.248.camel@violet>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sf.net, maxk@qualcomm.com,
        David Vrabel <david.vrabel@csr.com>
Subject: Re: [Bluez-devel] [2.6 patch] drivers/bluetooth/btsdio.c: fix
	double-free
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

Hi Adrian,

> This patch fixes a double-free spotted by the Coverity checker.

good catch. Patch has been applied to me tree. Thanks.

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
