Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Jun 2010 13:29:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] log: Add function to get/set debug_string
Message-ID: <20100616102920.GA6587@jh-x301>
References: <1276673478-9273-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276673478-9273-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Jun 16, 2010, Gustavo F. Padovan wrote:
> +void __btd_log_init(const char *debug, int detach)
> +{
> +	int option = LOG_NDELAY | LOG_PID;
> +
> +	debug_string = (char *)debug;

This doesn't look right. Either the function declares the parameter as
const for a reason (i.e. it promises not to mess around with it) or then
the const should go away. I think the former is correct in this case,
i.e. you should probably be doing g_strdup on the input parameter.

Johan
