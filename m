Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Aug 2011 16:16:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add watch for RFCOMM disconnect to HFP HF role
Message-ID: <20110804131603.GA25017@dell>
References: <1312462310-16965-1-git-send-email-frederic.dalleau@linux.intel.com>
 <20110804125810.GA24323@dell>
 <4E3A9A0B.3030804@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4E3A9A0B.3030804@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 04, 2011, Frédéric Dalleau wrote:
> >>+	if (cond&  (G_IO_ERR | G_IO_HUP)) {
> >
> >Since this function is only called for NVAL, ERR and HUP, do you even
> >need to have this check here. Maybe you could just get rid of this
> >second if-statement.
> 
> To be rigorous the test is not needed. This is more a matter of
> consistency, since the code is nearly a copy paste of the existing
> sco_io_cb.
> 
> If it is ok for you, I'll update both funcs.

Yes, though separate patches please.

Johan
