Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Jul 2011 12:57:15 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluez: l2test: enhance L2CAP mode option
Message-ID: <20110705155715.GA29925@joana>
References: <1309876163-30261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1309876163-30261-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309876163-30261-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-07-05 17:29:23 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  test/l2test.c |   41 +++++++++++++++++++++++++++++++++++------
>  1 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/test/l2test.c b/test/l2test.c
> index 3b606d2..44c617c 100644
> --- a/test/l2test.c
> +++ b/test/l2test.c
> @@ -112,6 +112,28 @@ static int reliable = 0;
>  static int timestamp = 0;
>  static int defer_setup = 0;
>  
> +static struct {
> +	char	*name;
> +	int	flag;
> +} l2cap_modes[] = {
> +	{ "basic",	L2CAP_MODE_BASIC	},
> +	{ "flowctl",	L2CAP_MODE_FLOWCTL	},
> +	{ "retrans",	L2CAP_MODE_RETRANS	},

We don't implement retransmission and flow control mode, so just leave them
out.

	Gustavo
