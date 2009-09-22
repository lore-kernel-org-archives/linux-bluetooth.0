Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1253287883.28416.30.camel@localhost.localdomain>
References: <113d36d80909140452jb808a2bub393aae7307c7450@mail.gmail.com>
	<1252935154.3421.17.camel@localhost.localdomain> <113d36d80909140829g74828077tfd1a56348abcc916@mail.gmail.com>
	<113d36d80909180347g59ac5444ta70e17c7eb3cb86e@mail.gmail.com>
	<1253287883.28416.30.camel@localhost.localdomain>
From: Nick Pelly <npelly@google.com>
Date: Tue, 22 Sep 2009 16:09:22 -0700
Message-ID: <35c90d960909221609j701ac825p368a793b360ef9e7@mail.gmail.com>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lan Zhu <zhu.lan.cn@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

> it gives us to determine that eSCO might not be working good enough. So
> I want output from hcitool info and detailed hcidump.

We can also reproduce this issue with HF850.

hciinfo

Requesting information ...
	BD Address:  00:50:CD:20:C6:84
	Device Name: Motorola HF850
	LMP Version: 1.2 (0x2) LMP Subversion: 0x638
	Manufacturer: Cambridge Silicon Radio (10)
	Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
		<3-slot packets> <5-slot packets> <encryption> <slot offset>
		<timing accuracy> <role switch> <hold mode> <sniff mode>
		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
		<power control> <transparent SCO> <broadcast encrypt>
		<enhanced iscan> <interlaced iscan> <interlaced pscan>
		<inquiry with RSSI> <extended SCO> <AFH cap. slave>
		<AFH class. slave> <AFH cap. master> <AFH class. master>
		<extended features>

Attached is hcidump showing the failed eSCO attempt.

You'll notice in this hcidump we retry with SCO after failed eSCO.
This is because I have applied the following patch:


commit d5d0c6bf73b3b44f1d66bf4f9d7f3365cce70ff0
Author: Nick Pelly <npelly@google.com>
Date:   Tue Sep 22 15:19:46 2009 -0700

    Bluetooth: Fallback to SCO on error code 0x10 (Connection Accept Timeout).

    This is to support the Motorola HF850 carkit which reports the
error code 0x10
    for an eSCO attempt, even though it advertises eSCO support. Here is the
    hcidump:

    2009-09-22 15:40:24.492391 < HCI Command: Setup Synchronous Connection
    (0x01|0x0028) plen 17
        handle 1 voice setting 0x0060
    2009-09-22 15:40:24.493002 > HCI Event: Command Status (0x0f) plen 4
        Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
    2009-09-22 15:40:30.594869 > HCI Event: Synchronous Connect Complete (0x2c)
    plen 17
        status 0x10 handle 257 bdaddr 00:50:CD:20:C6:84 type eSCO
        Error: Connection Accept Timeout Exceeded

    With this patch we will retry with a SCO connection, which succeeds.

    Unfortunately the Moto HF850 also takes 5 seconds to return the
error for the
    eSCO attempt, so it will still take 5 seconds to fallback to SCO with this
    patch.

    Signed-off-by: Nick Pelly <npelly@google.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e99fe38..7c6f62a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1700,6 +1700,7 @@ static inline void
hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_bu

        case 0x1c:      /* SCO interval rejected */
        case 0x1f:      /* Unspecified error */
+       case 0x10:      /* Connection accept timeout - for Motorola HF850 */
                if (conn->out && conn->attempt < 2) {
                        conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
                                        (hdev->esco_type & EDR_ESCO_MASK);
