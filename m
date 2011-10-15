Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v5 13/15] Bluetooth: LE scan infra-structure
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 15 Oct 2011 11:18:50 -0700
In-Reply-To: <A58B9034-BFE6-44D1-A5B0-74DBF764778D@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
	 <1317856847-28167-14-git-send-email-andre.guedes@openbossa.org>
	 <20111006190618.GJ5652@joana>
	 <781D602C-370E-4F06-9D4D-DC69F27294E7@openbossa.org>
	 <20111007201233.GB4108@joana>
	 <A58B9034-BFE6-44D1-A5B0-74DBF764778D@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318702742.15441.60.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >>>> This patch adds to hci_core the infra-structure to carry out the
> >>>> LE scan. Functions were created to init the LE scan and cancel
> >>>> an ongoing scanning (hci_do_le_scan and hci_cancel_le_scan).
> >>>> 
> >>>> Also, the HCI_LE_SCAN flag was created to inform if the controller
> >>>> is performing LE scan. The flag is set/cleared when the controller
> >>>> starts/stops scanning.
> >>>> 
> >>>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >>>> ---
> >>>> include/net/bluetooth/hci.h      |    2 +
> >>>> include/net/bluetooth/hci_core.h |    5 +++
> >>>> net/bluetooth/hci_core.c         |   69 ++++++++++++++++++++++++++++++++++++++
> >>>> net/bluetooth/hci_event.c        |    4 ++
> >>>> 4 files changed, 80 insertions(+), 0 deletions(-)
> >>>> 
> >>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >>>> index 11537b8..7520544 100644
> >>>> --- a/include/net/bluetooth/hci.h
> >>>> +++ b/include/net/bluetooth/hci.h
> >>>> @@ -86,6 +86,8 @@ enum {
> >>>> 	HCI_DEBUG_KEYS,
> >>>> 
> >>>> 	HCI_RESET,
> >>>> +
> >>>> +	HCI_LE_SCAN,
> >>> 
> >>> I remember that Marcel commented against this here. Let's hide this
> >>> internally.
> >> 
> >> If I got it right, Marcel agreed in keeping this flag here, but we
> >> won't export it to userspace now (we'll keep it hidden internally).
> > 
> > hdev->flags is exported to userspace, it is not internal. We need to create
> > other place in struct hci_dev to keep this info. See some of Marcel's reply on
> > this.
> 
> When I said "export to userspace" I meant to add this flag to userspace
> header (lib/hci.h). Even though hdev->flags is exported to userspace,
> if the flag is not defined at that header the userspace cannot decode it
> properly. This way the flag is hidden internally in kernel.
> 
> Marcel, could you clarify this? Are you fine with we keep this HCI_LE_SCAN
> in hdev->flags?

so the hdev->flags has to stay as it is right now since otherwise you
need to change every single driver that sets HCI_RUNNING.

And I do not wanna export any single bit to the user that it does not
need to see. And right now it only needs HCI_UP to HCI_RAW, because they
have been there since ever. And deprecated them takes a bit longer. But
even they will be deprecated in the long run. Any other bit that you
guys introduced goes against this and needs to be fixed.

The one part I do not get right now is why is it so hard to introduce a
new flags variable for this. I mentioned this really early on and you
keep sending patches for it and we keep discussing this.

So I make this pretty simple, call this hdev->mgmt_flags and start
changing these NOW. These flags need to stay internal. Mixing it with
anything that is exported to userspace is a really bad idea.

Regards

Marcel


