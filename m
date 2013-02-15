Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 10:17:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 09/12] Bluetooth: Add HCI init sequence support for HCI
 transactions
Message-ID: <20130215081735.GA4737@x220>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
 <1360767045-26958-10-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_OZFTKo5th9ZGUomPtgythQpGCk2=K4JN5GoD6NC6sFWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_OZFTKo5th9ZGUomPtgythQpGCk2=K4JN5GoD6NC6sFWg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Feb 13, 2013, Anderson Lizardo wrote:
> Hi Johan,
> 
> On Wed, Feb 13, 2013 at 10:50 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > +static void hci_resend_last(struct hci_dev *hdev)
> > +{
> > +       struct hci_transaction *transaction;
> > +       struct hci_command_hdr *sent;
> > +       struct sk_buff *skb;
> > +       u16 opcode;
> > +
> > +       if (!hdev->sent_cmd)
> > +               return;
> > +
> > +       sent = (void *) hdev->sent_cmd->data;
> > +       opcode = __le16_to_cpu(sent->opcode);
> 
> Where is "opcode" used?

To retain the old logic in hci_req_complete() the intention here was to
check for HCI_OP_RESET and return. I've fixed it in v2.

Johan
