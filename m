Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <003101c4ca02$b9f20d90$6f04a8c0@ZBOX>
From: "Suriyan" <suriyan@netgadgets.co.th>
To: <bluez-devel@lists.sourceforge.net>
References: <20041110041405.3CC331D4758@sc8-sf-uberspam1.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=windows-874
Subject: [Bluez-devel] Re: multi rfcomm/sco connection
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 14 Nov 2004 11:30:52 +0700

Hi Marcel,

I just found the way to work with three headsets over only one
Bluetooth dongle by a few hardcoded to BlueZ:-

1. force alternate setting of USB interface number 1, isochronous
    endpoint to 5 (3 voice channels with 16 bit encoding)

when three SCO channels connected (by run three hsplay consecutively)
I found each incoming SCO HCI frame size up to 144 bytes (as I known
previously one voice channel with 16-bit encoding SCO HCI frame size
equals 48 bytes so that three channels 48 * 3 = 144 bytes)

This mean one HCI frame to transmit/receive for each SCO channel
over USB isochronous endpoint when three SCO channels were
connected have frame size equals 144 bytes + 3 bytes header
(handle and size) but I not sure this is CSR specific since Bluetooth
HCI USB transport specification (H:2) have not details in this point,
define only suggested Max Packet Size of each USB frame for transport
SCO HCI frame.

This cause I must do the second step,

2. bypass checking (skb->len > hdev->sco_mtu) in function
    hci_send_sco(...) [hci_core.c] and (len > conn->mtu) in
    function sco_send_frame(...) [sco.c]
    *** I just think, this step maybe change by hciconfig tool. ***

Next step, I would like to fixed to dynamicaly change the alternate setting
by looking for previous thread "question about hci_usb endpoint
selection..." as you known in notify() cannot call usb_set_interface()
since always in_interrupt() so that I would like to purpose to add ioctl()
into hci_usb driver to do this or do you have others better approach?

Last, I found new problem when three SCO channels were connected
ACL links (RFCOMM) that also connected to three Headset for control have
very long response time (sometime up to 10 seconds or more to appear
after I pressed a button on Headset). What are the sources of this problem?
- Bandwidth limitation of Bluetooth and theirs packet type?
- Implementation of Bluetooth firmware on USB dongle?
- Implementation of USB stack on Linux?
- Implementation of BlueZ stack?

Regards

Suriyan.




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
