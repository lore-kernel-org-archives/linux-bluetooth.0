Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Apr 2011 15:33:38 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Add support for getting the Encryption Key Size via
 btio
Message-ID: <20110427183338.GA6951@piper>
References: <1302826003-5511-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302826003-5511-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 21:06 Thu 14 Apr, Vinicius Costa Gomes wrote:
> Some profiles specify some restriction depending on the length
> of the key used to encrypt the link, this adds an way to retrieve
> that value from the kernel.
> 
> Current kernels don't provide this information so the size is
> always zero.
> ---
>  btio/btio.c     |   21 +++++++++++++++++++++
>  btio/btio.h     |    1 +
>  lib/bluetooth.h |    1 +
>  3 files changed, 23 insertions(+), 0 deletions(-)

Some tests need this functionality and they will work even without 
support in the kernel side. May I send an updated version of these 
patches? Or does any one still have comments?

And just to be clear, even the kernel patches just implement the 
communication kernel -> userspace, the other direction will be 
implemented later.


Cheers,
-- 
Vinicius
