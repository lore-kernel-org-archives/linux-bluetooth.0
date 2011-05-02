Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1304123252-14464-7-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
	<1304123252-14464-7-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 2 May 2011 10:48:24 +0300
Message-ID: <BANLkTinwg4B3dTsWtUzZ8ji5FqGPHjHPyg@mail.gmail.com>
Subject: Re: [RFC 06/16] Change DiscoverSchedulerInterval default value
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Sat, Apr 30, 2011 at 3:27 AM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> This patch changes the default value of "DiscoverSchedulerInterval"
> from 0 to 30 seconds.
>
> Since Periodic Inquiry is not supported anymore, the option
> "DiscoverSchedulerInterval" in main.conf must be updated. As
> a first attempt, it was chosen a 30 seconds interval.
> ---
>  src/main.conf |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/main.conf b/src/main.conf
> index c03f135..8cd132f 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -27,8 +27,8 @@ PairableTimeout = 0
>  PageTimeout = 8192
>
>  # Discover scheduler interval used in Adapter.DiscoverDevices
> -# The value is in seconds. Defaults is 0 to use controller scheduler.
> -DiscoverSchedulerInterval = 0
> +# The value is in seconds. Defaults is 30.
> +DiscoverSchedulerInterval = 30
>
>  # What value should be assumed for the adapter Powered property when
>  # SetProperty(Powered, ...) hasn't been called yet. Defaults to true

Im not sure how you came up with 30 sec, IMO it is too long and
doesn't specify how long we inquiry/scan/resolve names.

-- 
Luiz Augusto von Dentz
Computer Engineer
