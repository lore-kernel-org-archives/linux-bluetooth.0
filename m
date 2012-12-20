Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Dec 2012 11:37:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrey Voropaev <voropaev.andrey@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Authentication Rejected when pairing stereo headset
Message-ID: <20121220093742.GA6548@x220>
References: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
 <20121220080447.GA561@x220>
 <CAFOXTde8iSouGKEVZKG-egvPUr4LAyLnFigVa6avhpqTjXNq8A@mail.gmail.com>
 <20121220091943.GA5862@x220>
 <CAFOXTdf9qrtXD0GPDBFLhLX66QGQCgF_VzyS8WWz5xTAH8+0zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <CAFOXTdf9qrtXD0GPDBFLhLX66QGQCgF_VzyS8WWz5xTAH8+0zQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrey,

On Thu, Dec 20, 2012, Andrey Voropaev wrote:
> > Actually the hcidump helped a lot. It shows an issue on the kernel side:
> >
> >  < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
> >      bdaddr 00:1A:7D:25:2C:A4 capability 0x04 oob 0x00 auth 0x03
> >      Capability: Reserved (OOB data not present)
> >      Authentication: Dedicated Bonding (MITM Protection)
> >  > HCI Event: Command Complete (0x0e) plen 10
> >      IO Capability Request Reply (0x01|0x002b) ncmd 1
> >      status 0x12 bdaddr 00:1A:7D:25:2C:A4
> >      Error: Invalid HCI Command Parameters
> >
> > The IO capability value 0x04 that the kernel is responding with is
> > invalid and shouldn't be sent to the controller. This was already fixed
> > quite long time ago (about 1 year ago) by the following patch from
> > Hemant Gupta: "Bluetooth: Send correct response to IO Capability Request"
> >
> > It adds the following code to the IO capability handling to avoid 0x04
> > from being sent:
> >
> >         /* Change the IO capability from KeyboardDisplay
> >          * to DisplayYesNo as it is not supported by BT spec. */
> >         cp.capability = (conn->io_capability == 0x04) ?
> >                                         0x01 : conn->io_capability;
> >
> > It seems however that your kernel is missing this patch and the right
> > way forward would be to include it.
> 
> I'm using Gentoo with "stable" version 3.5.7. Can you please tell me
> which file shall contain this patch? I'll try to find "development"
> version of kernel that contains it.

The file involved is net/bluetooth/hci_event.c. I've attached the patch
to this email.

An quicker way for you to overcome the issue is to change the user space
side pairing call to pass "DisplayYesNo" instead of "KeyboardDisplay" to
BlueZ. I.e. edit the simple-agent script, find the (two) occurrences of
"KeyboardDisplay" and change them to "DisplayYesNo" and try to pair
again.

Johan

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Bluetooth-Send-correct-response-to-IO-Capability-Req.patch"

>From 7a7f1e7c857959f5298020969741e389f21edbae Mon Sep 17 00:00:00 2001
From: Hemant Gupta <hemant.gupta@stericsson.com>
Date: Mon, 16 Jan 2012 13:34:29 +0530
Subject: [PATCH] Bluetooth: Send correct response to IO Capability Request

This patch sends correct IO Capability response to remote device
in case Local Device supports KeyBoardDisplay IO Capability as
this capability is not valid as per BT spec for IO capability
Request Reply Command.
This capability is mapped to DisplayYesNo which is in accordance
with BT spec.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6fb9016..041a35e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2965,7 +2965,10 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 		struct hci_cp_io_capability_reply cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.capability = conn->io_capability;
+		/* Change the IO capability from KeyboardDisplay
+		 * to DisplayYesNo as it is not supported by BT spec. */
+		cp.capability = (conn->io_capability == 0x04) ?
+						0x01 : conn->io_capability;
 		conn->auth_type = hci_get_auth_req(conn);
 		cp.authentication = conn->auth_type;
 
-- 
1.8.0.2


--J/dobhs11T7y2rNN--
