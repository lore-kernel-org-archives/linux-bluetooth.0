Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 14:12:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sdp: Check for correct pkt size received instead of error
Message-ID: <20131002111203.GC26752@x220.p-661hnu-f1>
References: <1380628654-6663-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380628654-6663-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Oct 01, 2013, Andrei Emeltchenko wrote:
> Check that the full header is received in recv().
> ---
>  src/sdpd-server.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
