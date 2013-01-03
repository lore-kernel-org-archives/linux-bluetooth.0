Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jan 2013 22:56:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Borges <paulo.borges@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib-server: Fix invalid device access
Message-ID: <20130103205634.GA17729@x220.P-661HNU-F1>
References: <1357239438-10309-1-git-send-email-paulo.borges@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357239438-10309-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Thu, Jan 03, 2013, Paulo Borges wrote:
> When the device is not found, the channel attach must fail.
> ---
>  src/attrib-server.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Applied though I did make one change first:

> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 15622e4..4a25743 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -1131,10 +1131,17 @@ guint attrib_channel_attach(GAttrib *attrib)
>  	ba2str(&channel->dst, addr);
>  
>  	device = adapter_find_device(server->adapter, addr);
> -	if (device == NULL || device_is_bonded(device) == FALSE) {
> +	if (device == NULL) {
> +		error("Device not found");

Never do error() logs with a very generic message like this. Always
provide enough context to figure out what part of the the (big) bluez
code base the error is coming from. Unlike DBG() error() doesn't provide
any automatic context.

Johan
