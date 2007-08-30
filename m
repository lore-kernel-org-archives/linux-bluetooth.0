Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46D69F4D.1060903@andorsystems.com>
Date: Thu, 30 Aug 2007 12:43:25 +0200
From: giulio fedel <giulio.fedel@andorsystems.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <46D57FE3.2090508@andorsystems.com>
In-Reply-To: <46D57FE3.2090508@andorsystems.com>
Subject: Re: [Bluez-users] hci_inquiry problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Thinking a bit more, I found the difference in the structure sizes due 
to a mismatch with arm abi/eabi interfaces (gcc mabi apcs-gnu/aapcs 
option). Probably only a my compiler version specific issue.

     Giulio Fedel

giulio fedel wrote:
> Hi,
> I'm working on an arm embedded system. It turn out that hci_inquiry in 
> hci.c (libs) calls
> 
> --> buf = malloc(sizeof(*ir) + (sizeof(inquiry_info) * (nrsp)))
> ...
> --> ioctl(dd, HCIINQUIRY, (unsigned long) buf)
> ...
> 
> My problem is that sizeof(struct hci_inquiry_req) is not the same in 
> kernel space and in user space (nothing strange), so when in the kernel 
> driver in hci_core.c we do:
> 
> --> hci_inquiry_req * ir;
> ...
> --> ptr += sizeof(ir);
> --> copy_to_user(ptr, buf, sizeof(struct inquiry_info) * ir.num_rsp)
> 
> and in the library code (hci_inquiry)
> 
> --> hci_inquiry_req * ir;
> ...
> --> memcpy((void *) *ii, buf + sizeof(*ir), size);
> 
> the things do not work as aspected.
> I solved my problem with __attribute__ ((packed)) in hci.h
> in the kernel tree (include/net/bluetooth/) and in the library
> (include/hci.h).
> 
> Regards.
> 
>      Giulio Fedel
> 
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
