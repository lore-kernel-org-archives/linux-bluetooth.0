Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4D53D61B-794E-43C5-9D3B-79FBF1175208@holtmann.org>
References: <20180730064424.13996-1-luiz.dentz@gmail.com> <4D53D61B-794E-43C5-9D3B-79FBF1175208@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Jul 2018 14:43:20 +0300
Message-ID: <CABBYNZ+hRfMkFjuuBCdL4DopgyatYsmt--GzjaSR8h6=Biik_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] doc/adapter-api: Add Discoverable option to SetDiscoveryFilter
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jul 30, 2018 at 2:09 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> This enables the client to set its discoverable setting while
>> discovering which is very typical situation as usually the setings
>> application would allow incoming pairing request while scanning, so
>> this would reduce the number of calls setting Discoverable and
>> DiscoverableTimeout and restoring after done with discovery.
>> ---
>> doc/adapter-api.txt | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>> index d14d0ca50..4791af2c7 100644
>> --- a/doc/adapter-api.txt
>> +++ b/doc/adapter-api.txt
>> @@ -113,6 +113,12 @@ Methods          void StartDiscovery()
>>                               generated for either ManufacturerData and
>>                               ServiceData everytime they are discovered.
>>
>> +                     bool Discoverable (Default: false)
>> +
>> +                             Make adapter discoverable while discoverin=
g,
>> +                             if the adapter is already discoverable thi=
s
>> +                             setting this filter won't do anything.
>> +
>>                       When discovery filter is set, Device objects will =
be
>>                       created as new devices with matching criteria are
>>                       discovered regardless of they are connectable or
>
> I am now regretting that we didn=E2=80=99t add a uint32 Flags parameter t=
o Start Service Discovery mgmt command if this is something that is often d=
one. Letting the kernel coordinate this properly for the lifetime of the di=
scovery would be best. Otherwise things start to get racy eventually. Meani=
ng that when implementing this in bluetoothd, we need to be careful to hand=
le other mgmt commands correctly that might be issued from non-bluetoothd a=
pplications.

Yep, though StartDiscovery does continuous discovery while the mgmt
don't have that so I suppose if we do want to extend the mgmt
interface to add such flags we could perhaps add a flag to do it
continuously otherwise we would be toggling the setting on every
discovery window which is imo not very nice. Also should this perhaps
be extended to support add advertising into the picture, I guess it
should since discovery filters are for both LE and BR/EDR.

We anyway need a new command for extended scanning so we can have a
PHY filter, or we do intended to have the PHY as address_type? I guess
not so that means we could adds this sort of filter when do add PHY
filtering, though we still need to support old kernels so Im afraid we
will have do something in bluetoothd no matter what.

> Regards
>
> Marcel
>



--=20
Luiz Augusto von Dentz
