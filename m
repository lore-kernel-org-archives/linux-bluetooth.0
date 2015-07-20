Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jul 2015 14:56:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Move irk checking logic in preparation to
 new connect method
Message-ID: <20150720115644.GA16837@t440s.lan>
References: <1437390769-6115-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437390769-6115-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Jul 20, 2015, Jakub Pawlowski wrote:
> Move irk checking logic in preparation to new connect method. Also
> make sure that MGMT_STATUS_INVALID_PARAMS is returned when non identity
> address is passed to ADD_DEVICE. Right now MGMT_STATUS_FAILED is
> returned, which might be misleading.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  net/bluetooth/hci_core.c | 11 -----------
>  net/bluetooth/mgmt.c     | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 11 deletions(-)

Applied (with a couple of cosmetic fixes) to bluetooth-next. Thanks.

Johan
