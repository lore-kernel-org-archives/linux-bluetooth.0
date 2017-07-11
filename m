Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 11 Jul 2017 12:57:58 +0200
From: Olivier MARTIN <olivier@labapart.com>
To: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc: felix.schulthess@scs.ch
Subject: Re: DBUS API: Retrieve current MTU used by remote device
In-Reply-To: <9c9da882-fd5b-dfa1-447e-a6f05b341f97@scs.ch>
References: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com>
 <9c9da882-fd5b-dfa1-447e-a6f05b341f97@scs.ch>
Message-ID: <555fcf1d1c17c058942d01ca964de616@labapart.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Luiz for the answer, but I am guessing WriteValue() uses Long 
Write. But it looks like not all BLE devices support Long Read/Write 
(including Bluez until recently - v5.39 - April 2016). It also seems 
some/all(?) Android devices do not support it.

I did not find this information but is a device that does not support 
Long Write; would the application still receive GATT packets sent by 
Long Write in a defragmented manner?

The workaround often uses is to leave the GATT server fragmenting itself 
the packets to send to the GATT client with an arbitrary packet length 
value. Knowing the MTU uses between the two GATT devices could improve 
the throughput.
