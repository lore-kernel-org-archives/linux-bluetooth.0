Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 17:04:02 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] /proc/net/ entries for bluetooth protocols
Message-ID: <20120710140400.GA15795@aemeltch-MOBL1>
References: <20120615080007.GD7205@aemeltch-MOBL1>
 <20120617.092637.2171077367789127221.yamato@redhat.com>
 <20120618082826.GA2898@aemeltch-MOBL1>
 <20120629.020253.963694178693689545.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120629.020253.963694178693689545.yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

On Fri, Jun 29, 2012 at 02:02:53AM +0900, Masatake YAMATO wrote:
> Hi, Andrei
> 
> Could you review my v2 patch set I submitted?

It does not apply, trailing white spaces and it also seems that they are
based on different repository. Please rebase against bluetooth-next. 

Applying: /proc/net/ entries for bluetooth protocols
bluetooth-next-orig.git/.git/rebase-apply/patch:33:
trailing whitespace.
extern int  bt_procfs_init(struct module* module, struct net *net, const
char *name, 
bluetooth-next-orig.git/.git/rebase-apply/patch:140:
trailing whitespace.
	 
bluetooth-next-orig.git/.git/rebase-apply/patch:157:
trailing whitespace.
	
bluetooth-next-orig.git/.git/rebase-apply/patch:163:
trailing whitespace.
	
error: patch failed: include/net/bluetooth/bluetooth.h:30
error: include/net/bluetooth/bluetooth.h: patch does not apply
Patch failed at 0001 /proc/net/ entries for bluetooth protocols
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

> 
>       https://lkml.org/lkml/2012/6/18/170
> 
> Masatake YAMATO

Best regards 
Andrei Emeltchenko 
