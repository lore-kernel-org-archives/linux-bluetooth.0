Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Jul 2013 10:35:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: martin.xu@linux.intel.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Profile: fix set default exteranl profile authorize
Message-ID: <20130715073518.GA24712@x220.p-661hnu-f1>
References: <1373857569-4191-1-git-send-email-martin.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373857569-4191-1-git-send-email-martin.xu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Mon, Jul 15, 2013, martin.xu@linux.intel.com wrote:
> authorize is always set as "true" in function ext_set_defaults().
> 
> the static variable authorize of default_settings will be 0(false),
> if it is not initialized. So item authorize needs to be initized if
> the value is true (non-0).
> And then function ext_set_defaults() can set default authorize properly
> ---
>  src/profile.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

The subject says "PATCH 1/3". Did you intend to send three patches? I
can only see this one.

> @@ -1998,7 +2008,6 @@ static void ext_set_defaults(struct ext_profile *ext)
>  
>  	ext->mode = BT_IO_MODE_BASIC;
>  	ext->sec_level = BT_IO_SEC_MEDIUM;
> -	ext->authorize = true;
>  	ext->enable_client = true;
>  	ext->enable_server = true;
>  	ext->remote_uuid = NULL;

The above change is still wrong. Not setting to true is the same as
setting to false since g_new0 was used. Don't change that part at all.

Johan
