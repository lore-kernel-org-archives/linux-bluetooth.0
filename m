Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Mar 2015 08:03:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Move memory location outside of
 hci_dev lock
Message-ID: <20150329050302.GA28050@t440s.P-661HNU-F1>
References: <1427581139-10931-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427581139-10931-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Mar 28, 2015, Marcel Holtmann wrote:
> Taking the hci_dev lock for just a memory allocation seems a bit too
> much and not really needed. So instead try to allocate the memory first
> and then take the lock.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
