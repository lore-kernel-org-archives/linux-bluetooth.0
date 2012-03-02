Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Mar 2012 15:40:21 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Don't force DISCOVERY_STOPPED state in
 inquiry_cache_flush
Message-ID: <20120302234021.GA31665@x220.ice.intel.com>
References: <1330636797-16171-1-git-send-email-andre.guedes@openbossa.org>
 <20120301223226.GA7133@x220.amr.corp.intel.com>
 <CACJA=fVFmGJFnkA1erCS+56DR+WSo1h2vBSNhpqnth3=pgmVRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CACJA=fVFmGJFnkA1erCS+56DR+WSo1h2vBSNhpqnth3=pgmVRQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Mar 02, 2012, Andre Guedes wrote:
> > On Thu, Mar 01, 2012, Andre Guedes wrote:
> >> We are not supposed to force DISCOVERY_STOPPED in inquiry_cache_flush
> >> because we may break the discovery state machine. For instance,
> >> during interleaved discovery, when we are about to start inquiry,
> >> the state machine forcibly goes to DISCOVERY_STOPPED while it
> >> should stay in DISCOVERY_FINDING state.
> >>
> >> This problem results in unexpected behaviors such as sending two
> >> mgmt_discovering events to userspace (when only one event is
> >> expected) and Stop Discovery failures.
> >>
> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> ---
> >>  net/bluetooth/hci_core.c |    1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index d3ddc0b..661d65f 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -413,7 +413,6 @@ static void inquiry_cache_flush(struct hci_dev *hdev)
> >>
> >>       INIT_LIST_HEAD(&cache->unknown);
> >>       INIT_LIST_HEAD(&cache->resolve);
> >> -     cache->state = DISCOVERY_STOPPED;
> >>  }
> >
> > Nack.
> >
> > The reason why this was there is hci_dev_do_close() and hci_dev_reset()
> > which call inquiry_cache_flush(). If the discovery state is not set
> > correctly through these code paths you might get into a situation where
> > you can't start discovery again after doing "hciconfig hci0 reset" or
> > "hciconfig hci0 down" while discovery was active. So I agree that some
> > fix is needed but you need to ensure that you don't break these use
> > cases.
> 
> This issue is already address by upstream patch "Bluetooth: Set
> DISCOVERY_STOPPED if controller resets". So, the discovery state machine
> will be right even if we run "hciconfig hci0 reset" or "hciconfig hci0
> down" while discovery is active.

I didn't realize this has been added to the cc_reset function. In that
case I think both use cases should be fine with this patch, i.e. I
change my nack to an ack :)

Johan
