Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Dec 2013 11:18:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/5] avdtp: Remove unneeded local variable
Message-ID: <20131216091809.GB13188@x220.p-661hnu-f1>
References: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1387184262-21439-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387184262-21439-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Dec 16, 2013, Andrei Emeltchenko wrote:
> ---
>  profiles/audio/avdtp.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

I've applied all patches except these ones claiming to remove an
unneeded err variable.

> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index f866b39..e12ad9d 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -773,10 +773,9 @@ static int get_send_buffer_size(int sk)
>  	socklen_t optlen = sizeof(size);
>  
>  	if (getsockopt(sk, SOL_SOCKET, SO_SNDBUF, &size, &optlen) < 0) {
> -		int err = -errno;
> -		error("getsockopt(SO_SNDBUF) failed: %s (%d)", strerror(-err),
> -									-err);
> -		return err;
> +		error("getsockopt(SO_SNDBUF) failed: %s (%d)", strerror(errno),
> +									errno);
> +		return -errno;
>  	}

This is not an unneeded variable. The error() call itself might cause
the value of errno to be modified and hence you'd be returning not the
getsockopt error but something else.

Johan
