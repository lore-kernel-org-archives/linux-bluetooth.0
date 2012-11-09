Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Nov 2012 09:11:53 +0100
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Ajay <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BLE issue - Reusing  Existing LE physical link
Message-ID: <20121109081153.GA29180@echo>
References: <509A8FD4.1080800@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <509A8FD4.1080800@globaledgesoft.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 22:14 Wed 07 Nov, Ajay wrote:
>  Hi ,
> 	 I came across an issue as part of my "BLE test tool project"  .
> After the first successful connection of BLE l2cap connection
> (client server) , we just retains the physical link  without calling
> le_connection cancel() (logical link is closed) (patch has been
> added).  But second time   i wanted to use the existing connection ,
> without calling hci_le_connect() . but  here l2cap connect fails . I
> noticed in normal acl link , the same scenario is working on
> existing link.  so  can  we do the same  working on BLE link .
> (ubuntu 11.10  and kernel 3.2.5)

Could you please test with a recent kernel, 3.6.x preferably. LE support has
improved a lot in recent kernels.

> -- 
> Thanks & regards
> 
>  AJAY KV
>  GlobalEdge software Ltd
>  8892753703
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
