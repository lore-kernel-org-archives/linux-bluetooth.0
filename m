Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Jun 2012 23:57:22 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix compile warnings in mgmt
Message-ID: <20120619025722.GA1679@joana>
References: <1340013826-13432-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340013826-13432-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-18 13:03:46 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Commit af7985bf85840e3dc90ba108a679db044f91f00e introduced regression
> resulting in complie warnings:
> 
> ...
> net/bluetooth/mgmt.c:3568:27: warning: invalid assignment: |=
> net/bluetooth/mgmt.c:3568:27:    left side has type restricted __le32
> net/bluetooth/mgmt.c:3568:27:    right side has type int
> net/bluetooth/mgmt.c:3570:27: warning: invalid assignment: |=
> net/bluetooth/mgmt.c:3570:27:    left side has type restricted __le32
> net/bluetooth/mgmt.c:3570:27:    right side has type int
> net/bluetooth/mgmt.c:3580:21: warning: cast from restricted __le32
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/mgmt.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
