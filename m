Return-Path: <cyrus@holtmann.org>
Message-ID: <1351537872.1828.0.camel@aeonflux>
Subject: Re: [PATCH 4/5 v1] Bluetooth: mgmt: Use __constant when dealing
 with constants
From: Marcel Holtmann <marcel@holtmann.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 29 Oct 2012 12:11:12 -0700
In-Reply-To: <1351530456-11873-1-git-send-email-s.syam@samsung.com>
References: <1351530456-11873-1-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> __constant_cpu_to_le*() is the right go here.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
> v1-> Improve readability by breaking 80 chars rule.
> 
>  net/bluetooth/mgmt.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


