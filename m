Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7BB46396-5302-407C-874A-1DE043378DDE@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
 <1393362104-12175-14-git-send-email-andre.guedes@openbossa.org> <7BB46396-5302-407C-874A-1DE043378DDE@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Wed, 26 Feb 2014 16:34:54 -0300
Message-ID: <CACJA=fWbr-tYQL9YHSgU=KSFoNWJ3xF=G5YEWBfOqGJO2=740Q@mail.gmail.com>
Subject: Re: [PATCH 13/17] Bluetooth: Connection parameters and resolvable address
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 26, 2014 at 3:37 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>> We should only add connection parameters for public, random static and
>> random private resolvable with IRK. If we allow non-resolvable or
>> resolvable without IRK, the background scan may run indefinitely. So, to
>> avoid this undesired behavior, we should check the address type in
>> hci_conn_params_add().
>
> this makes no sense. We should only allow auto-connection from public and=
 static random addresses. These two are identity addresses.
>
> Every IRK has an identity address assigned to it. If you want to auto-con=
nect a device using a resolvable private address, then the identity address=
 needs to be programmed into our auto-connection list. The RPA should never=
 ever go there.
>
> That is how connect() works actually. You give it the identity address an=
d it will use the IRK to match it to the RPA in use. We need to do exactly =
the same.
>
> In addition please keep in mind that userspace only knows about RPA as lo=
ng as they are not identified. Once they are identified, the kernel will on=
ly tell us about identity addresses. The RPA will be in all mgmt commands a=
nd events automatically resolved.

Ok, so I'll change hci_conn_params_add() to accept public and random
static addresses only.

BR,

Andre
