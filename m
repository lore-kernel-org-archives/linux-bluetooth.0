Return-Path: <ubaldo@eja.it>
Message-ID: <20040716140215.564.qmail@webmail2.aruba.it>
References: <20040618175410.28510.qmail@webmail.aruba.it>
            <1087582530.4309.121.camel@pegasus>
            <20040618183339.20830.qmail@webmail.aruba.it>
            <1087583875.25061.2.camel@pegasus>
            <20040618184232.25439.qmail@webmail.aruba.it>
            <1087584576.25061.6.camel@pegasus>
In-Reply-To: <1087584576.25061.6.camel@pegasus>
From: "ubaldo" <ubaldo@eja.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: multi rfcomm/sco connection
Date: Fri, 16 Jul 2004 16:02:15 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

Ciao Marcel, 

> actually I don't see why you need more than one SCO link in a connection
> between two devices. However take a look at the kernel source code of
> Linux 2.6.x and especially at net/bluetooth/hci_conn.c

I explain you a bit more my situation... 

I need to be able with a single usb-bt-dongle to play/capture audio for 
several bt-handsfree, I tried with one and there are no problems, but if I 
try to connect another one then I get something like "sco channel busy". 

I studied the net/bluetooth directory but I cannot find any good way to 
achieve what I need! :) 

Am I wrong in something or is this feature really missing?
