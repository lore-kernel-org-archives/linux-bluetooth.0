Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 14:31:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 3/5] Bluetooth: Add dst_type parameter to hci_connect
Message-ID: <20120405113156.GA2544@x220>
References: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
 <1333570570-1288-4-git-send-email-andre.guedes@openbossa.org>
 <20120405102208.GC32212@x220>
 <CAJdJm_O0Qf07kfXP9ReyDtasL6d3fnRiCCnbpvwoYUWE+me2LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAJdJm_O0Qf07kfXP9ReyDtasL6d3fnRiCCnbpvwoYUWE+me2LA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Apr 05, 2012, Anderson Lizardo wrote:
> Hi Johan,
> 
> On Thu, Apr 5, 2012 at 6:22 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Andre,
> >
> > On Wed, Apr 04, 2012, Andre Guedes wrote:
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >> index 542fea2..9083a95 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -574,7 +574,7 @@ int hci_chan_del(struct hci_chan *chan);
> >>  void hci_chan_list_flush(struct hci_conn *conn);
> >>
> >>  struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> >> -                                             __u8 sec_level, __u8 auth_type);
> >> +                             __u8 dst_type, __u8 sec_level, __u8 auth_type);
> >
> > It seems like you're not using the "new" style of aligning with the
> > opening parenthesis here.
> 
> About this alignment, should it be done with spaces when necessary
> (i.e. when using just tabs does not align)?

Yes, use as many tabs as you can and then add spaces until you align
with the opening parenthesis.

> I think I have missed discussions about this (maybe because I don't
> follow LKML closely).

IIRC it was on the linux-wireless[1] and netdev[2] lists. Essentially
the net maintainer said he'd refuse our pull requests if we don't follow
this new style (even though the old style is what our subsystem has used
from the very beginning and it doesn't violate the CodingStyle
document).

Johan

[1] https://lkml.org/lkml/2012/2/21/299
[2] http://www.spinics.net/lists/netdev/msg190606.html
