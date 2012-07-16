Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jul 2012 22:52:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Increase MTU for MCAP/HDP data channels
Message-ID: <20120716195205.GA9223@x220.P-661HNU-F1>
References: <1342413105-27060-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1342413105-27060-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Mon, Jul 16, 2012, Elvis Pfützenreuter wrote:
> HDP may need to send or receive PDUs up to 64512 octets (the IEEE
> 11073-20601 upper limit) depending on the role, so setting MTU to
> maximum possible value.
> ---
>  profiles/health/mcap.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
