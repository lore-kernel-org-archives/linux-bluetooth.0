Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco and ACPI suspend to ram and disk
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <pan.2005.02.03.21.45.08.935510@yahoo.com>
References: <pan.2005.02.03.21.45.08.935510@yahoo.com>
Content-Type: text/plain
Message-Id: <1107468588.6911.7.camel@pegasus>
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
Date: Thu, 03 Feb 2005 23:09:48 +0100

Hi Paul,

> I am using snd-bt-sco with my headset, and I noticed that every time that
> snd-bt-sco kernel module is loaded, I cannot suspend to ram or to disk
> using ACPI due to the error bellow.
> I seems that snd-bt-sco refuses to sleep.
> Has anyone experienced this, or is my setup broken ?

your setup is fine, but the snd-bt-sco is broken. The kernel thread is
active blocking and I think the locking is also wrong. The goal is a
ALSA library plugin for the headset support and I am not going to fix
any part of the snd-bt-sco kernel driver.

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
