Return-Path: <cyrus@holtmann.org>
Message-ID: <4CAAEB19.5090907@Atheros.com>
Date: Tue, 5 Oct 2010 14:38:41 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: Sim Access profile server implementation
References: <1285657515.12097.7.camel@atheros013-desktop> <1286265730.17473.29.camel@aeonflux>
In-Reply-To: <1286265730.17473.29.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 10/5/2010 1:32 PM, Marcel Holtmann wrote:
> Hi Suraj,
>
>> Please find the Git tree for the Sim access profile server role
>> implementation I have been working on at
>>
>> git://gitorious.org/sap-server/sap-server.git
>>
>> Not sure it could be directly used with Bluez. Nevertheless, it has the
>> parser implementation of Bluetooth SAP packet. Someone could possibly
>> reuse it in their implementation.
>
> have you actually tested this with real SAP server capable hardware? I
> am still not convinced at all to push APDU over D-Bus. First, there is
> potential security issue here and second the latency that D-Bus
> introduces seems not be acceptable. So what I am getting it, can this be
> actually used in a product that seriously wants to support SAP server?

No, This was tested with a dummy Agent and PTS. I am yet to get hold of 
a hardware.

The reason for sharing the source code was because any later SAP server 
implementation can re-use the SAP packet parser implementation I have 
already done.

I think we should be able to change the interface later depending on the 
actual hardware/system requirement. But, I believe the internal 
implementation could stay the same.

>
> Regards
>
> Marcel
>
>

Regards
Suraj
