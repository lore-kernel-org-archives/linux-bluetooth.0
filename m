Return-Path: <cyrus@holtmann.org>
Message-ID: <215809.85886.qm@web94914.mail.in2.yahoo.com>
References: <177499.67132.qm@web94915.mail.in2.yahoo.com>
Date: Mon, 7 Sep 2009 15:26:28 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: Re: promisc mode and broadcast BT sockets
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <177499.67132.qm@web94915.mail.in2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Got it. [not top posting this time around....]

----- Original Message ----
> From: Pavan Savoy <pavan_savoy@yahoo.co.in>
> To: linux-bluetooth@vger.kernel.org
> Sent: Friday, 4 September, 2009 5:59:25 PM
> Subject: promisc mode and broadcast BT sockets
> 
> Hi,
> 
> I remember that eth0 had some flags which sets the raw sockets into promisc 
> mode, so that we can receive the sockets on the interface even if we are not the 
> intended host.
> does something like this exist for BT sockets ?
> 
> If a user-space process is creating the socket, I understand that the process 
> which does _create, _bind would get the events which it is supposed to, but how 
> ?
> 
> example: I run hcitool scan, and a remote pairing request comes in, would the 
> hcitool process also have access to the pairing request ?
> 
> if YES- then good - my work is done,
> but if NO -- How do I make it to ? + How do I make it receive if the socket is 
> created and does in-kernel socket calls [the hacked up way of get_fs/set_fs of 
> KERNEL_DS].
> 
> 
> Thanks in advance.
> 
> 
>       Love Cricket? Check out live scores, photos, video highlights and more. 
> Click here http://cricket.yahoo.com
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


It does seem that adding all ptypes and all events filter in kernel ['ala hcidump in user-mode] I am able to catch in the events and do get my recvmsg called - unfortunately kernel panicked [may not be a BT issue et. all - just may be i am poor at pointers].

I just want to know, how do I safely implement _send and _recv HCI socket functions in my kernel module ?

regards,
Pavan



      Love Cricket? Check out live scores, photos, video highlights and more. Click here http://cricket.yahoo.com

