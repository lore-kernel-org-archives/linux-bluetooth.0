Return-Path: <ubaldo@eja.it>
Message-ID: <20040618184232.25439.qmail@webmail.aruba.it>
References: <20040618175410.28510.qmail@webmail.aruba.it>
            <1087582530.4309.121.camel@pegasus>
            <20040618183339.20830.qmail@webmail.aruba.it>
            <1087583875.25061.2.camel@pegasus>
In-Reply-To: <1087583875.25061.2.camel@pegasus>
From: "ubaldo" <ubaldo@eja.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: multi rfcomm/sco connection
Date: Fri, 18 Jun 2004 20:42:32 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

Thanx Marcel for your unlimited patience! :) 


>> > it is possible to establish up to 30 RFCOMM connections into each
>> > direction. The number of SCO connections is limited to one per ACL link. 
>> 
>> Does it mean that for each SCO connection I need another bt-dongle, or there 
>> is a way to allow multi SCO connection with the same bt-dongle?
> 
> I said per ACL link. The Bluetooth specification defines that between
> two devices one ACL and up to three SCO links can exists. The max number
> of SCO links per piconet is also three. In BlueZ we currently allow one
> ACL and one SCO link between two devices. This limitation is some kind
> of historic. Feel free to fix it.

Any tip for where to put the eyes on for fixing? 
