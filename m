Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Apr 2012 19:39:21 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 02/26] Bluetooth: Adds set_default function in L2CAP setup
Message-ID: <20120406223921.GD2915@joana>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332941509-21345-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-28 16:31:25 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Some parameters in L2CAP chan are set to default similar way in
> socket based channels and A2MP channels. Adds common function which
> sets all defaults.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |   11 +++++++++++
>  net/bluetooth/l2cap_sock.c    |    8 ++------
>  3 files changed, 14 insertions(+), 6 deletions(-)

Applied, thanks.

	Gustavo
