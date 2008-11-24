Return-Path: <cyrus@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <CD8AC205-7C97-4078-A211-871D62407247@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: "Liu, Raymond" <raymond.liu@intel.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E0217A981@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Can we change org.openobex.Client's dbus node path?
Date: Mon, 24 Nov 2008 03:41:13 +0100
References: <0463F45F3606F4428ED35AC8C709F92E0217A981@pdsmsx502.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raymond,

> 	I notice that, in obex-client, we create the org.openobex.Client  
> interface under path "/".
> 	It's the same as org.openobex.manager in obexd.
>
> 	While, when create new session for say FTP, Obexd put Session  
> interface under path "/session*" , and obex client put the Session  
> interface under path "/org/openobex/Session*"
>
> 	And this will make the introspect function on client: dbus-send -- 
> print-reply --dest=org.openobex.client /  
> org.freedesktop.DBus.Introspectable.Introspect fail to show the node  
> for /org/openobex/Session* (but dbus-send --print-reply -- 
> dest=org.openobex.client /org  
> org.freedesktop.DBus.Introspectable.Introspect will work)
> 	While for obexd: dbus-send --print-reply --dest=org.openobex /  
> org.freedesktop.DBus.Introspectable.Introspect can show the node  
> for /Session*.
>
> 	So, can we change the path for org.openobex.Client and register it  
> under path "/org/openobex/Client"?  Or we register session, FTP  
> interfaces under root path like that in the obexd? Either way can  
> solve the introspect problem.

we can put the object path wherever we want. That is the whole point  
of having a manager interface to discover/create them. The API  
specification mentions "variable prefix" for a really good reason. So  
whatever is broken here, the fix is not to change the object path. We  
have to fix the broken introspection.

Also I don't see your issue here. So you are saying that within obex- 
client when you introspect / that you are not getting /org in the list  
of paths.

Regards

Marcel

