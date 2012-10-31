Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Oct 2012 16:27:46 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/5 v1] Bluetooth: mgmt: Use __constant when dealing with
 constants
Message-ID: <20121031182746.GE1679@joana>
References: <1351530456-11873-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351530456-11873-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-10-29 22:37:36 +0530]:

> __constant_cpu_to_le*() is the right go here.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
> v1-> Improve readability by breaking 80 chars rule.
> 
>  net/bluetooth/mgmt.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Patch has been applied to bluetooth-next. Thanks

	Gustavo
