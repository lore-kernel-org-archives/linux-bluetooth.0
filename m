Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Sep 2013 11:29:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] sco-tester: Update ECONNABORTED to EOPNOTSUPP
Message-ID: <20130909082919.GB29399@x220.p-661hnu-f1>
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Fri, Aug 09, 2013, Frédéric Dalleau wrote:
> Kernel interface has evolved in between.
> ---
>  tools/sco-tester.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've applied and pushed this patch, but there are a couple of details in
the other ones that I'd like to get fixed before pushing.

Johan
