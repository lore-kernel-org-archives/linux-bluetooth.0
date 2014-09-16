Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Sep 2014 21:34:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2] Bluetooth: btusb: Implement driver internal packet
 reassembly
Message-ID: <20140916183406.GA31530@t440s.P-661HNU-F1>
References: <1410847229-44007-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410847229-44007-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 16, 2014, Marcel Holtmann wrote:
> When receiving USB interrupt, bulk or isochronous packet, they normally
> come in fragments. So far the driver just handed each fragment off to
> the hci_recv_fragment function of the Bluetooth core. That function is
> however is so specific that is does not belong in the core. This patch
> implements the same reassembly logic in the driver.
> 
> In addition this fixes a long standing bug where multiple complete
> packets are received within a single USB packet.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 197 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 189 insertions(+), 8 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
