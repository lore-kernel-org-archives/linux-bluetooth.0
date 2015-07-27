Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Jul 2015 11:23:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dohyun Pyun <dh79.pyun@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BLUEZ] tools/l2test: Fix potential double close
Message-ID: <20150727082313.GA6501@t440s.lan>
References: <1437546336-10105-1-git-send-email-dh79.pyun@samsung.com>
 <1437984142-3701-1-git-send-email-dh79.pyun@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437984142-3701-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pyun,

On Mon, Jul 27, 2015, Dohyun Pyun wrote:
> From: DoHyun Pyun <dh79.pyun@samsung.com>
> 
> If the test gets an error after close the socket, the socket sk
> will be closed again. This patch prevents the double close case.
> ---
>  tools/l2test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
