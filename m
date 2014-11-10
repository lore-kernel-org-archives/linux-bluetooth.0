Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v3] Bluetooth: Fix sparse warning in amp.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415627625-15191-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 11 Nov 2014 08:08:29 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <050EFC4D-A200-4D03-AC8B-56A3CBC7ECB2@holtmann.org>
References: <1415626989-14499-1-git-send-email-johan.hedberg@gmail.com> <1415627625-15191-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This fixes the following sparse warning:
> 
> net/bluetooth/amp.c:152:53: warning: Variable length array is used.
> 
> The warning itself is probably harmless since this kind of usage of
> shash_desc is present also in other places in the kernel (there's even a
> convenience macro SHASH_DESC_ON_STACK available for defining such stack
> variables). However, dynamically allocated versions are also used in
> several places of the kernel (e.g. kernel/kexec.c and lib/digsig.c)
> which have the benefit of not exhibiting the sparse warning.
> 
> Since there are no more sparse warnings in the Bluetooth subsystem after
> fixing this one it is now easier to spot whenever new ones might get
> introduced by future patches.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v3: Use correct location of kernel/kexec.c in commit message
> v2: Fix missing signed-off-by line
> 
> net/bluetooth/amp.c | 25 ++++++++++++++++---------
> 1 file changed, 16 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

