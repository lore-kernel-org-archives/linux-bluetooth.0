Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Bluetooth and HAL
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: hal@freedesktop.org
In-Reply-To: <pan.2005.01.20.08.17.45.630346@yahoo.com>
References: <pan.2005.01.19.22.54.29.108027@yahoo.com>
	 <1106180785.8190.151.camel@pegasus>
	 <pan.2005.01.20.08.17.45.630346@yahoo.com>
Content-Type: text/plain
Message-Id: <1106225440.8190.175.camel@pegasus>
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
Date: Thu, 20 Jan 2005 13:50:40 +0100

Hi Paul,

> I'll remove the ChipVersion then, and I have some more questions:
> How do we tell if we have a BT 1.0 or BT 1.1 or BT 1.2  adapter ?
> By looking at HCI and LMP numbers ?

it is the HCI_version and LMP_version. They can be different, but in
general they show the same version of the specification.

> Do we need a separate bluetooth.version too ?

No.

> Do end user programs really need HCI and LMP version/revision ?

Only if they wanna display some information about the device. Otherwise
they are useless, because the kernel or the Bluetooth library will hide
the differences.

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
