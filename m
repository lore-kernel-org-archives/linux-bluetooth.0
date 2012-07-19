Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 11:12:05 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: ramm@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: Set name_state to unknown when entry
 name is empty
Message-ID: <20120719141205.GB5141@joana>
References: <1342682771-28584-1-git-send-email-ramm@ti.com>
 <1342682771-28584-3-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342682771-28584-3-git-send-email-ramm@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ram,

* ramm@ti.com <ramm@ti.com> [2012-07-19 10:26:11 +0300]:

> From: Ram Malovany <ramm@ti.com>
> 
> When the name of the given entry is empty , the state needs to be
> updated accordingly.
> 
> Signed-off-by: Ram Malovany <ramm@ti.com>
> ---
>  net/bluetooth/hci_event.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

All 3 patches have been applied to bluetooth.git. But please keep in mind that
we put periods at the end of the summary lines, I fixed that for you this
time.

	Gustavo
