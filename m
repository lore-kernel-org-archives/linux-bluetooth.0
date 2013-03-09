Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Mar 2013 17:20:19 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix endianness handling of
 cmd_status/complete opcodes
Message-ID: <20130309202019.GB9938@joana>
References: <1362815630-6800-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362815630-6800-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-03-09 09:53:50 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The opcode in cmd_complete and cmd_status events is 16 bits, so we
> should only be comparing it after having converted it to the host
> endianness. There's already an opcode variable in both functions which
> is in host endiannes so the right fix is to just start using it instead
> of ev->opcode.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
