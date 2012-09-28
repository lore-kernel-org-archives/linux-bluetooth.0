Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 12:53:41 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: A2MP: Correct assoc_len size
Message-ID: <20120928155341.GG15463@joana>
References: <1348832490-13448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1348840500-16336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348840500-16336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-09-28 16:55:00 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Correct assoc_len and fix warning for x86-64 by using %zu specifier
> reported by Fengguang Wu <fengguang.wu@intel.com>.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> 	v2: make assoc_len type of size_t
>  net/bluetooth/a2mp.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Patch has been applied to bluetooth-next, Thanks.

	Gustavo
