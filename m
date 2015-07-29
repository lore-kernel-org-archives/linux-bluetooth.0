Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Jul 2015 10:13:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anchit Narang <anchit.n@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH] tools/l2test:Fixed memory leak
Message-ID: <20150729071310.GC7699@t440s.lan>
References: <1438080130-445-1-git-send-email-anchit.n@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438080130-445-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anchit,

On Tue, Jul 28, 2015, Anchit Narang wrote:
> Freed memory allocated to filename before exiting.
> Closed file before returning from do_send function.
> ---
>  tools/l2test.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/l2test.c b/tools/l2test.c
> index 1d458c4..a2e6d5d 100644
> --- a/tools/l2test.c
> +++ b/tools/l2test.c
> @@ -961,6 +961,7 @@ static void do_send(int sk)
>  		if (fd < 0) {
>  			syslog(LOG_ERR, "Open failed: %s (%d)",
>  							strerror(errno), errno);
> +			free(filename);
>  			exit(1);
>  		}

It's a bit awkward to go freeing up global variables here that were
allocated in the main() function. A cleaner way could be to use an
atexit() handler, but in this case I wonder if the extra allocation is
necessary at all, can't we just make 'filename' point at the right argv
element since that should be valid throughout the entire lifetime of the
process, i.e. instead of filename = strdup(optarg) it should be possible
to do filename = optarg (and change filename to const char *).

Johan
