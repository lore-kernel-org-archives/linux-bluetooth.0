Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 15:05:53 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix not marking a reverse SDP discovery as
 "reverse"
Message-ID: <20120320180553.GA16280@x220>
References: <1332265773-32279-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332265773-32279-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Mar 20, 2012, Vinicius Costa Gomes wrote:
> Some devices "hide" some of their records while connected to other
> devices. Setting a service discovery as reverse makes BlueZ to not
> remove the records that are "hidden".
> 
> This patch fixes a mistake that reverse parameter was changed to false
> when it should be true.
> ---
>  src/device.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
