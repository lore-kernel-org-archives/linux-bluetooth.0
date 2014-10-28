Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Bluetooth : Fix hci_sync miss wakeup interrupt
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=us-ascii
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <132658595.194181413985732727.JavaMail.weblogic@epmlwas01a>
Date: Tue, 28 Oct 2014 10:26:38 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6112AC01-B1C4-4DF8-8085-63334761D725@holtmann.org>
References: <132658595.194181413985732727.JavaMail.weblogic@epmlwas01a>
To: chanyeol.park@samsung.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> __hci_cmd_sync_ev(), __hci_req_sync() could miss wake_up_interrupt from
> hci_req_sync_complete() because hci_cmd_work() workquee and its reponse
> could be completed before they are ready to get the signal through
> add_wait_queue(), set_current_state(TASK_INTERRUPTIBLE).
> 
> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> net/bluetooth/hci_core.c | 18 +++++++++++-------
> 1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cb05d7f..c008f1f 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1147,13 +1147,15 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
> 
>        hdev->req_status = HCI_REQ_PEND;
> 
> -       err = hci_req_run(&req, hci_req_sync_complete);
> -       if (err < 0)
> -               return ERR_PTR(err);
> -

the whole patch has whitespace damages. Please fix this.

Regards

Marcel

