Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <37D1FAB2FA7B7E4993785B956F853C73181460@ednex506.dsto.defence.gov.au>
From: "Wodecki, Victor (Contractor)" <Victor.Wodecki@dsto.defence.gov.au>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-devel] HCI Events and errors
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
Date: Wed, 2 Feb 2005 13:29:39 +1030

I've been experimenting with bluetooth on a HP iPAQ h5550 with a modified
kernel, with mixed success.

The h5550 is running a kernel based on the handhelds.org CVS tree (hh36?)
plus a recent BlueZ, Mipv6, etc.  The ipaq can receive bluetooth data at
a good rate (observed 690 kbps), but has problems transmitting.

The tests are done with a program which opens and writes to an l2cap
socket, repeatedly sending messages of arbitrary size and with arbitrary
delays between each message.  One end of the link is the ipaq, the other
is a desktop machine with a USB bluetooth dongle.

If I reduce the effective outgoing rate by using a suitable combination
of message size and delay between messages, outgoing communications can
be sustained, but not beyond roughly 50kpbs or so.  Above this approximate
rate, the data is sent successfully for a few minutes, until the
application code receives a 'resource unavailable' error after a send()
call.

hcidump shows that the data flows for a while, at some point gets a HCI
Hardware Error event, and then data soon ceases to flow.  I've enabled
debug messages in the bluez modules, and it shows that the eventual error
at send() is due to bluez being unable to allocate a sk_buf for an outgoing
fragment.  BlueZ was correctly sending ACL packets for each, but after a
while the lower layers stop working and presumably the sk_buf's just queue
up unserviced.

Subsequent bluetooth comms, eg 'hcitool inq', result in timeouts, needing
a reload of the stack before things will work again.

Looking at a combination of the BlueZ code, the hcidump trace, and the kernel
log, shows that after the last successful message is sent, the stack appears
to have received a HCI event with event code 0x10 from the HCI controller.

According to the Bluetooth spec (v1.1), a HCI event packet with event code
of 0x10 is a HCI Hardware Error Event.  There is no #define for this in
hci.h, probably need something like HCI_EV_HARDWARE_ERROR.

Appendix H:4 (HCI UART Transport layer), section 4 reads: "If the UART 
synchronization is lost in the communication from Host to Host Controller,
then the Host Controller shall send a Hardware Error Event to tell the
Host about the synchronization error. The Host Controller will then expect
to receive an HCI_Reset command from the Host in order to perform a reset.
The Host Controller will also use the HCI_Reset command in the byte stream
from Host to Host Controller to re-synchronize."

So it appears that the BlueZ code (hci_event_packet()) is not handling the
hardware error event, it just falls out the bottom of the switch statement
when instead it should be detecting the condition and somehow sending the
HCI_Reset command.

Is my understanding of the situation correct?  I haven't yet tried to write
a fix, I wanted to make sure I wasn't heading in the wrong direction first.

-- 

This email remains the property of the Australian Defence Organisation and is subject to the jurisdiction of section 70 of the Crimes Act 1914.  If you have received this email in error, you are requested to contact the sender and delete the email.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
