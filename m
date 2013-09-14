Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Sep 2013 18:58:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add event mask page 2 setting support
Message-ID: <20130914155852.GA12683@x220.p-661hnu-f1>
References: <1379061602-8290-1-git-send-email-johan.hedberg@gmail.com>
 <1379061602-8290-3-git-send-email-johan.hedberg@gmail.com>
 <49AE7668-B559-42DC-BF73-59A574C23C96@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49AE7668-B559-42DC-BF73-59A574C23C96@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 13, 2013, Marcel Holtmann wrote:
> > For those controller that support the HCI_Set_Event_Mask_Page_2 command
> > we should include it in the init sequence. This patch implements sending
> > of the command and enables the events in it based on supported features
> > (currently only CSB is checked).
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > include/net/bluetooth/hci.h |  2 ++
> > net/bluetooth/hci_core.c    | 32 ++++++++++++++++++++++++++++++++
> > 2 files changed, 34 insertions(+)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 63cce97..57aa408 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -827,6 +827,8 @@ struct hci_rp_read_inq_rsp_tx_power {
> > 	__s8     tx_power;
> > } __packed;
> > 
> > +#define HCI_OP_SET_EVENT_MASK_PAGE_2	0x0c63
> > +
> 
> I am a little bit torn here. We define the struct for event mask, but
> never use it. Now we only define the opcode. So either we add the
> struct here for completeness sake or you add a cleanup patch that
> removes the event mask struct.

I'll create a separate cleanup patch to remove the unused struct.

Johan
