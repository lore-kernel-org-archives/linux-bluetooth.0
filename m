Return-Path: <cyrus@holtmann.org>
Message-ID: <4B8DCCAE.3030103@linux.intel.com>
Date: Wed, 03 Mar 2010 10:42:54 +0800
From: Zhu Yanhai <yanhai.zhu@linux.intel.com>
MIME-Version: 1.0
To: liu yang <yangliu.seu@gmail.com>
CC: linux-bluetooth@vger.kernel.org,
	Tan Miaoqing <rabbitrun84@gmail.com>,
	Valerio Valerio <vdv100@gmail.com>
Subject: Re: question about 'read' system call of sco socket
References: <55d43d1d1003020628l543e9af6o535d6fd256c58cb0@mail.gmail.com>
In-Reply-To: <55d43d1d1003020628l543e9af6o535d6fd256c58cb0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/02/2010 10:28 PM, liu yang wrote:
> Hi experts,
> I have one question about 'read' system call of sco socket. I'm using
> an open source  library which implements bluetooth handfree profile on
> linux platform. About our use case, cell phone works as audio gateway
> that all audio received on cell phone will be streamed to linux PC,
> and vice versa. Everything works just fine of audio streaming above
> bluetooth channel. But our special application is very sensitive on
> timing that we need send/receive bluetooth audio frame every 20ms.
> Regarding sending direction, I can tweak MTU of bluetooth donglel
> installed on my linux PC. Let's say, MTU is set to 320 bytes, so every
> 20ms 'send' system call only needs be called one time. ( the audio
> frame conveyed aboved bluetooth is of signed linear 16bit per sample,
> 8K sampling-rate )  But this does not affect receiving direction that
> every 'read' system call on sco socket returns exact 48 bytes. Also I
> find such 'read' event on linux 'poll' is triggered every 10ms. Every
> 10ms, such 'read' action is invoked, but it takes 3 or 4 times
> invokation ( sometimes 3 , sometimes 4) of  'read' to consume this
> 'read' event, which results in 'EAGAIN'. So every 20ms, I get 288
> (48*6) or 336 (48*7)  bytes, not exact 320 I expect.
>
> Shortly, my question is how to receive ( 'read' system call ) exact
> 320 bytes every 20ms.
>
> Thanks
>
> Kandy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Hi Yang,
I'm not a expert at this. IIRC SCO connection is designed to carry fixed 
rated data, which is 64kbps[1]. In your case, you are expecting about 
16bit*8K = 128kbps, which is beyond of SCO's capability. Maybe you can 
consider creating two SCO links (the upper limit is 3 between two 
Bluetooth devices) to carry your data or maybe you could consider using 
a eSCO link?
Again, I'm not good at this, just saying...

Regards,
Zhu Yanhai

[1] Bluetooth specification Version 2.1, Vol 1, Page 44,
     3.5.5 Synchronous connection-oriented (SCO)
