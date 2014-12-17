Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Dec 2014 22:09:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix bug with filter in service discovery
 optimization
Message-ID: <20141217200922.GA11039@t440s.P-661HNU-F1>
References: <1418836688-77018-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1418836688-77018-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 17, 2014, Marcel Holtmann wrote:
> The optimization for filtering out extended inquiry results, advertising
> reports or scan response data based on provided UUID list has a logic
> bug. In case no match is found in the advertising data, the scan
> response is ignored and not checked against the filter. This will lead
> to events being filtered wrongly.
> 
> Change the code to actually only drop the events when the scan response
> data is not present. If it is present, it needs to be checked against
> the provided filter.
> 
> The patch is a bit more complex than it needs to be. That is because
> it also fixes this compiler warning that some gcc versions produce.
> 
>   CC      net/bluetooth/mgmt.o
> net/bluetooth/mgmt.c: In function ‘mgmt_device_found’:
> net/bluetooth/mgmt.c:7028:7: warning: ‘match’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   bool match;
>        ^
> 
> It seems that gcc can not clearly figure out the context of the match
> variable. So just change the branches for the extended inquiry response
> and advertising data around so that it is clear.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Applied to the bluetooth.git tree. Thanks.

Johan
