Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 10:52:40 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 0/2] Adds support for block based flow ctrl
Message-ID: <20120203185240.GB19240@x220.globalsuite.net>
References: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 03, 2012, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Split HCI scheduling for block and packet flow control.
> 
> Changes:
> 	No change from RFC I've sent some time ago since I've got
> 	no comments.
> 
> Andrei Emeltchenko (2):
>   Bluetooth: Recalculate sched HCI blk/pkt flow ctrl
>   Bluetooth: Helper removes duplicated code
> 
>  net/bluetooth/hci_core.c |   92 ++++++++++++++++++++++++++++++++++++++++------
>  1 files changed, 80 insertions(+), 12 deletions(-)

Both patches have been applied to my bluetooth-next tree. Thanks.

Johan
