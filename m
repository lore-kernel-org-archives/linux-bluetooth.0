Return-Path: <cyrus@holtmann.org>
Message-id: <05C57A66007544188BE786ECFA833CBA@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <1332844351-13732-1-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1332844351-13732-1-git-send-email-jaganath.k@samsung.com>
Subject: Re: [PATCH obexd 1/2] gobex: Introduce g_obex_abort_transfer()
Date: Wed, 04 Apr 2012 10:41:00 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

--------------------------------------------------
From: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Sent: Tuesday, March 27, 2012 4:02 PM
To: <linux-bluetooth@vger.kernel.org>
Cc: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Subject: [PATCH obexd 1/2] gobex: Introduce g_obex_abort_transfer()

> This function sends the abort request and wait for response before
> disconnection. This patch fixes the issue ABORT packet not sending
> when user cancels the transfer.
> ---
> gobex/gobex-transfer.c |   22 +++++++++++++++++++++-
> gobex/gobex.c          |    4 ++--
> gobex/gobex.h          |    4 ++++
> 3 files changed, 27 insertions(+), 3 deletions(-)
> 

Any update on this patch please?

Thanks,
Jaganath 
