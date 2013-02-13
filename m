Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1360767045-26958-10-git-send-email-johan.hedberg@gmail.com>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
	<1360767045-26958-10-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 13 Feb 2013 13:10:00 -0400
Message-ID: <CAJdJm_OZFTKo5th9ZGUomPtgythQpGCk2=K4JN5GoD6NC6sFWg@mail.gmail.com>
Subject: Re: [PATCH 09/12] Bluetooth: Add HCI init sequence support for HCI transactions
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Feb 13, 2013 at 10:50 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> +static void hci_resend_last(struct hci_dev *hdev)
> +{
> +       struct hci_transaction *transaction;
> +       struct hci_command_hdr *sent;
> +       struct sk_buff *skb;
> +       u16 opcode;
> +
> +       if (!hdev->sent_cmd)
> +               return;
> +
> +       sent = (void *) hdev->sent_cmd->data;
> +       opcode = __le16_to_cpu(sent->opcode);

Where is "opcode" used?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
