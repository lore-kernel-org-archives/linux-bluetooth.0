Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Don't set LE flags in mgmt_start_discovery()
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <20111122215822.GA23550@fusion.localdomain>
Date: Thu, 24 Nov 2011 15:06:14 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <70B35869-720B-4A42-8E3C-84679BE805FC@openbossa.org>
References: <1321991470-2201-1-git-send-email-andre.guedes@openbossa.org> <20111122215822.GA23550@fusion.localdomain>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Nov 22, 2011, at 6:58 PM, Johan Hedberg wrote:

> Hi Andre,
> 
> On Tue, Nov 22, 2011, Andre Guedes wrote:
>> Since LE based discovery procedures are not yet supported, we should
>> not set the LE flags in mgmt_start_discovery(). Otherwise, we might
>> get an error from management interface.
>> ---
>> plugins/mgmtops.c |    2 --
>> 1 files changed, 0 insertions(+), 2 deletions(-)
>> 
>> diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
>> index b9e9ad6..d28f89c 100644
>> --- a/plugins/mgmtops.c
>> +++ b/plugins/mgmtops.c
>> @@ -1689,8 +1689,6 @@ static int mgmt_start_discovery(int index)
>> 	hdr->index = htobs(index);
>> 
>> 	hci_set_bit(MGMT_ADDR_BREDR, &cp->type);
>> -	hci_set_bit(MGMT_ADDR_LE_PUBLIC, &cp->type);
>> -	hci_set_bit(MGMT_ADDR_LE_RANDOM, &cp->type);
>> 
>> 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
>> 		return -errno;
> 
> Since setting these bits is what user space needs to do anyway in the
> long run I don't thing it's worth to remove them temporarily. Instead
> I'd just make the kernel modifications initially so that an error is
> only triggered of MGMT_ADDR_BREDR isn't set and in other cases just do
> normal BR/EDR discovery (and ignore the LE bits).

In that case, let's just ignore the kernel patch "Consider the type
param in start_discovery" and keep ignoring the type parameter.

I think I do not quite understand this change in start discovery
command. How should the command work now?

For instance, let's say we have the userspace always setting those bits
(BR/EDR and LE). If the hardware doesn't support LE should the kernel
return error? Or do we expect it does a kind of "best effort" and runs
the inquiry only?

BR,

Andre

