Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Apr 2013 23:26:54 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alvaro Silva <alvaro.silva@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: Re: [PATCH BlueZ v2 04/13] gatttool: Use GError to propage error
 messages to caller
Message-ID: <20130409142654.GA8294@x220>
References: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
 <1364945490-17059-5-git-send-email-alvaro.silva@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364945490-17059-5-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 02, 2013, Alvaro Silva wrote:
> Handle runtime errors outside gatt_connect(), using GError to propagate
> error messages to caller.
> ---
>  attrib/gatttool.c    |    6 +++++-
>  attrib/gatttool.h    |    3 ++-
>  attrib/interactive.c |   10 +++++++---
>  attrib/utils.c       |   14 +++++++-------
>  4 files changed, 21 insertions(+), 12 deletions(-)

The first three patches have been applied, but there are a few issues
with this one:

> --- a/attrib/gatttool.c
> +++ b/attrib/gatttool.c
> @@ -576,6 +576,7 @@ int main(int argc, char *argv[])
>  	if (g_option_context_parse(context, &argc, &argv, &gerr) == FALSE) {
>  		g_printerr("%s\n", gerr->message);
>  		g_error_free(gerr);
> +		gerr = NULL;

g_error_free + gerr = NULL is the same as g_clear_error(&gerr). Please
use that instead.

>  	chan = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
> -					opt_psm, opt_mtu, connect_cb);
> +					opt_psm, opt_mtu, connect_cb, &gerr);
>  	if (chan == NULL) {
> +		g_printerr("%s\n", gerr->message);
> +		g_error_free(gerr);
> +		gerr = NULL;

Same here.

Johan
