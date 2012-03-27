Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 13:02:42 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Check for minimum data length in
 eir_has_data_type()
Message-ID: <20120327160242.GB9856@joana>
References: <1332760902-16071-1-git-send-email-johan.hedberg@gmail.com>
 <1332760902-16071-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332760902-16071-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2012-03-26 14:21:42 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> If passed 0 as data_length the (parsed < data_length - 1) test will be
> true and cause a buffer overflow. In practice we need at least two bytes
> for the element length and type so add a test for it to the very
> beginning of the function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

I applied both patches to bluetooth-next

	Gustavo
