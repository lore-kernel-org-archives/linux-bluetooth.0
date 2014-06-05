Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH ] profiles: Fix crash due to NULL pointer access
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401966105-31223-1-git-send-email-bharat.panda@samsung.com>
Date: Thu, 5 Jun 2014 12:56:11 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0DD74990-7D04-4415-810D-3D75B073742A@holtmann.org>
References: <1401966105-31223-1-git-send-email-bharat.panda@samsung.com>
To: Bharat Panda <bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

> NULL pointer check is added after memory allocation
> to prevent core dump due to NULL pointer access.
> 
> Signed-off-by: Bharat Panda <bharat.panda@samsung.com>
> ---
> profiles/audio/a2dp.c  |    8 ++++++++
> profiles/audio/avctp.c |    4 ++++
> profiles/audio/avdtp.c |   16 ++++++++++++++++
> profiles/health/hdp.c  |    4 +++-
> profiles/health/mcap.c |    2 ++
> 5 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index c9dac9a..580cb60 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -523,6 +523,8 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
> 							a2dp_sep->user_data);
> 
> 	codec_caps = g_malloc0(sizeof(*codec_caps) + length);
> +	if(!codec_caps)
> +		return -ENOMEM;

the only way this can return NULL is when the size argument is 0. In all other cases it will abort the program.

Regards

Marcel

