Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Inquiry result with rssi in bluez libs 2.7
From: Marcel Holtmann <marcel@holtmann.org>
To: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <26AF0D77A98E09478A577B2248F72338413FF3@sintefxch1-netapp.sintef.no>
References: 
	 <26AF0D77A98E09478A577B2248F72338413FF3@sintefxch1-netapp.sintef.no>
Content-Type: text/plain
Message-Id: <1084382753.25099.85.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 12 May 2004 19:25:53 +0200

Hi Dag,

> In the hci_event.c in net/bluetooth the hci_inquiry_result_with_rssi_evt
> function just ignores the rssi value, and files the values of a normal
> inquiry_info struct. Is there a plan for how the rssi values should be made
> available to the user mode application calling ioctl with HCIINQURY? As far
> as I can see there are now way for an application to get this value now.

go ahead and write a patch for the Bluetooth core to store the RSSI
value so first it will be exported via /sys in the inquiry_cache. Then
we can think about adding an ioctl that is capable of handling the RSSI
values.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
