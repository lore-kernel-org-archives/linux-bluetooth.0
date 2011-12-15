Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 14:20:06 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] mgmt: Add support for Passkey handling
Message-ID: <20111215122005.GF15283@aemeltch-MOBL1>
References: <1323950056-28708-1-git-send-email-hemant.gupta@stericsson.com>
 <20111215120851.GA10113@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111215120851.GA10113@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Dec 15, 2011 at 02:08:51PM +0200, Johan Hedberg wrote:
> Hi Hemant,
> 
> On Thu, Dec 15, 2011, Hemant Gupta wrote:
> > @@ -218,7 +218,7 @@ struct mgmt_rp_user_confirm_reply {
> >  #define MGMT_OP_USER_PASSKEY_REPLY	0x001C
> >  struct mgmt_cp_user_passkey_reply {
> >  	bdaddr_t bdaddr;
> > -	uint32_t passkey;
> > +	__le32 passkey;
> >  } __packed;
> 
> Otherwise the patch looks ok but this change shouldn't be in it.  __le32
> is only for the kernel side.

Minor comment related to debugging in general. We always allocate space
for bluetooth address string even when we do not use debug.

Best regards 
Andrei Emeltchenko 

> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
