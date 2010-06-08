Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jun 2010 14:19:54 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Remove ifndef barrier from log.h and btio.h
Message-ID: <20100608061954.GA16335@jh-x301>
References: <1275712886-20127-1-git-send-email-gustavo@padovan.org>
 <1275712886-20127-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275712886-20127-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sat, Jun 05, 2010, Gustavo F. Padovan wrote:
> ---
>  src/btio.h |    3 ---
>  src/log.h  |    4 +---
>  2 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/src/btio.h b/src/btio.h
> index 00d743e..fa6ff69 100644
> --- a/src/btio.h
> +++ b/src/btio.h
> @@ -21,8 +21,6 @@
>   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   *
>   */
> -#ifndef BT_IO_H
> -#define BT_IO_H

I think it'd be good to leave this for BtIO since it might become a
public library soon.

> -#ifndef __LOGGING_H
> -#define __LOGGING_H
> +extern int debug_enabled;

This doesn't match the commit message. To me it seems like the extern
int addition should be part of the third patch and not this one. Also,
Marcel might have had a reason for putting the safeguard for log.h so
just leave these safeguards as they are (ofono and connman has them
too).

Johan
