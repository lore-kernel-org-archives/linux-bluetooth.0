Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth: hciuart: Add support QCA chipset for UART
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20150813205655.GA30361@mwanda> <55CD1158.10508@qca.qualcomm.com>
CC: <linux-bluetooth@vger.kernel.org>
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Message-ID: <55CD1342.9090705@qca.qualcomm.com>
Date: Thu, 13 Aug 2015 14:59:30 -0700
MIME-Version: 1.0
In-Reply-To: <55CD1158.10508@qca.qualcomm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

On 08/13/15 14:51, Ben Young Tae Kim wrote:
> Hi Dan,
>
> On 08/13/15 13:59, Dan Carpenter wrote:
>> Hello Ben Young Tae Kim,
>>
>> The patch 0ff252c1976d: "Bluetooth: hciuart: Add support QCA chipset
>> for UART" from Aug 10, 2015, leads to the following static checker
>> warning:
>>

BTW, which tool are you using to detect static warning? Can you 
recommend me some tool so that I could prevent same error to the 
upcoming patches?

Thanks
-- Ben Kim
