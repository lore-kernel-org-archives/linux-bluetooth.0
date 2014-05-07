Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 May 2014 14:21:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/gatt: Check if handles counter is not wrapped
Message-ID: <20140507112138.GA32412@t440s.lan>
References: <1399386443-25537-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399386443-25537-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, May 06, 2014, Szymon Janc wrote:
> Make sure that handles are fitting in UINT16_MAX range before adding
> service to database.
> ---
>  src/shared/gatt-db.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
