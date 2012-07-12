Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jul 2012 10:42:02 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/8] bluetooth: /proc/net/ entries for bluetooth
 protocols
Message-ID: <20120712074200.GA12931@aemeltch-MOBL1>
References: <20120710140400.GA15795@aemeltch-MOBL1>
 <20120711.135831.1712662939552441872.yamato@redhat.com>
 <20120711112308.GA3044@aemeltch-MOBL1>
 <20120711.211906.1087916687452547370.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120711.211906.1087916687452547370.yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

On Wed, Jul 11, 2012 at 09:19:06PM +0900, Masatake YAMATO wrote:
> > I've tested the patch and it creates entries in /proc/net
> 
> Thanks.
>  
> > BTW: Shall lsof be able to identify l2cap protocol?
> > 
> > for l2test it prints: "can't identify protocol"
> 
> No. I'll work on lsof side after the kernel side
> patches are merged to the main line.

OK, patch looks good though I would eliminate 2 new sparse warnings with
__acquires and __releases attributes.

net/bluetooth/af_bluetooth.c:540:13: warning: context imbalance in
'bt_seq_start' - wrong count at exit
net/bluetooth/af_bluetooth.c:557:13: warning: context imbalance in
'bt_seq_stop' - unexpected unlock

Best regards 
Andrei Emeltchenko

