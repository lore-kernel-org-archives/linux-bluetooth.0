Return-Path: <crosser@average.org>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Eugene Crosser <crosser@average.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073736024.7742.12.camel@pccross.average.org>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
	 <1073736024.7742.12.camel@pccross.average.org>
Content-Type: text/plain
Message-Id: <1073736666.12699.4.camel@pccross.average.org>
Mime-Version: 1.0
Date: Sat, 10 Jan 2004 15:11:06 +0300
List-ID: <bluez-devel.lists.sourceforge.net>

Continuing investigation:

> As far as I can tell from analyzing the dump, and objdump of l2cap.o
> object, BUG() happens when "sk_set_owner(sk, THIS_MODULE);" in
> net/bluetooth/l2cap.c line 353 encounters zero refcount of the module. 
> So, probably somebody incorrectly decreases the l2cap's refcount
> elsewhere...

yes, this seems to be true (and explains the fixed number of attempts). 
Reference count increases by one every time session starts, and
decreases by *two* when it is finished.  Why initial refcount is 5 is
still unclear to me...

root@pccross:/# lsmod|grep l2cap
l2cap                  21952  5 rfcomm
bluetooth              44004  7 rfcomm,l2cap,hci_usb
root@pccross:/# PPP opened

root@pccross:/# lsmod|grep l2cap
l2cap                  21952  6 rfcomm
bluetooth              44004  7 rfcomm,l2cap,hci_usb
root@pccross:/# PPP closed

root@pccross:/# lsmod|grep l2cap
l2cap                  21952  4 rfcomm
bluetooth              44004  7 rfcomm,l2cap,hci_usb
root@pccross:/# PPP opened

root@pccross:/# lsmod|grep l2cap
l2cap                  21952  5 rfcomm
bluetooth              44004  7 rfcomm,l2cap,hci_usb
root@pccross:/# PPP closed

root@pccross:/# lsmod|grep l2cap
l2cap                  21952  3 rfcomm
bluetooth              44004  7 rfcomm,l2cap,hci_usb

Eugene
