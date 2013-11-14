Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Nov 2013 14:59:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Do not change service state in
 btd_service_connect if it fails
Message-ID: <20131114125915.GB15226@x220.p-661hnu-f1>
References: <1384432071-2703-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384432071-2703-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 14, 2013, Luiz Augusto von Dentz wrote:
> If .connect fails and the service state changes it may re-enter
> connect_next, inverting the order and messing up the error of each
> connect request.
> ---
>  src/service.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
