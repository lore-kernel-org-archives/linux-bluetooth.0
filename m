Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Oct 2010 16:43:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Balamurugan Mahalingam <mbalamurugan@atheros.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	charubala@charubala.com
Subject: Re: [PATCH] Fix accessing freed memory
Message-ID: <20101019134320.GB13310@jh-x301>
References: <1287491414-14015-1-git-send-email-mbalamurugan@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287491414-14015-1-git-send-email-mbalamurugan@atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 19, 2010, Balamurugan Mahalingam wrote:
> Crash is due to some junk characters in the device name.
> The device name is copied from a string variable after freeing the memory 
> it points to, so there were some junk characters in it which was the reason 
> for the crash.
> 
> Fixing the issue by freeing the memory in string variable after 
> device name is copied.
> 
> ---
>  compat/sdp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
