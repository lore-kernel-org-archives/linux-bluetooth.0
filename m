Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Sep 2010 14:58:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix dict_append_array to accept types other than string
Message-ID: <20100910115808.GA2880@jh-x301>
References: <1284119403-9367-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284119403-9367-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Sep 10, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> ---
>  src/dbus-common.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)

The patch is now upstream, with the following minor change that I did
for you:

> +		const char ***str_array = (const char ***) val;

Since val is void * there's no need to do the type cast (the original
code didn't do it either).

Johan
