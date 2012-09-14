Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Sep 2012 10:50:05 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 06/17] Bluetooth: AMP: Physical link struct and heplers
Message-ID: <20120914075003.GC7483@aemeltch-MOBL1>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux>
 <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347437192-24694-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1209130835240.19321@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1209130835240.19321@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Sep 13, 2012 at 08:40:59AM -0700, Mat Martineau wrote:
> >From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> >Define physical link structures. Physical links are represented by
> >hci_conn structure. For BR/EDR we use type ACL_LINK and for AMP
> >we use AMP_LINK.
> >
> >Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >---
> >include/net/bluetooth/hci.h      |    1 +
> >include/net/bluetooth/hci_core.h |   20 ++++++++++++++++++
> >include/net/bluetooth/pal.h      |   26 +++++++++++++++++++++++
> >net/bluetooth/Makefile           |    2 +-
> >net/bluetooth/a2mp.c             |    1 +
> >net/bluetooth/pal.c              |   42 ++++++++++++++++++++++++++++++++++++++
> >6 files changed, 91 insertions(+), 1 deletion(-)
> >create mode 100644 include/net/bluetooth/pal.h
> >create mode 100644 net/bluetooth/pal.c
> >
> >diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >index 1cb8b55..4c41b8c 100644
> >--- a/include/net/bluetooth/hci.h
> >+++ b/include/net/bluetooth/hci.h
> >@@ -207,6 +207,7 @@ enum {
> >#define ESCO_LINK	0x02
> >/* Low Energy links do not have defined link type. Use invented one */
> >#define LE_LINK		0x80
> >+#define AMP_LINK	0x81
> >
> >/* LMP features */
> >#define LMP_3SLOT	0x01
> >diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >index 1174218..4ae5293 100644
> >--- a/include/net/bluetooth/hci_core.h
> >+++ b/include/net/bluetooth/hci_core.h
> >@@ -316,6 +316,7 @@ struct hci_conn {
> >
> >	__u8		remote_cap;
> >	__u8		remote_auth;
> >+	__u8		remote_id;
> >	bool		flush_key;
> >
> >	unsigned int	sent;
> >@@ -510,6 +511,25 @@ static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
> >	return NULL;
> >}
> >
> >+static inline struct hci_conn *hci_conn_hash_lookup_id(struct hci_dev *hdev,
> >+						       __u8 remote_id)
> >+{
> >+	struct hci_conn_hash *h = &hdev->conn_hash;
> >+	struct hci_conn  *c;
> >+
> >+	rcu_read_lock();
> >+
> >+	list_for_each_entry_rcu(c, &h->list, list) {
> >+		if (c->remote_id == remote_id) {
> >+			rcu_read_unlock();
> >+			return c;
> >+		}
> >+	}
> >+	rcu_read_unlock();
> >+
> >+	return NULL;
> >+}
> >+
> 
> If there are multiple AMP physical links to different devices, the
> remote_id probably isn't enough information to look up a physical
> link.  Most of the time the remote_id will be "1", so there will
> probably be multiple hci_conns with the same remote_id.

I am thinking then we might use dst address and use function below.

> 
> l2cap_conn + remote_id should be unique, though.
> 
> >static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
> >							__u8 type, bdaddr_t *ba)
> >{

like

hci_conn_hash_lookup_ba(hdev, AMP_LINK, dst)


Best regards 
Andrei Emeltchenko 
