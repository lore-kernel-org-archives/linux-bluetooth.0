Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 11 Mar 2016 13:00:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Fix potential buffer overflow with Add
 Advertising
Message-ID: <20160311110016.GA5291@t440s>
References: <1457682993-18470-1-git-send-email-johan.hedberg@gmail.com>
 <1457682993-18470-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457682993-18470-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 11, 2016, Johan Hedberg wrote:
> The Add Advertising command handler does the appropriate checks for
> the AD and Scan Response data, however fails to take into account the
> general length of the mgmt command itself, which could lead to
> potential buffer overflows. This patch adds the necessary check that
> the mgmt command length is consistent with the given ad and scan_rsp
> lengths.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c | 4 ++++
>  1 file changed, 4 insertions(+)

For the record, this one probably deserves a Cc: stable tag. It should
cleanly apply to 4.5 and with a little bit of fixing to 4.4 as well
(which might be more important as that's a long term support release).

Johan
