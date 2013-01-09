Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Jan 2013 15:48:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/8] Bluetooth: Fix checking for exact values of boolean
 mgmt parameters
Message-ID: <20130109134837.GA4933@x220>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
 <1357738180-4128-8-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_PZ5i-3HqmbL7YT5F59ycBJP3g83RMcWBBmKS9H02NJbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_PZ5i-3HqmbL7YT5F59ycBJP3g83RMcWBBmKS9H02NJbQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Jan 09, 2013, Anderson Lizardo wrote:
> Hi Johan,
> 
> On Wed, Jan 9, 2013 at 9:29 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > @@ -1219,6 +1247,10 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
> >                 return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
> >                                   MGMT_STATUS_NOT_SUPPORTED);
> >
> > +       if (cp->val != 0x00 && cp->val != 0x01)
> > +               return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
> > +                                 MGMT_STATUS_INVALID_PARAMS);
> > +
> 
> I think you meant "MGMT_OP_SET_LE" here.

Good catch. A copy-paste mistake I should have caught.

> Can mgmt-tester be modified to check for this as well?

Yes, I don't think it has any set_le test cases yet. Patches are
welcome!

Johan
