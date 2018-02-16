Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 16 Feb 2018 20:03:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] adapter: Fix initializing GATT server for BR/EDR only
 controllers
Message-ID: <20180216180333.GB29745@x1c>
References: <20180214135815.18250-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180214135815.18250-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Feb 14, 2018, Luiz Augusto von Dentz wrote:
> Controller that do not support LE bearer shall not use GATT server for
> anything.
> ---
> v2: Add check for main_opts.mode and remove change to main.conf
> 
>  src/adapter.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
