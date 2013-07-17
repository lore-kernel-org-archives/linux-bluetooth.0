Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Jul 2013 11:36:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: martin.xu@linux.intel.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] profile: fix set default exteranl profile authorize
Message-ID: <20130717083607.GA7940@x220.p-661hnu-f1>
References: <1374028645-15366-1-git-send-email-martin.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374028645-15366-1-git-send-email-martin.xu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Wed, Jul 17, 2013, martin.xu@linux.intel.com wrote:
> From: Martin Xu <martin.xu@linux.intel.com>
> 
> authorize is always set as "true" in function ext_set_defaults().
> 
> the static variable authorize of default_settings will be 0(false),
> if it is not initialized. So item authorize needs to be initized if
> the value is true (non-0).
> And then function ext_set_defaults() can set default authorize properly
> ---
>  src/profile.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
