Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Aug 2012 10:30:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix memory leak
Message-ID: <20120826073022.GC32318@x220>
References: <1345852298-9204-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345852298-9204-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Aug 24, 2012, Vinicius Costa Gomes wrote:
> When ignoring a LE device that is not in a discoverable state 'alias'
> is leaking.
> ---
>  src/adapter.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
