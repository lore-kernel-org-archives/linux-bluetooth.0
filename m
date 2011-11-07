Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 16:09:04 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Create hci_do_inquiry()
Message-ID: <20111107140901.GC10810@aemeltch-MOBL1>
References: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org>
 <20111107090343.GA10810@aemeltch-MOBL1>
 <6FA63277-5FDE-44FE-B4CC-17DACEDE7A18@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6FA63277-5FDE-44FE-B4CC-17DACEDE7A18@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Nov 07, 2011 at 10:58:29AM -0300, Andre Guedes wrote:
> Hi Andrei,
> 
> On Nov 7, 2011, at 6:03 AM, Andrei Emeltchenko wrote:
> 
> > Hi Andre,
> > 
> > On Fri, Nov 04, 2011 at 02:16:51PM -0300, Andre Guedes wrote:
> >> This patch adds a function to hci_core to carry out inquiry.
> >> 
> >> All inquiry code from start_discovery() were replaced by a
> >> hci_do_inquiry() call.
> >> 
> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> ---
> >> include/net/bluetooth/hci_core.h |    2 ++
> >> net/bluetooth/hci_core.c         |   17 +++++++++++++++++
> >> net/bluetooth/mgmt.c             |    9 +--------
> >> 3 files changed, 20 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >> index f97792c..ae36ac0 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -970,4 +970,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> >> void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
> >> void hci_le_ltk_neg_reply(struct hci_conn *conn);
> >> 
> >> +int hci_do_inquiry(struct hci_dev *hdev, u8 length);
> >> +
> >> #endif /* __HCI_CORE_H */
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index b7f6b5b..098f26c 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -2560,3 +2560,20 @@ static void hci_cmd_task(unsigned long arg)
> >> 		}
> >> 	}
> >> }
> >> +
> >> +int hci_do_inquiry(struct hci_dev *hdev, u8 length)
> >> +{
> >> +	u8 lap[3] = { 0x33, 0x8b, 0x9e };
> > 
> > what are those numbers above?
> 
> This is the general inquiry LAP value defined in page 314 of
> Core spec.

Can we define those numbers (like HCI_GENERAL_INQ_LAP) or put comments?

Best regards 
Andrei Emeltchenko 

> 
> > 
> >> +	struct hci_cp_inquiry cp;
> >> +
> >> +	BT_DBG("%s", hdev->name);
> >> +
> >> +	if (test_bit(HCI_INQUIRY, &hdev->flags))
> >> +		return -EINPROGRESS;
> >> +
> >> +	memset(&cp, 0, sizeof(cp));
> >> +	memcpy(&cp.lap, lap, 3);
> > 
> > sizeof(lap) looks better
> 
> Ok, I'll change this.
> 
> BR,
> 
> Andre
