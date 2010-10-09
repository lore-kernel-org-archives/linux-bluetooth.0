Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Use a valid PSM as the default in l2test.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	rshaffer@codeaurora.org, gustavo@padovan.org
In-Reply-To: <alpine.DEB.2.00.1010080809510.31147@linux-sea-02>
References: <alpine.DEB.2.00.1010080809510.31147@linux-sea-02>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 09 Oct 2010 10:09:30 +0200
Message-ID: <1286611770.6145.437.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The Bluetooth spec requires PSMs to be odd numbers, with the least
> significant bit of the most significant byte set to 0.  This
> change is a prerequisite for PSM validation in the kernel.
> ---
>   test/l2test.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

it does not apply.

Applying: Use a valid PSM as the default in l2test.
error: patch failed: test/l2test.c:87
error: test/l2test.c: patch does not apply
Patch failed at 0001 Use a valid PSM as the default in l2test.

Regards

Marcel


