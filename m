Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Possible bug in hci_core.h ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5987A7CB1694D811A04D0002B32C289601BF3C16@il93exb05.corp.mot.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3C16@il93exb05.corp.mot.com>
Content-Type: text/plain
Message-Id: <1099322142.16247.107.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 01 Nov 2004 16:15:42 +0100

Hi Abhi,

> Version: Kernel 2.6.9 with bluez patch 2.6.9-mh3
> 
> File: hci_core.h
> 
> Line: 234
> 
>  
> 
> Shouldn't line 234 be h->acl_num--;
> 
>  
> 
> 229: static inline void hci_conn_hash_del(struct hci_dev *hdev, struct
> hci_conn *c)
> 
> 230: {
> 
> 231:          struct hci_conn_hash *h = &hdev->conn_hash;
> 
> 232:          list_del(&c->list);
> 
> 233:          if (c->type == ACL_LINK)
> 
> 234:                  h->acl_num++;
> 
> 235:          else
> 
> 236:                  h->sco_num--;
> 
> 237: }

you are right. Looks like a stupid copy and paste bug. I will fix it and
send it to mainline.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
