Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110421011852.GB9392@joana>
References: <BANLkTinpSJeozeWCcYCBeQ=sxKU5SJSrSQ@mail.gmail.com>
	<20110421011852.GB9392@joana>
Date: Thu, 21 Apr 2011 23:45:29 -0300
Message-ID: <BANLkTik3CkS4OM9ycDQ-_gs5UE0Pu0jo7A@mail.gmail.com>
Subject: Re: Read RSSI through Management Interface?
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Apr 20, 2011 at 10:18 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Claudio,
>
> * Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-04-20 19:20:57 =
-0300]:
>
>> Hi guys,
>>
>> we need to read the RSSI of LE and basic rate connections to implement
>> the Proximity profile. RSSI included in the advertising packets can't
>> be used for Proximity, it requires an "active" connection.
>>
>> Here are some suggestions:
>>
>> 1. Add a new command to mgmt interface to add a given address into a
>> RSSI "monitoring list".
>> =C2=A0 =C2=A0When the connection is established the kernel will automati=
cally
>> track the RSSI of the connection on regular intervals sending
>> HCI_Read_RSSI. Read RSSI value can be reported through a new event in
>> the management interface
>>
>> Forgetting SMP, we can keep the hciops compatibility implementing the
>> same logic inside the hciops plugin.
>
> I'm against this in hciops. Let's add the new features only to mgmtopts, =
so we
> force people to use it and deprecate hciops.

We need to keep both "interfaces" working, the same way that we are
trying to do for discovery.
When hciops will be removed?

Anyway, if someone wants to use LE Security Manager/Pairing it is
necessary to use the Management Interface. If security is not
essential for LE, hciops can be used. For basic rate, it will be
functional on both "interfaces".

Claudio.
>
>>
>> 2. Add a new command to mgmt interface to actively read the RSSI of a
>> given connection/address
>
> If the user use this in the wrong way it will waste power. Let's
> do (1) and not give him this option to actively read RSSI.
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>
