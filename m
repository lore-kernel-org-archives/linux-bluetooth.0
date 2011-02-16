Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1297890984-7809-2-git-send-email-bgix@codeaurora.org>
References: <1297890984-7809-1-git-send-email-bgix@codeaurora.org>
	<1297890984-7809-2-git-send-email-bgix@codeaurora.org>
Date: Wed, 16 Feb 2011 18:36:46 -0300
Message-ID: <AANLkTikwWWf48ZM3Jd9cSwe1P4HzVbBn_+WZSRz0qpb=@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix Min MTU to reflect values for both L2CAP & LE
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Feb 16, 2011 at 6:16 PM, Brian Gix <bgix@codeaurora.org> wrote:
> -/* Minimum MTU for L2CAP connections over BR/EDR */
> -#define ATT_MIN_MTU_L2CAP 48
> +/* Minimum MTU for ATT connections */
> +#define ATT_MIN_MTU_LE         23
> +#define ATT_MIN_MTU_L2CAP      48

on attrib/att.h we have:

#define ATT_DEFAULT_L2CAP_MTU 48
#define ATT_DEFAULT_LE_MTU 23

I think It's better to reuse them. Johan has applied your patch
already, so you will need to create a fixup for it.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
