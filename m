Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jun 2014 14:53:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Remove reason parameter from
 hci_amp_disconn function
Message-ID: <20140627115354.GA25714@t440s.ger.corp.intel.com>
References: <1403869510-30820-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403869510-30820-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jun 27, 2014, Marcel Holtmann wrote:
> The hci_amp_disconn function is a local function and there is no
> need for a reason parameter. That one can be retrieved from the
> hci_conn object easily.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
