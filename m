Return-Path: <survivor@uni-paderborn.de>
Message-ID: <4148BE6F.4060802@uni-paderborn.de>
Date: Thu, 16 Sep 2004 00:13:03 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de>	 <1095234376.5263.10.camel@pegasus>  <4148A827.6030103@uni-paderborn.de> <1095282404.19426.6.camel@pegasus>
In-Reply-To: <1095282404.19426.6.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel!

Marcel Holtmann schrieb:

>
>this is supported much longer, but it was not easy to get it working.
>
>  
>
Well, yes, I remember there was a device hci0, but it didn't work. I 
haven't tried any harder. Now (Kernel 2.6.5) it works just by pluggin it 
in as ist should. Nice, now I have 4 dongles but I need to assemble 
another pc from the parts lying around here...

>
>You must recompile your kernel and actually modifying them makes not
>really sense, because for example the HCI disconnect timeout is useful
>to keep the ACL link open for 2-4 seconds so that it can be reused by
>the next L2CAP connection.
>
>  
>
I fond something much easier and better: "hciconfig hci0 pageto 
<slots>". When I use connect() in blocking mode and set the pageto to a 
small value, the connection attempt failure is reported in acceptable 
time. Since hcitool can do it programmatically, I can surely do it, too 
(by simply looking it up). I noticed that I have to increase the pageto 
up to 10000 or higher for the first paging. I suppose because the clock 
offset needs to be synchronized and afterwards it work even with a 
pageto of only 1 slot (but 500 slots = 312,5 ms is ok for me).

Regards
Stefan
