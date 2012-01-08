Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jan 2012 22:31:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix using an absolute timeout on
 hci_conn_put()
Message-ID: <20120108203111.GF16731@x220.P-661HNU-F1>
References: <1325689037-19540-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325689037-19540-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Jan 04, 2012, Vinicius Costa Gomes wrote:
> queue_delayed_work() expects a relative time for when that work
> should be scheduled.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
