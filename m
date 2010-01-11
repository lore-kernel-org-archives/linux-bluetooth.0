Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jan 2010 16:41:55 +0100
From: lukasz <ru-dy@o2.pl>
Subject: l2cap - packet handled event
To: linux-bluetooth@vger.kernel.org
Message-Id: <1263224515l.20825l.6l@jars-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm sorry if I write this msg in wrong place or wrong format.

I'm using bluez and all my operations are using socket API. I have 
problem with latencies and I would like to know, when my packet was 
sent. Is there any possibility to subscribe with function handler or 
get "packet handled" event from the stack ? In my case I don't want to 
send next packet, if the previous one is not sent ( I don't want buffer 
them, throughput can be limited, I need minimal latencies). Is there 
any possibility to limit socket buffer size (2nd write to socket will 
block, when I will try to write 2nd packet, before 1st is not sent) ?


best regards,
sorry for my English

