Return-Path: <cyrus@holtmann.org>
Date: Sat, 3 Jan 2015 22:33:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Remove dead code for manufacturer inquiry
 mode quirks
Message-ID: <20150103203341.GA19817@t440s.P-661HNU-F1>
References: <1420270520-32581-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420270520-32581-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jan 02, 2015, Marcel Holtmann wrote:
> There are some old Bluetooth modules from Silicon Wave and Broadcom
> which support Inquiry Result with RSSI, but do not advertise it. The
> core has quirks in the code to enable that inquiry mode. However as
> it stands right now, that code is not even executed since entering
> the function to determine which inquiry mode requires that the device
> has the feature bit for Inquiry Result with RSSI set in the first
> place. So this makes this dead code that hasn't work for a long
> time.
> 
> In conclusion, just remove these extra quirks and simplify the setup
> of the inquiry mode to be inline and with that a lot easier to read
> and understand.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 50 +++++++++++-------------------------------------
>  1 file changed, 11 insertions(+), 39 deletions(-)

All three patches in this set have been applied to bluetooth-next.
Thanks.

Johan
