Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with patch for 2.6.10...
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1106739703.6665.5.camel@localhost.localdomain>
References: <1106739703.6665.5.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1106760809.28444.39.camel@pegasus>
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
Date: Wed, 26 Jan 2005 18:33:29 +0100

Hi Rob,

> I've just applied the latest patch ( 2.6.10-mh2 ) to the latest
> available kernel source for Fedora Core 3 from their update site (2.6.10
> with a few patches applied).  All was well except that a patch for the
> Makefile was rejected due to the EXTRAVERSION flag being different.
> Everything built and installed perfectly, but now I'm getting the
> following on bootup.  I've also upgraded the stock bluez-libs and bluez-
> utils rpms for FC3 with the latest from the bluez.org site.

use a vanilla 2.6.10, because the -mh patches are not made to work with
any distribution kernels. If they do feel happy, if not, blame them.

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
