Return-Path: <binch@mobilesoft.com.cn>
Subject: Re: [Bluez-users] how to recognize whether the connected device is
	a headset
From: Chen Bin <binch@mobilesoft.com.cn>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098380504.4885.18.camel@pegasus>
References: <1098352217.1912.4.camel@debian>
	 <1098380504.4885.18.camel@pegasus>
Content-Type: text/plain; charset=gb2312
Message-Id: <1098408465.898.15.camel@debian>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 09:27:45 +0800
List-ID: <bluez-users.lists.sourceforge.net>

HI Marcel,
在2004年10月22日的01:41，Marcel Holtmann写道：
> Hi Chen,
> 
> > Thanks very much for previous help from Holtman, and I happen a new
> > problem when I try to find out whether a connected device is a headset.
> > 
> > It can't be browsed using sdptool in both connected mode and discovery
> > mode(paring state), I wonder how I can know its charactics after
> > connected?
> 
> actually the class of device value can be inside the inquiry cache and
> you will see it when a remote device requests a connection. However we
> don't really store these information together with the connection to
> make them available afterwards. Any patch is welcome.

Can you tell me exactly how I can obtain the class of device, including
using which API or tool or which C file I need to check? I only know the
sdp approach (code in sdptool.c) to check the services provided by
device.
 
> 
> What I don't get is why you can't browse when the device is connected?
> Run "hcidump -X" as root and show it to us so we can see what happens.
> 
> > My phone  will be appeared in 3G conference next month, so I am very
> > anxious about the bluetooth feature...
> 
> What does this mean? Is it good or is it bad? And btw my first name is
> Marcel and not Holtmann.
Sorry,Marcel. What I am anxious about is this task is very urgent, the
bluetooth feature is very important(my boss says), if I can't
complish...

Sorry for expressing my individual trifle in this list...

Chen
