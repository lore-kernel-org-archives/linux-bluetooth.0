Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Mar 2015 08:20:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add support for Local OOB Extended Data
 Update events
Message-ID: <20150317062038.GA21460@t440s.P-661HNU-F1>
References: <1426547481-7184-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426547481-7184-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 16, 2015, Marcel Holtmann wrote:
> When a different user requests a new set of local out-of-band data, then
> inform all previous users that the data has been updated. To limit the
> scope of users, the updates are limited to previous users. If a user has
> never requested out-of-band data, it will also not see the update.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h  |  1 +
>  include/net/bluetooth/mgmt.h |  7 +++++++
>  net/bluetooth/mgmt.c         | 16 ++++++++++++++++
>  3 files changed, 24 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
