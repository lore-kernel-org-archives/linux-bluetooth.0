Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] tools/l2test: Add -e option
Date: Mon, 01 Jun 2015 14:56:33 +0200
Message-ID: <1967730.PXIbd4Iq0q@leonov>
In-Reply-To: <1433150827-17629-1-git-send-email-szymon.janc@tieto.com>
References: <1433150827-17629-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 01 of June 2015 11:27:04 Szymon Janc wrote:
> This allows to specify initial value for sequence when sending frames.
> ---
>  tools/l2test.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/l2test.c b/tools/l2test.c
> index 8065578..75603a8 100644
> --- a/tools/l2test.c
> +++ b/tools/l2test.c
> @@ -108,6 +108,9 @@ static unsigned long send_delay = 0;
>  /* Default delay before receiving */
>  static unsigned long recv_delay = 0;
> 
> +/* Initial sequence value when sending frames */
> +static int seq_start = 0;
> +
>  static char *filename = NULL;
> 
>  static int rfcmode = 0;
> @@ -974,7 +977,7 @@ static void do_send(int sk)
>  			buf[i] = 0x7f;
>  	}
> 
> -	seq = 0;
> +	seq = seq_start;
>  	while ((num_frames == -1) || (num_frames-- > 0)) {
>  		put_le32(seq, buf);
>  		put_le16(data_size, buf + 4);
> @@ -997,7 +1000,8 @@ static void do_send(int sk)
>  			size -= len;
>  		}
> 
> -		if (num_frames && send_delay && count && !(seq % count))
> +		if (num_frames && send_delay && count &&
> +						!(seq % (count + seq_start)))
>  			usleep(send_delay);
>  	}
>  }
> @@ -1325,7 +1329,8 @@ static void usage(void)
>  		"\t[-S] secure connection\n"
>  		"\t[-M] become master\n"
>  		"\t[-T] enable timestamps\n"
> -		"\t[-V type] address type (help for list, default = bredr)\n");
> +		"\t[-V type] address type (help for list, default = bredr)\n"
> +		"\t[-e seq] initial sequence value (default = 0)\n");
>  }
> 
>  int main(int argc, char *argv[])
> @@ -1336,7 +1341,7 @@ int main(int argc, char *argv[])
>  	bacpy(&bdaddr, BDADDR_ANY);
> 
>  	while ((opt = getopt(argc, argv, "rdscuwmntqxyzpb:a:"
> -		"i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:V:RUGAESMT")) != EOF) {
> +		"i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:V:RUGAESMTe:")) != EOF) {
>  		switch (opt) {
>  		case 'r':
>  			mode = RECV;
> @@ -1542,6 +1547,10 @@ int main(int argc, char *argv[])
> 
>  			break;
> 
> +		case 'e':
> +			seq_start = atoi(optarg);
> +			break;
> +
>  		default:
>  			usage();
>  			exit(1);

Applied.

-- 
BR
Szymon Janc
