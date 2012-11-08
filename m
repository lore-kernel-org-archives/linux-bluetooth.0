Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Nov 2012 01:17:31 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Add support for setting LE advertising
 data
Message-ID: <20121108001731.GA18602@x220.colubris.lan>
References: <1352239600-5840-1-git-send-email-johan.hedberg@gmail.com>
 <1352239600-5840-2-git-send-email-johan.hedberg@gmail.com>
 <1352303722.16204.2.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352303722.16204.2.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Nov 07, 2012, Marcel Holtmann wrote:
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 344fea0..705e2f0 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -338,6 +338,13 @@ enum {
> >  #define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
> >  #define EIR_DEVICE_ID		0x10 /* device ID */
> >  
> > +/* Low Energy Advertising Flags */
> > +#define LE_AD_LIMITED		0x01 /* Limited Discoverable */
> > +#define LE_AD_GENERAL		0x02 /* General Discoverable */
> > +#define LE_AD_NO_BREDR		0x04 /* BR/EDR not supported */
> > +#define LE_AD_SIM_LE_BREDR_CTRL	0x08 /* Simultaneous LE & BR/EDR Controller */
> > +#define LE_AD_SIM_LE_BREDR_HOST	0x10 /* Simultaneous LE & BR/EDR Host */
> > +
> 
> is this bad formatting in the email client and they are actually
> aligned.

They're properly aligned (I double checked looking at the resulting code
itself)

> > @@ -942,6 +949,14 @@ struct hci_rp_le_read_adv_tx_power {
> >  	__s8	tx_power;
> >  } __packed;
> >  
> > +#define HCI_MAX_AD_LENGTH		31
> > +
> > +#define HCI_OP_LE_SET_ADV_DATA		0x2008
> > +struct hci_cp_le_set_adv_data {
> > +	__u8		length;
> > +	__u8		data[HCI_MAX_AD_LENGTH];
> > +} __packed;
> > +
> 
> This indentation looks weird.

Agreed. Fixed in v2 (where I added your ack since I understood you were
otherwise fine with this patch.

Johan
