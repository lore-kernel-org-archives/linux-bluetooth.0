Return-Path: <cyrus@holtmann.org>
Date: Sat, 7 Mar 2015 22:14:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH bluetooth-next] Bluetooth: fix sco_exit compile warning
Message-ID: <20150307201413.GA26263@t440s.P-661HNU-F1>
References: <1425757948-10550-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425757948-10550-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Sat, Mar 07, 2015, Alexander Aring wrote:
> While compiling the following warning occurs:
> 
> WARNING: net/built-in.o(.init.text+0x602c): Section mismatch in
> reference from the function bt_init() to the function
> .exit.text:sco_exit()
> The function __init bt_init() references
> a function __exit sco_exit().
> This is often seen when error handling in the init function
> uses functionality in the exit path.
> The fix is often to remove the __exit annotation of
> sco_exit() so it may be used outside an exit section.
> 
> Since commit 6d785aa345f525e1fdf098b7c590168f0b00f3f1 ("Bluetooth:
> Convert mgmt to use HCI chan registration API") the function "sco_exit"
> is used inside of function "bt_init". The suggested solution by remove
> the __exit annotation solved this issue.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Johan Hedberg <johan.hedberg@intel.com>
> ---
> I don't have any working bluetooth setup here, just compile tested.
> 
>  net/bluetooth/sco.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
