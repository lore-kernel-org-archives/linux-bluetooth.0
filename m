Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "'Andrei Emeltchenko'" <andrei.emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org> <1319239802-22457-3-git-send-email-pkrystad@codeaurora.org> <20111026133343.GE11385@aemeltch-MOBL1>
In-Reply-To: <20111026133343.GE11385@aemeltch-MOBL1>
Subject: RE: [PATCH 2/4] Add parsing of A2MP signals
Date: Wed, 26 Oct 2011 11:49:41 -0700
Message-ID: <000301cc9410$05ae5340$110af9c0$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei,

> >
> > +static inline void amp_command_rej(int level, struct frame *frm)
> > +{
> > +	amp_cmd_rej_parms *h = frm->ptr;
> > +	uint16_t reason = btohs(h->reason);
> > +
> > +	if (p_filter(FILT_A2MP))
> > +		return;
> > +
> > +	printf("Command Reject: reason (%d)- ", reason);
> > +	p_indent(level + 1, frm);
> 
> This doesn't make sense to use p_indent if you print on the same line.
> Maybe you forgot "\n" ?
> 
> > +	printf("%s\n", ampreason2str(reason));
> > +}
> > +
> 

Will add a '\n'. 

I'll repost this patch set after the bluez header patchset is approved.

Peter.

--Peter Krystad
  Employee of Qualcomm Innovation Center, Inc.
  Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


