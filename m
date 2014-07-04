Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2014 17:31:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Document the existing device quirks
Message-ID: <20140704143145.GA10260@t440s.P-661HNU-F1>
References: <1404482882-46787-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404482882-46787-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 04, 2014, Marcel Holtmann wrote:
> The current existing device quirks are not documented. So instead of
> spreading bits and pieces somewhere in the code, add proper comments
> on where these quirks can be used and what behavior they change.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
