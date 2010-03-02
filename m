Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 2 Mar 2010 22:28:44 +0800
Message-ID: <55d43d1d1003020628l543e9af6o535d6fd256c58cb0@mail.gmail.com>
Subject: question about 'read' system call of sco socket
From: liu yang <yangliu.seu@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tan Miaoqing <rabbitrun84@gmail.com>,
	Valerio Valerio <vdv100@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi experts,
I have one question about 'read' system call of sco socket. I'm using
an open source  library which implements bluetooth handfree profile on
linux platform. About our use case, cell phone works as audio gateway
that all audio received on cell phone will be streamed to linux PC,
and vice versa. Everything works just fine of audio streaming above
bluetooth channel. But our special application is very sensitive on
timing that we need send/receive bluetooth audio frame every 20ms.
Regarding sending direction, I can tweak MTU of bluetooth donglel
installed on my linux PC. Let's say, MTU is set to 320 bytes, so every
20ms 'send' system call only needs be called one time. ( the audio
frame conveyed aboved bluetooth is of signed linear 16bit per sample,
8K sampling-rate )  But this does not affect receiving direction that
every 'read' system call on sco socket returns exact 48 bytes. Also I
find such 'read' event on linux 'poll' is triggered every 10ms. Every
10ms, such 'read' action is invoked, but it takes 3 or 4 times
invokation ( sometimes 3 , sometimes 4) of  'read' to consume this
'read' event, which results in 'EAGAIN'. So every 20ms, I get 288
(48*6) or 336 (48*7)  bytes, not exact 320 I expect.

Shortly, my question is how to receive ( 'read' system call ) exact
320 bytes every 20ms.

Thanks

Kandy
