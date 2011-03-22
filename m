Return-Path: <cyrus@holtmann.org>
Message-ID: <4D8825C7.1000904@Atheros.com>
Date: Tue, 22 Mar 2011 09:59:59 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: accessing Link key within the Bluetooth module
References: <4D870E6F.4050502@Atheros.com> <20110321134833.GA8819@jh-x301>
In-Reply-To: <20110321134833.GA8819@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 3/21/2011 7:18 PM, Johan Hedberg wrote:
> Hi Suraj,
>
> That list only gets populated if you've enabled the management interface
> (enable_mgmt=1 module option) and have a matching user space version
> with management interface support.

Thanks,
The link key is required for creating an AMP connection.

Does it make sense to depend the AMP module on the "enable_mgmt" feature?
Or
Add an new link key variable to the "struct hci_conn" and update it by 
handling the LINK KEY related HCI (Link key request/reply) events?
>
> Johan

Regards
Suraj
