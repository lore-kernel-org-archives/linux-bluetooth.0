Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Sep 2013 14:45:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/8] Bluetooth: Test for HCI_SETUP and HCI_USER_CHANNEL
 in mgmt_valid_hdev()
Message-ID: <20130927114506.GA19210@x220.p-661hnu-f1>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
 <1380031363-1266-4-git-send-email-johan.hedberg@gmail.com>
 <DFCF34C2-5AA9-4644-BB4B-3D6073DA9D42@holtmann.org>
 <20130925100353.GA3158@x220.p-661hnu-f1>
 <C7C45B32-4EF9-4FD7-B774-E88917DFAC75@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C7C45B32-4EF9-4FD7-B774-E88917DFAC75@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 27, 2013, Marcel Holtmann wrote:
> >>> If either one of the HCI_SETUP or HCI_USER_CHANNEL flags is set the
> >>> device is not considered valid for mgmt. By having these checks inside
> >>> the mgmt_valid_hdev function the a couple of places using it can be
> >>> simplified.
> >> 
> >> I looked at doing this and decided not to. Reason was that the device
> >> gets removed from mgmt anyway.
> > 
> > I'm not sure what significance you think "device gets removed from mgmt"
> > has. All that is is a mgmt event saying that index has been removed. In
> > addition to that we need to ensure that we don't send any more mgmt
> > events for such devices and that we don't include such devices in the
> > response to mgmt_read_index list.
> > 
> > These are the two places of the code that my patch simplifies, one is
> > the check for whether to send a "power on" mgmt event and the other the
> > response handling of read_index_list.
> 
> I have taken care of that part. It is done inside mgmt_control() and
> in case of a controller in user channel mode it returns invalid index.

That's great, but it doesn't cover the read_index_list command which we
were talking about here since the command doesn't target any specific
controller (as per our mgmt-api.txt it has the value <non-controller> as
the controller index). The command handler will in this case be invoked
that that's where it'd be convenient to rely on mgmt_valid_hdev() for
constructing the response.

> For the events, I have no idea on how we would generate events if we
> are not going through hci_event.c when the user channel is active.

The "powered on" event in question doesn't come from hci_event.c but
from the hci_dev_open() function, so again this is not covered by the
existing user channel checks.

Johan
