Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:36:30 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: trivial: Remove sparse warnings
Message-ID: <20120316153630.GB21335@x220>
References: <1331626715-23685-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331626715-23685-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Mar 13, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fix sparse warnings related to incorrect type in assignment and static symbol.
> Also use const keyword. Warnings are shown below:
> 
> ...
> net/bluetooth/mgmt.c:305:28: warning: incorrect type in assignment
> (different base types)
> net/bluetooth/mgmt.c:305:28:    expected unsigned short [usertype] *opcode
> net/bluetooth/mgmt.c:305:28:    got restricted __le16 *<noident>
> ...
> net/bluetooth/mgmt.c:2609:3: warning: symbol 'mgmt_handlers' was not declared.
> Should it be static?
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/mgmt.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
