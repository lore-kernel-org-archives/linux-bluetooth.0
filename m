Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.net,
   kernel-janitors@lists.osdl.org
In-Reply-To: <20050202225855.GY2546@us.ibm.com>
References: <20050202225855.GY2546@us.ibm.com>
Content-Type: text/plain
Message-Id: <1107386189.11944.21.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH 19/20] bluetooth/bluecard_cs: remove
 interruptible_sleep_on_timeout() usage
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 03 Feb 2005 00:16:29 +0100

Hi Nish,

> Please consider applying.
> 
> Description: Remove deprecated interruptible_sleep_on_timeout() function calls
> and replace with direct wait-queue usage. Some naming conflicts occurred, which
> I tried to resolve appropriately. Patch is compile-tested.

you introduce more code than you remove. Is our code a special case or
why don't exists a simple API function as replacement?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
