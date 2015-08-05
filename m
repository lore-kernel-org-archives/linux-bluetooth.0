Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v7 2/6] Bluetooth: add hci_lookup_le_connecting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438694299-5991-2-git-send-email-jpawlowski@google.com>
Date: Tue, 4 Aug 2015 18:38:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <53C6CC47-57B6-4DBA-8FC8-E01C274E5E8A@holtmann.org>
References: <1438694299-5991-1-git-send-email-jpawlowski@google.com> <1438694299-5991-2-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,


> This patch adds hci_lookup_le_connecting method flags, that will be set
> hash lookup where appropriate to check wether connect is in progress.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci_core.h | 20 ++++++++++++++++++++
> net/bluetooth/hci_conn.c         |  5 ++---
> net/bluetooth/hci_event.c        |  4 ++--
> net/bluetooth/hci_request.c      |  6 ++----
> net/bluetooth/mgmt.c             |  2 +-
> 5 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index c8d2b5a..8dfd9e8 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -811,6 +811,26 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
> 	return NULL;
> }
> 
> +static inline struct hci_conn *hci_lookup_le_connecting(struct hci_dev *hdev)
> +{
> +	struct hci_conn_hash *h = &hdev->conn_hash;
> +	struct hci_conn  *c;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(c, &h->list, list) {
> +		if (c->type == LE_LINK && c->state == BT_CONNECT &&
> +		    !test_bit(HCI_CONN_SCANNING, &c->flags)) {
> +			rcu_read_unlock();
> +			return c;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return NULL;
> +}

I wonder if naming this hci_conn_lookup_le_connect() might be a bit cleaner. My main reason is that we never used the full term "connecting" in the kernel code. In most cases it was just "connect" like in BT_CONNECT and it meant connecting state.

Using the prefix hci_ vs hci_conn is something we could argue about. Strictly speaking the whole clear hci_conn separation that we once had is getting weak and I am actually fine with breaking it.

Regards

Marcel

