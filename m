Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42036A83.8090309@web.de>
From: Andreas Millinger <andreas.millinger@web.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-devel] hciattach problem
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
Date: Fri, 04 Feb 2005 13:28:51 +0100

Hello,

I have also a Problem with hciattach. As written in a Thread befor a kill of hciattach causes a System freez. Also the System hangs, when I want to shutdown the System at shuting down PCMCIA. I have tested with different kernels an bluez-utils/lib versions. I have found out, that with kernel 2.6.10 and bluez-utils/lib 2.14 the problem isn't there. With patch mh1 it works also. But with patch mh2 or kernel 2.6.11-rc2 or with kernel 2.6.10 and utils/lib 2.15 the freez is also there. I have a 3com Version 3 PCMCIA Card.

Best regards

Andreas





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
