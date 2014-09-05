Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Sep 2014 22:55:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] core: Fix idle watch not being removed properly
Message-ID: <20140905195504.GA5101@t440s.P-661HNU-F1>
References: <1409921352-28485-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409921352-28485-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Sep 05, 2014, Luiz Augusto von Dentz wrote:
> The idle watch used to dispatch authorization should be removed when
> waiting services to be resolved.
> ---
>  src/adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've applied all four of these patches. Thanks.

Johan
