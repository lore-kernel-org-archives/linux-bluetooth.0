Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <848611830@web.de>
MIME-Version: 1.0
From: "Martin Mueller" <Ma.Mueller@tu-bs.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] cross compiling bluez-utils
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Sat, 05 Feb 2005 07:48:51 +0100

Hi,

> I crosscompiled bluez-libs, bluez-utils and even hciemu for ARM platform 
> and they work fine. I am preparing a little how-to for those insterested 
> on doing the same thing.

They work perfectly here, too. Thanks for the hint! I just found it a little inconvenient to find the /etc/bluetooth/ directory in my ARM gcc directory. To be more specific:

The compiler, libs, include, ... directories reside under /usr/arm/arm-linux. That is set with 'prefix'. The executables then go to something like /home/mm/arm/ramdisk/mnt by setting 'exec_prefix' accordingly. I thought it to be funny to see /etc/bluetooth/ in the ramdisk rather than in the compiler area.

Martin
__________________________________________________________
Mit WEB.DE FreePhone mit hoechster Qualitaet ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/?mc=021201



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
