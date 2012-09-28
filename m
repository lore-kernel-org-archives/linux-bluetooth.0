Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 14:11:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump] amp: Decode Read Data Block Size HCI cmd
Message-ID: <20120928111107.GD14450@x220>
References: <1346331979-3837-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346331979-3837-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Aug 30, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Decode Read Data Block Size HCI command and command status.
> 
>  < HCI Command: Read Data Block Size (0x04|0x000a) plen 0
>  > HCI Event: Command Complete (0x0e) plen 10
>     Read Data Block Size (0x04|0x000a) ncmd 1
>     status 0x00
>     Max ACL 1492 Block len 1492 Num blocks 4
> ---
>  lib/hci.h    |    8 ++++++++
>  parser/hci.c |   24 +++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
