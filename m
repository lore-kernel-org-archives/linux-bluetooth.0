Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Jan 2014 15:24:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] btproxy: Fix resource leak
Message-ID: <20140123132456.GA21605@x220.p-661hnu-f1>
References: <1390468048-8526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390468048-8526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jan 23, 2014, Andrei Emeltchenko wrote:
> Close file descriptors before leaving.
> ---
>  tools/btproxy.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
