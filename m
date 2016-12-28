Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Juha Kuikka <juha.kuikka@synapse.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Add new DS4 controller PID into special case handler
Date: Wed, 28 Dec 2016 17:06:21 +0100
Message-ID: <2506634.F5JXQNkpjV@ix>
In-Reply-To: <1482384054-59718-2-git-send-email-juha.kuikka@synapse.com>
References: <1482384054-59718-1-git-send-email-juha.kuikka@synapse.com> <1482384054-59718-2-git-send-email-juha.kuikka@synapse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juha,

On Wednesday, 21 December 2016 21:20:52 CET Juha Kuikka wrote:
> There is a special path for various game controllers where they connect
> to the hid service before bluetoothd knows what they are.
> 
> This patch adds another PID for the Dualshock4 controller.
> ---
>  profiles/input/server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/profiles/input/server.c b/profiles/input/server.c
> index eb3fcf8..61f084a 100644
> --- a/profiles/input/server.c
> +++ b/profiles/input/server.c
> @@ -136,7 +136,7 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const
> bdaddr_t *dst) return true;
> 
>  	/* DualShock 4 */
> -	if (vid == 0x054c && pid == 0x05c4)
> +	if (vid == 0x054c && (pid == 0x05c4 || pid == 0x09cc))
>  		return true;

Is this ID for new DS4 sold with PS4 pro? if so please add a comment.

> 
>  	/* Navigation Controller */


-- 
pozdrawiam
Szymon Janc
