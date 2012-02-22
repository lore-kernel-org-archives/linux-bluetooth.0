Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 16:13:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Enable timestamps for control channel
Message-ID: <20120222141315.GA24181@x220.ger.corp.intel.com>
References: <1329914968-7643-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329914968-7643-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 22, 2012, Marcel Holtmann wrote:
> The control channel can be also monitored, so include timestamps here
> as well. And make sure management events get their timestamp when they
> are created.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c |    1 +
>  net/bluetooth/mgmt.c     |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
