Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Mar 2015 06:56:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix BR/EDR out-of-band pairing with only
 initiator data
Message-ID: <20150316045635.GA22800@t440s.P-661HNU-F1>
References: <1426462973-21366-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426462973-21366-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Mar 15, 2015, Marcel Holtmann wrote:
> When only the pairing initiator is providing out-of-band data, then
> the receiver side was ignoring the data. For some reason the code was
> checking if the initiator has received out-of-band data and only then
> also provide the required inidication that the acceptor actually has
> the needed data available.
> 
> For BR/EDR out-of-band pairing it is enough if one side has received
> out-of-band data. There are no extra checks needed here to make this
> work smoothly. The only thing that is needed is to tell the controller
> if data is present (and if it is P-192 or P-256 or both) and then let
> the controller actually figure out the rest.
> 
> This means the check for outgoing connection or if the initiator has
> indicated data are completely pointless and are in fact actually
> causing harm. The check in question is this one:
> 
>    if (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)) {
> 
> After just taking the conditional check out and always executing the
> code for determining the type of out-of-band data, the pairing works
> flawlessly and prodcudes authenticated link keys.
> 
> The patch itself looks more complicated due to the reformatting of the
> indentation, but it essentially just a two-line change.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 54 ++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
