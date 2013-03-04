Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Mar 2013 13:35:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/11] Bluetooth: Split HCI init sequence into three
 stages
Message-ID: <20130304113511.GA24442@x220>
References: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com>
 <1362391748-21653-4-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_Pj4_O8N1uYVSg6qsJm+L7PyGyPGNo-_y-FC+dWybotqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_Pj4_O8N1uYVSg6qsJm+L7PyGyPGNo-_y-FC+dWybotqQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Mar 04, 2013, Anderson Lizardo wrote:
> On Mon, Mar 4, 2013 at 6:09 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > From: Johan Hedberg <johan.hedberg@intel.com>
> >
> > Having contitional command sending during a request has always been
> > problematic and caused hacks like the hdev->init_last_cmd variable. This
> > patch removes these conditionals and instead splits the init sequence
> > into three stages, each with its own __hci_request() call.
> 
> Typos:
> 
> contitional -> conditional
> __hci_request() -> __hci_req_sync()

Thanks. Will fix.

> > +static int __hci_init(struct hci_dev *hdev)
> > +{
> > +       int err;
> > +
> > +       err = __hci_req_sync(hdev, hci_init1_req, 0, HCI_INIT_TIMEOUT);
> > +       if (err < 0)
> > +               return err;
> > +
> > +       /* AMP controllers do not need stage 2/3 init */
> > +       if (hdev->dev_type != HCI_BREDR)
> > +               return 0;
> 
> What about checking for "dev_type == HCI_AMP" instead? I had to check
> net/bluetooth/hci.h because for a moment I thought Dual mode and
> single mode LE devices were being left out as well. I then realized
> you can only have BREDR vs. AMP controller types.

This logic is a direct copy-paste from the beginning of the existing
hci_setup() function in net/bluetooth/hci_event.c. I could change it to
test specifically for AMP, but then what happens if we add more dev_type
values that also shouldn't have more than the stage 1 init? In that case
a stricter != HCI_BREDR test is safer than a looser == HCI_AMP test.

Johan
