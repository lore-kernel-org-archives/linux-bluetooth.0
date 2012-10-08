Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Oct 2012 12:11:46 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ajay <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: L2CAP Flush_Timeout  Error
Message-ID: <20121008091144.GF2456@aemeltch-MOBL1>
References: <506B3010.6060606@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <506B3010.6060606@globaledgesoft.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 02, 2012 at 11:48:56PM +0530, Ajay wrote:
> Hi,
>     Im currently working in an A2DP stuff, where i noticed an error.
> Here i wanted to monitor the flushed packets due to timeout.
> 
>  I used the  l2test code for my testing purpose
> 
>               On client side   "l2test  -R  -S <bdadddr> "
>               and i set the flush timeout as 100 (opts.flush_to = 100)
> 
>        But  later  when i print the getsockopt value of flush_to, it
> was showing some default value (65532)  harcoded at kernel side.

Try the patch in this thread.

Best regards 
Andrei Emeltchenko 

