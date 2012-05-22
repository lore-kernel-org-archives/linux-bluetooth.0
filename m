Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 12:59:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH RFC] avdtp: Fix incorrect gchar buffer allocation
Message-ID: <20120522095958.GB12996@x220>
References: <1337348789-21109-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337348789-21109-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, May 18, 2012, Anderson Lizardo wrote:
> The code was allocating an array of gchar pointers, where an array of
> gchar is expected.
> ---
>  audio/gstavdtpsink.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> I did not check the code at length, but looking at other functions, this is
> most likely a bug.
> 
> diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
> index af04a56..b5dfae4 100644
> --- a/audio/gstavdtpsink.c
> +++ b/audio/gstavdtpsink.c
> @@ -1144,7 +1144,7 @@ static gboolean gst_avdtp_sink_update_caps(GstAvdtpSink *self)
>  
>  static gboolean gst_avdtp_sink_get_capabilities(GstAvdtpSink *self)
>  {
> -	gchar *buf[BT_SUGGESTED_BUFFER_SIZE];
> +	gchar buf[BT_SUGGESTED_BUFFER_SIZE];
>  	struct bt_get_capabilities_req *req = (void *) buf;
>  	struct bt_get_capabilities_rsp *rsp = (void *) buf;
>  	int err;

Applied. Thanks.

Johan
