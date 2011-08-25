Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 22:17:52 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Reset the security timer when a command
 is queued
Message-ID: <20110825011751.GC5462@joana>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798816-8647-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798816-8647-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-19 21:06:50 -0300]:

> Each time a SMP command is enqueued, we reset the SMP timer,
> this way we follow exactly what the spec mandates:
> 
> "The Security Manager Timer shall be reset when an L2CAP SMP command is
> queued for transmission." Vol. 3, Part H, Section 3.4
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/smp.c |   15 +++------------
>  1 files changed, 3 insertions(+), 12 deletions(-)

Applied, thanks.

	Gustavo
