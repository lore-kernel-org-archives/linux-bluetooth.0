Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Sep 2014 09:57:30 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: gowtham babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH] tools/seq2bseq : Fix the same expression issue in if
 condition
Message-ID: <20140912165730.GC3671@t440s>
References: <1410331363-3548-1-git-send-email-gowtham.ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410331363-3548-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 10, 2014, gowtham babu wrote:
> Below are the list of similar patches under 'tools' which are not yet reviewed
> 
> 1) tools/csr_usb : Fix Resource leak: file
> 2) tools/hciattach : Fix syntax error
> 3) tools/btsnoop : Fix variable reassigning issue

This kind of stuff does not belong in a commit message.

> diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c
> index 7657a57..521d20e 100644
> --- a/tools/seq2bseq.c
> +++ b/tools/seq2bseq.c
> @@ -40,7 +40,7 @@ static int convert_line(int fd, const char *line)
>  	char str[3];
>  	unsigned char val;
>  
> -	if (line[0] == '*' || line[0] == '\r' || line[0] == '\r')
> +	if (line[0] == '*' || line[0] == '\r')
>  		return 0;
>  
>  	while (1) {

Are you sure the code wasn't intending to check for '\n'?

Johan
