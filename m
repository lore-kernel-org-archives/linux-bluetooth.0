Return-Path: <cyrus@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <C0D77808-B8E7-4BF3-81D8-52EE39667C6C@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: "Liu, Raymond" <raymond.liu@intel.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E0217AA44@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Can we change org.openobex.Client's dbus node path?
Date: Mon, 24 Nov 2008 04:30:50 +0100
References: <0463F45F3606F4428ED35AC8C709F92E0217A981@pdsmsx502.ccr.corp.intel.com> <CD8AC205-7C97-4078-A211-871D62407247@holtmann.org> <0463F45F3606F4428ED35AC8C709F92E0217AA44@pdsmsx502.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raymond,

>> Also I don't see your issue here. So you are saying that within obex-
>> client when you introspect / that you are not getting /org in the  
>> list
>> of paths.
>>
>
> Yes, can not get /org in the node list for org.openobex.client

this is a bug in gdbus then. The exactly same code is used in  
bluetoothd and connmand so it seems weird. Did you try to debug it  
where it actually fails to get this wrong? Are we missing some  
"invalidate parent" calls?

Regards

Marcel

