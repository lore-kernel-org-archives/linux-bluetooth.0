Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Dec 2010 16:53:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Use stored device name (if any) instead of EIR data
Message-ID: <20101227145322.GA16529@jh-x301>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
 <1293456068-11615-2-git-send-email-anderson.lizardo@openbossa.org>
 <AANLkTikcZRjC2KwOpHSqS_6wMcT8skKBMbhMzs=ugK+F@mail.gmail.com>
 <AANLkTi=06P4ZpGO-sp7czZtn9FGLkBwPnrxNqDdGspfy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=06P4ZpGO-sp7czZtn9FGLkBwPnrxNqDdGspfy@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 27, 2010, Anderson Lizardo wrote:
> > if the variable name is set
> > than your could would skip eir name completely while the code did
> > actually use the eir name, probably the eir name is updated more
> > frequently so it is probably the most updated one and we should in
> > fact update the storage if they don't match.
> 
> I could not find on spec any mention that the "complete" EIR name may
> change.

It also doesn't say that it will not change. So the safe thing would be
not to make any assumption about its permanence, right?

Naturally the user of the remote device might change is name (if the
remote device has such a feature) and then the EIR data would change
too. Note that even if there's a name in storage it doesn't mean that
it's from the same discovery session. It might be from a previous
discovery session a long time ago and the user of the remote device
might have changed its name since then. So imho a complete name in an
EIR should always override whatever is in storage.

For the case of shortened names I don't think there's an indisputably
right answer. The question is what is better: that which is "complete"
or that which is more recent. I've got the feeling that the complete
version would be better for the user, but someone might of course
disagree with this.

Johan
