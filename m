Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jul 2012 12:49:43 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 6/8] bluetooth: Added /proc/net/l2cap via
 bt_procfs_init()
Message-ID: <20120711094936.GA9755@aemeltch-MOBL1>
References: <20120711.135831.1712662939552441872.yamato@redhat.com>
 <20120711.140337.6492431783697495.yamato@redhat.com>
 <20120711084824.GA3470@aemeltch-MOBL1>
 <20120711.181931.1000444653721042650.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120711.181931.1000444653721042650.yamato@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

On Wed, Jul 11, 2012 at 06:19:31PM +0900, Masatake YAMATO wrote:
> Andrei, thank you for taking time.
> 
> I've rebased again and I applied my patches with git am.
> They are applied without problem.
> 
> I've regenerated the patches again and compared the new
> ones with the older ones.
> 
> About
> 
> 	[PATCH v3 6/8] bluetooth: Added /proc/net/l2cap via bt_procfs_init()
> 
> One line slided. I've paste the new one to this mail.

Thanks, this one works.

>  About 
> 
>         [PATCH v3 7/8] bluetooth: Added /proc/net/rfcomm via bt_procfs_init()
> 
> I cannot find any change between new one and older one.
> What can I do?

Sorry, my fault, rfcomm patch is OK, I was applying it second time...

Best regards 
Andrei Emeltchenko 

