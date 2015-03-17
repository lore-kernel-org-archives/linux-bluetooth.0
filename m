Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Mar 2015 18:43:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 1/6] Bluetooth: Introduce
 HCI_QUIRK_SIMULTANEOUS_DISCOVERY
Message-ID: <20150317164322.GA21329@t440s.P-661HNU-F1>
References: <1426608257-20332-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426608257-20332-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Mar 17, 2015, Jakub Pawlowski wrote:
> Some controllers allow both LE scan and BR/EDR inquiry to run at
> the same time, while others allow only one, LE SCAN or BR/EDR
> inquiry at given time.
> 
> Since this is specific to each controller, add a new quirk setting
> that allows drivers to tell the core wether given controller can
> do both LE scan and BR/EDR inquiry at same time.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  include/net/bluetooth/hci.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

All 6 patches have been applied to bluetooth-next. Thanks.

Johan
