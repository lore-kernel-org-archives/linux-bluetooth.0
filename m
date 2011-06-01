Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 14:37:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Add support of secure pin code in mgmt code
Message-ID: <20110601113732.GA26842@dell.ger.corp.intel.com>
References: <1306401315-10948-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110529184859.GB32088@dell.ger.corp.intel.com>
 <99B09243E1A5DA4898CDD8B700111448175631BC06@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448175631BC06@EXMB04.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Wed, Jun 01, 2011, Waldemar.Rymarkiewicz@tieto.com wrote:
> You mentioned that the check should be done in kernel as well.
> However, mgmt API is like mgmt_pincode_replay and
> mgmt_pincode_neg_replay what means that I should do a check (secure ==
> 1 && pinlen !=16) on mgmt_pincode_replay and if the pin is in fact not
> secure then send pincode_neg_replay to the controller.
> 
> In that case we could skipp checking in bluez at all to avoid double
> checking, but it's fine if we do so.
> 
> What about replaceing mgmt_pincode_replay and mgmt_pincode_neg_replay
> with one mgmt_pincode_replay + error field in the struct to indicate
> user space succeded or not. This way the checking could be done only
> in the kernel I guess.

I prefer to have two separate mgmt commands (this is consistent both
with HCI and with the SSP related commands) and it's fine to have the
check only on the kernel side (there's really no practical difference
between one command with an error field or two separate commands).

Johan
