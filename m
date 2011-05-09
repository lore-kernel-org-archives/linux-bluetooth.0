Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 May 2011 20:48:41 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix starting the security procedure when setting the MTU
Message-ID: <20110509234841.GA3760@piper>
References: <1304963788-2926-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304963788-2926-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 14:56 Mon 09 May, Vinicius Costa Gomes wrote:
> The default security level of btio is BT_IO_SEC_MEDIUM, and for
> LE links this would cause encryption to be started. So, we set the
> security level to LOW (a no-op) and the MTU to the desired value.
> ---
>  attrib/gattrib.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 

Please ignore this patch. As discussed on IRC, I will send a patch
that fixes the actual problem.


Cheers,
-- 
Vinicius
