Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 11:26:51 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 02/11] Add messages to the mgmt interface to handle
 SMP key storage
Message-ID: <20120118142651.GA20610@samus>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
 <1326842930-31623-2-git-send-email-vinicius.gomes@openbossa.org>
 <20120118115735.GA5970@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120118115735.GA5970@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 13:57 Wed 18 Jan, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Tue, Jan 17, 2012, Vinicius Costa Gomes wrote:
> > +#define MGMT_EV_NEW_LONG_TERM_KEY	0x0016
> > +struct mgmt_ev_new_long_term_key {
> > +	uint8_t store_hint;
> > +	struct mgmt_ltk_info key;
> > +} __packed;
> 
> I've pushed the first patch, but this doesn't match mgmt-api.txt. In the
> API doc the event code is 0x0015.

Going to fix it. That happened because in the kernel side we still have
the Remote Name event, that was removed from userspace. I will send a
patch to remove that event.

> 
> Johan

Cheers,
-- 
Vinicius
