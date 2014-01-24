Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] android/avdtp: Retry send on EAGAIN as well
Date: Fri, 24 Jan 2014 23:16:39 +0100
Message-ID: <3119819.bMHWn5I4f0@athlon>
In-Reply-To: <1390575403-30860-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390575403-30860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1390575403-30860-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 24 January 2014 16:56:42 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/avdtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/avdtp.c b/android/avdtp.c
> index 5da1206..1055bc1 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -444,7 +444,7 @@ static gboolean try_send(int sk, void *data, size_t len)
> 
>  	do {
>  		err = send(sk, data, len, 0);
> -	} while (err < 0 && errno == EINTR);
> +	} while (err < 0 && (errno == EINTR || errno == EAGAIN));
> 

This makes try_send() blocking, if this is ok then at least some explanation 
in commit message would be welcome.

>  	if (err < 0) {
>  		error("send: %s (%d)", strerror(errno), errno);

-- 
Szymon K. Janc
szymon.janc@gmail.com
