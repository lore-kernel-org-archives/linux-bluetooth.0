Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: how bluez supports ESCO link? 
Date: Tue, 9 Dec 2008 14:38:46 +0800
Message-ID: <15A39AF0EC0CC0418BE4B70B810E61B70143C694@zmy16exm72.ds.mot.com>
From: "Shi Buyun-FVBP83" <FVBP83@motorola.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi, all
In the current linux 2.6.25 kernel code, can Bluez setup ESCO link?
I found in net/bluetooth/sco.c, sco_connect defined as:

static int sco_connect(struct sock *sk)
{
 if (lmp_esco_capable(hdev) && !disable_esco)
  type = ESCO_LINK;
 else
  type = SCO_LINK;
 
 hcon = hci_connect(hdev, type, dst, HCI_AT_NO_BONDING);
 }
this code shows bluez supports ESCO link.
 
But in function struct hci_conn * hci_connect(struct hci_dev *hdev, int
type, bdaddr_t *dst)
{
 if (type == SCO_LINK) {
  struct hci_conn *sco;
 
  if (!(sco = hci_conn_hash_lookup_ba(hdev, SCO_LINK, dst))) {
   if (!(sco = hci_conn_add(hdev, SCO_LINK, dst))) {
    hci_conn_put(acl);
    return NULL;
   }
  }
  acl->link = sco;
  sco->link = acl;
 
  hci_conn_hold(sco);
 
  if (acl->state == BT_CONNECTED && 
    (sco->state == BT_OPEN || sco->state == BT_CLOSED))
   hci_add_sco(sco, acl->handle);
 
  return sco;
 } else {
  return acl;
 }
} 
the else switch shows it does nothing when type NOT equal to SCO_LINK.
Should this code need to modify or this is intended to designed?
 
Brs
Shi Buyun
