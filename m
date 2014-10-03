Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Oct 2014 13:20:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alfonso Acosta <fons@spotify.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Include ADV_IND report in Device Connected
 event
Message-ID: <20141003102023.GA8095@t440s.lan>
References: <1412325293-6651-1-git-send-email-fons@spotify.com>
 <7F79038B-2FA8-4DF5-B25A-D7E9AAE922A8@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7F79038B-2FA8-4DF5-B25A-D7E9AAE922A8@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 03, 2014, Marcel Holtmann wrote:
> > void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> > 			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
> > -			   u8 *dev_class);
> > +			   u8 *dev_class, u8 *adv, u8 adv_len);
> 
> I keep wondering if we might just handover hci_conn instead. Something
> Johan needs to comment on here.

That's something I was actually thinking of myself. I have no objections
to simplifying the parameter list by passing the whole hci_conn to this
function (this should however be done as a separate patch before this
one).

Johan
