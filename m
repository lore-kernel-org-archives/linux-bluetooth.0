Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hciattach problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <42036A83.8090309@web.de>
References: <42036A83.8090309@web.de>
Content-Type: text/plain
Message-Id: <1107521182.6921.12.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 04 Feb 2005 13:46:22 +0100

Hi Andreas,

> I have also a Problem with hciattach. As written in a Thread befor a kill of hciattach causes a System freez. Also the System hangs, when I want to shutdown the System at shuting down PCMCIA. I have tested with different kernels an bluez-utils/lib versions. I have found out, that with kernel 2.6.10 and bluez-utils/lib 2.14 the problem isn't there. With patch mh1 it works also. But with patch mh2 or kernel 2.6.11-rc2 or with kernel 2.6.10 and utils/lib 2.15 the freez is also there. I have a 3com Version 3 PCMCIA Card.

please check if the bluez-utils version really matters.

So the bad patch is between 2.6.10-mh1 and 2.6.10-mh2 and the 3Com
version 3 card is using BCSP, right?

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
