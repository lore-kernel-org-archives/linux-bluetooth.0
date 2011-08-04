Return-Path: <cyrus@holtmann.org>
Message-ID: <4E3A9A0B.3030804@linux.intel.com>
Date: Thu, 04 Aug 2011 15:09:31 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add watch for RFCOMM disconnect to HFP HF role
References: <1312462310-16965-1-git-send-email-frederic.dalleau@linux.intel.com> <20110804125810.GA24323@dell>
In-Reply-To: <20110804125810.GA24323@dell>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> +	if (cond&  (G_IO_ERR | G_IO_HUP)) {
>
> Since this function is only called for NVAL, ERR and HUP, do you even
> need to have this check here. Maybe you could just get rid of this
> second if-statement.

To be rigorous the test is not needed. This is more a matter of 
consistency, since the code is nearly a copy paste of the existing 
sco_io_cb.

If it is ok for you, I'll update both funcs.

Regards,
Frédéric
