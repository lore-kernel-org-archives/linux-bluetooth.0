Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <403F8EAC.40701@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Questions about correctness of hci_usb sco support.
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
Date: Fri, 27 Feb 2004 18:38:36 +0000

In hci_usb.c file, line 604 ish
static inline int __recv_frame(struct hci_usb *husb, int type, void 
*data, int count)

Contains: -
case HCI_SCODATA_PKT:
        if (count >= HCI_SCO_HDR_SIZE) {
                  struct hci_sco_hdr *h = data;
                  len = HCI_SCO_HDR_SIZE + h->dlen;
        } else
                  return -EILSEQ;
        break;

With a SCO HCI packet, it lasts 3 air frames for a bluetooth headset.
How do we know that the first frame we receive from the usb bluetooth 
device is the SCO HCI header?
What happens if the first SCO HCI frame we receive is actually the 
second or third frame in the SCO HCI packet ?
Surely some validation checks need to be done.
For example, depending on the sample format we are using, we should 
already know what the SCO HCI length should be, so we could check this 
against the length in the SCO HCI header, and only accept the frame if 
they match, if they don't match, drop the frame, and wait for the next 
frame.
I would expect similar problems with HCI int/bulk frames, but I don't 
actually see any corrupt int/bulk frames, so I was wondering whether the 
usb bluetooth dongle somehow ensures that the first air frame we receive 
is actually the start of an HCI frame. Maybe it is just luck, as 
int/bulk frames normally have a lot of blank invalid frames in between, 
so maybe as soon as it sees a valid frame, it is always the start of the 
int/bulk frame. I don't think we can make this assumtion all the time, 
in case we start filling the air entirely with bulk frames, and some air 
frames get lost. We will have to drop the hci frame, and then resync 
when the next hci frame arrives.

With SCO HCI frames, there are never gaps between frames, so if we loose 
a single air frame, we would have to somehow resync to get back to the 
SCO HCI header frame.

Can anyone help me understand this?

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
