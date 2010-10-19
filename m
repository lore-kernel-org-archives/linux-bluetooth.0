Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Oct 2010 14:23:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Balamurugan Mahalingam <mbalamurugan@atheros.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	charubala@charubala.com
Subject: Re: [PATCH] Fix GUI crash while connecting Interlink Bluetooth
 Mouse in android platform.
Message-ID: <20101019112328.GA12554@jh-x301>
References: <1287482080-10093-1-git-send-email-mbalamurugan@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287482080-10093-1-git-send-email-mbalamurugan@atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 19, 2010, Balamurugan Mahalingam wrote:
> Crash is due to some junk characters in the device name.
> The device name is copied from a string variable after freeing the memory it points to, so there were some junk characters in it which was the reason for the crash.
> Fixing the issue by freeing the memory in string variable after device name is copied.
> 
> Signed-off-by: Balamurugan Mahalingam <mbalamurugan@atheros.com>
> ---
>  compat/sdp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Looks like a good fix, but could you please fix your commit message and
resend:

1. The commit message doesn't so much describe the change as it does
some symptom in a downstream system (android). E.g. the summary line
should be something like "Fix accessing freed memory". You can still
talk about the background to this issue wrt. android but the main point
should be in a bluez-only context.

2. Keep the commit message lines below 74 characters so that it's
properly viewable on a 80-character wide terminal when running "git log"

3. Remove the signed-off-by line. We don't use that in userspace.

Johan
