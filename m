Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.net,
   kernel-janitors@lists.osdl.org
In-Reply-To: <20050120235123.GG2600@us.ibm.com>
References: <20050120235123.GG2600@us.ibm.com>
Content-Type: text/plain
Message-Id: <1106267534.7955.36.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH 18/39] net/core: use wait_event_timeout()
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
Date: Fri, 21 Jan 2005 01:32:14 +0100

Hi Nishanth,

> Description: Use wait_event_timeout() instead of custom wait-queue code.
> The current code uses TASK_INTERRUPTIBLE but only cares about timing out and the
> wq event taking place (does not actively do anything in response to signals), so
> wait_event_timeout() should be ok.

this one results in:

  CC [M]  net/bluetooth/hidp/core.o
net/bluetooth/hidp/core.c: In function `hidp_session':
net/bluetooth/hidp/core.c:547: warning: passing arg 1 of `prepare_to_wait' from incompatible pointer type
net/bluetooth/hidp/core.c:547: warning: passing arg 1 of `finish_wait' from incompatible pointer type
net/bluetooth/hidp/core.c:551: warning: passing arg 1 of `prepare_to_wait' from incompatible pointer type
net/bluetooth/hidp/core.c:551: warning: passing arg 1 of `finish_wait' from incompatible pointer type

Please fix this and re-submit.

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
