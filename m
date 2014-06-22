Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2] doc: Add extra mode for a reduced LE privacy mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAN_7+YbRr0Nfnr0jCUBU-ujxNs0HtwoUpQkyZ_cHKT9LmC5XEQ@mail.gmail.com>
Date: Sun, 22 Jun 2014 18:36:44 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <320B6A98-F0AB-494A-9020-2726E4B1073B@holtmann.org>
References: <1403301178-18988-1-git-send-email-marcel@holtmann.org> <CAN_7+YbRr0Nfnr0jCUBU-ujxNs0HtwoUpQkyZ_cHKT9LmC5XEQ@mail.gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

>> doc/mgmt-api.txt | 21 +++++++++++++++++++--
>> 1 file changed, 19 insertions(+), 2 deletions(-)
>> 
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index e15a78f3e4b7..dfcf719dc757 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -1646,8 +1646,25 @@ Set Privacy Command
>>        This command is used to enable Low Energy Privacy feature using
>>        resolvable private addresses.
>> 
>> -       The value 0x00 disables privacy mode, the value 0x01 enables
>> -       privacy mode.
>> +       The value 0x00 disables privacy mode, the values 0x01 and 0x02
>> +       enable privacy mode.
>> +
>> +       With value 0x01 the kernel will always use the privacy mode. This
>> +       means resolvable private address is used when the controller is
>> +       discoverable and also when pairing is initiated.
>> +
>> +       With value 0x02 the kernel will use privacy mode with resolvable
>> +       private address. In case the conroller is pairable and discoverable
>> +       the identity address is used. Also when pairing is initiated, the
>> +       connection will be established with the identity address.
>> +
> So once device is not discoverable, RPA will be used in advertising, right?

Yes. Non-discoverable devices will always advertise with RPA.

>> +       Exposing the identity address when pairable and discoverable or
>> +       during initated pairing can be a privacy issue. For dual-mode
>> +       controllers this can be neglected since its public address will
>> +       be exposed over BR/EDR anyway.
> 
> Since privacy mode 0x02 for LE controllers seems to have a little or
> even no sense, maybe it should be not allowed ?

We could do that, but I do not want to limit this. I consider this a policy decision the daemon can make by itself.

If you for example have a LE only mode controller and want to use a static address as identity address and you are fine with exposing it during pairing, so be it.

Regards

Marcel

