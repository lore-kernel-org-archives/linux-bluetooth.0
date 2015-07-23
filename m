Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1436859557-16153-1-git-send-email-dh79.pyun@samsung.com>
References: <1436859557-16153-1-git-send-email-dh79.pyun@samsung.com>
Date: Thu, 23 Jul 2015 23:02:09 +0900
Message-ID: <CAFUUc2G=e=JogVZDbJVb_7hCN3RszV07CJ2dE=QLRvQJ5=p=zQ@mail.gmail.com>
Subject: Re: [PATCH Bluez] tools/l2test: Fix potention double close
From: DoHyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping

2015-07-14 16:39 GMT+09:00, Dohyun Pyun <re20sfree@gmail.com>:
> From: DoHyun Pyun <dh79.pyun@samsung.com>
>
> If the test gets an error after close the socket, the socket sk
> will be closed again. This patch prevents the double close case.
> ---
>  tools/l2test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/l2test.c b/tools/l2test.c
> index abe09c1..1d458c4 100644
> --- a/tools/l2test.c
> +++ b/tools/l2test.c
> @@ -644,7 +644,6 @@ static void do_listen(void (*handler)(int sk))
>  			continue;
>  		}
>  		/* Child */
> -		close(sk);
>
>  		/* Set receive buffer size */
>  		if (rcvbuf && setsockopt(nsk, SOL_SOCKET, SO_RCVBUF, &rcvbuf,
> @@ -769,6 +768,7 @@ static void do_listen(void (*handler)(int sk))
>  		}
>
>  		handler(nsk);
> +		close(sk);
>
>  		syslog(LOG_INFO, "Disconnect: %m");
>  		exit(0);
> --
> 1.8.1.2
>
>
