Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] bluetooth: Allow setting BT_SECURITY_FIPS with setsockopt
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1458828255-21202-1-git-send-email-patrik.flykt@linux.intel.com>
Date: Fri, 8 Apr 2016 10:11:48 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <50D471B7-377B-4E74-961C-8BCD5F52F618@holtmann.org>
References: <1458828255-21202-1-git-send-email-patrik.flykt@linux.intel.com>
To: Patrik Flykt <Patrik.Flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrik,

> Update the security level check to allow setting BT_SECURITY_FIPS for
> an L2CAP socket.
> 
> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> ---
> 
> This seems to have been forgotten when FIPS was introduced?
> 
>     Patrik
> 
> 
> net/bluetooth/l2cap_sock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

