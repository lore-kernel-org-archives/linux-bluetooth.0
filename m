Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix smp_e byte order to be consistent with SMP specification
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395140304-15747-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 18 Mar 2014 10:19:49 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8BF0EBC3-A2BB-45CF-BF23-8AC0B6B3C4E1@holtmann.org>
References: <1395140304-15747-1-git-send-email-johan.hedberg@gmail.com> <1395140304-15747-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The SMP specification is written with the assumption that both key
> information, plaintextData and encryptedData follow the same little
> endian byte ordering as the rest of SMP.
> 
> Since the kernel crypto routines expect big endian data the code has had
> to do various byte swapping tricks to make the behavior as expected,
> however the swapping has been scattered all around the place.
> 
> This patch centralizes the byte order swapping into the smp_e function
> by making its public interface match what the other SMP functions expect
> as per specification. The benefit is vastly simplified calls to smp_e.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Fix stk generation
> 
> net/bluetooth/smp.c | 101 ++++++++++++++++++++++++----------------------------
> 1 file changed, 46 insertions(+), 55 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

