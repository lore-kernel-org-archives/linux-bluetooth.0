Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <26AF0D77A98E09478A577B2248F72338413FF3@sintefxch1-netapp.sintef.no>
From: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Inquiry result with rssi in bluez libs 2.7
MIME-Version: 1.0
Content-Type: text/plain
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 May 2004 15:54:41 +0200

Hi,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org] 
> 
> this was a stupid typo and fixed in CVS now. Thanks for finding it.
> 

While I have your attention on this subject...

In the hci_event.c in net/bluetooth the hci_inquiry_result_with_rssi_evt
function just ignores the rssi value, and files the values of a normal
inquiry_info struct. Is there a plan for how the rssi values should be made
available to the user mode application calling ioctl with HCIINQURY? As far
as I can see there are now way for an application to get this value now.

Regards,
Dag K. W. Rognlien
M.Sc. Computer Engineering
SINTEF ICT
Communication Systems


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
