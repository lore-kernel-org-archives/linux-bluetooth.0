Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Oct 2011 10:36:44 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH bluez 0/2] Add BT 3.0+HS signalling definitions
Message-ID: <20111026073641.GA11385@aemeltch-MOBL1>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Mon, Oct 24, 2011 at 04:06:17PM -0700, Peter Krystad wrote:
> This patchset adds definitions for BT 3.0+HS signalling

Patches looks OK (taking that typedef is a standard way in bluez).

The only note: I think that we need to differentiate AMP and A2MP. When we
are dealing with A2MP protocol we could name structures / functions as
a2mp_*

Best regards 
Andrei Emeltchenko 

> 
> Peter Krystad (2):
>   Add L2CAP Create/Move Channel definitions
>   Add A2MP definitions
> 
>  lib/a2mp.h  |  131 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/l2cap.h |   44 ++++++++++++++++++++
>  2 files changed, 175 insertions(+), 0 deletions(-)
>  create mode 100644 lib/a2mp.h
> 
> -- 
> 1.7.7
> 
> --
> Peter Krystad
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
