Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Re: Re: Re: hciattach problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <420393FA.2070509@web.de>
References: <420393FA.2070509@web.de>
Content-Type: text/plain
Message-Id: <1107532267.6921.46.camel@pegasus>
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
Date: Fri, 04 Feb 2005 16:51:07 +0100

Hi Andreas,

> I have checked the bluez-utils/libs versions and it doesn't depend on 
> it. The Kernel I have tested with is a vanilla kernel with bootsplash, 
> subfs and tiocgdev patches. The 2.6.11-rc2 is a Kernel-of-the-Day kernel 
> from Suse. I attach the card with hciattach ttyS16 csr. That is H4, 
> isn't it? Isn't the problem there with other cards? I will check with a 
> clean vanilla-kernel.

please check 2.6.10-mh1 against 2.6.10-mh2, because otherwise we can't
find the problem. All your other kernels differ too much. The "csr"
option indicates H:4.

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
