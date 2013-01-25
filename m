Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2013 08:37:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/6] Bluetooth: Refactor UUID-16 list generation into its
 own function
Message-ID: <20130125063752.GA16528@x220.ger.corp.intel.com>
References: <1359054206-19528-1-git-send-email-johan.hedberg@gmail.com>
 <1359054206-19528-5-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_OMiH4vcoQSG1x++_G_nnQiTseb-moF8p=9k2utE=gAEg@mail.gmail.com>
 <CAJdJm_OqePCY1yMvJTwaUDnXTMbDJgucbYvEWT99=K9tbvgYQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_OqePCY1yMvJTwaUDnXTMbDJgucbYvEWT99=K9tbvgYQg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jan 24, 2013, Anderson Lizardo wrote:
> On Thu, Jan 24, 2013 at 4:21 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > Hi Johan,
> >
> > On Thu, Jan 24, 2013 at 3:03 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> >> +static u8 *create_uuid16_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
> >> +{
> >> +       u8 *ptr = data, *uuids_start = NULL;
> >> +       struct bt_uuid *uuid;
> >
> > Maybe you should check for "len < 2" here?
> 
> Actually, "len < 4", to be able to fit at least a 16-bit UUID.

The way the EIR is constructed right now it's impossible for this
condition to be met (i.e. the only variable length field before the
UUID-16 list is the name which we limit to 48 bytes). Anyway, in case we
add more stuff to the beginning of the EIR in the future I agree that
it's good to have this check in place so we avoid stupid bugs.

I'll be sending a v2 of the set (also including a simplification to the
first patch) soon.

Johan
