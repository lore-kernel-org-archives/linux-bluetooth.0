Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <c4cf8c660605252058n622d6dfak5ad964349551d662@mail.gmail.com>
From: "Timmy Li" <scuttimmy@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] LInux Bluetooth and Audio (OSS) interface
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
Date: Fri, 26 May 2006 11:58:55 +0800

Hello,

    I am a newbie to bluetooth. It seems that there are no integration
on linux bluetooth (SCO link) and audio (OSS) interface, so that there
are no standard API for the user mode audio applications when using or
not using bluetooth handset.
   Bluetooth-alsa seems to be something like that, but it focuses on
Bluetooth + ALSA, I am not sure whether it is a good starting point.

   Can anyone give me some advice on how to provide an uniform
interface for user mode audio applications ? Since it could be
paintful for user mode audio applications to use SCO socket interface
directly and handle the details for bluetooth handset.

   Thanks,

Timmy


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
