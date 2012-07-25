Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 21:20:42 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Masatake YAMATO <yamato@redhat.com>
Cc: andrei.emeltchenko.news@gmail.com, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/8] bluetooth: Added /proc/net/bnep via
 bt_procfs_init()
Message-ID: <20120725002042.GQ20029@joana>
References: <20120629.020253.963694178693689545.yamato@redhat.com>
 <20120710140400.GA15795@aemeltch-MOBL1>
 <20120711.135831.1712662939552441872.yamato@redhat.com>
 <20120711.135935.132280748714890089.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120711.135935.132280748714890089.yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

* Masatake YAMATO <yamato@redhat.com> [2012-07-11 13:59:35 +0900]:

> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  net/bluetooth/bnep/sock.c |   22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

For the rest of the series I'd like you add some commit message to your patch,
only a commit title is not acceptable, even if in a simple patch. Also use
"Bluetooth" and not "bluetooth" in the subject line please.

	Gustavo
