Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Oct 2013 17:42:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/7] core/profile: Fix MNS record version
Message-ID: <20131009154239.GA2924@x220.p-661hnu-f1>
References: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 09, 2013, Luiz Augusto von Dentz wrote:
> To be able to use OBEX over L2CAP the version number should be at least
> 0x102, in addition to that ERTM mode should be used to comply to
> GOEP 2.0.
> ---
>  src/profile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

All patches in this set have been applied. Thanks.

Johan
