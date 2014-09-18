Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Sep 2014 13:37:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mgmt-tester: Use proper type specifier for printing
 size_t
Message-ID: <20140918103749.GA6613@t440s.lan>
References: <1411036431-21458-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1411036431-21458-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Sep 18, 2014, Szymon Janc wrote:
> Fix following error:
> 
> tools/mgmt-tester.c: In function ‘verify_ltk’:
> tools/mgmt-tester.c:2633:19: error: format ‘%u’ expects argument of
>     type ‘unsigned int’, but argument 3 has type
>     ‘long unsigned int’ [-Werror=format=]
>      sizeof(struct mgmt_ev_new_long_term_key));
>                    ^
> ---
>  tools/mgmt-tester.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
