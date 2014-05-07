Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BC6B9000-DD5A-4BA4-91B3-F68776872D78@holtmann.org>
References: <1399420690-21653-1-git-send-email-lukasz.rymanowski@tieto.com> <BC6B9000-DD5A-4BA4-91B3-F68776872D78@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Wed, 7 May 2014 09:08:18 +0200
Message-ID: <CAF3PWx0DdnuMmbb8d_0grm-8QH-Pa6OTO9KOfvj03obwSV2hsQ@mail.gmail.com>
Subject: Re: [PATCH] mgmt-api: Add support to get connection characteristics
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 7 May 2014 03:59, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lukasz,
>
>> This patch introduces Get Connection Characteristics command.
>> ---
>> doc/mgmt-api.txt | 36 ++++++++++++++++++++++++++++++++++++
>> 1 file changed, 36 insertions(+)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index cd5cd24..5d31a90 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -1679,6 +1679,42 @@ Load Identity Resolving Keys Command
>>                               Invalid Index
>>
>>
>> +Get Connection Characteristics Command
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> we might need to discuss if we better call it =E2=80=9CGet Connection Inf=
ormation=E2=80=9D. I wait for other people to comment here.

I like it, should be also nicer to put in code - 'characteristics' is
horrible to combine into variable names and abbreviate ;-)

>> +
>> +     Command Code:           0x0031
>> +     Controller Index:       <controller id>
>> +     Command Parameters:     Address (6 Octets)
>> +                             Address_Type (1 Octet)
>> +                             Requested_Characteristics (4 Octet)
>
> Maybe just calling this Data_Types is better. Not that it matters much, b=
ut the field name Requested_Characteristics sound a bit too much.
>
>> +
>
> Remove this extra empty line.
>
>> +     Return Parameters:      Address (6 Octets)
>> +                             Address_Type (1 Octet)
>> +                             RSSI (1 Octet)
>
> Add the Flags (4 Octets) value here. We want to be flexible and being abl=
e to indicate certain flags might come in handy at some point.
>
>> +                             EIR_Data_Length (2 Octets)
>> +                             EIR_Data (0-65535 Octets)
>> +
>> +     This command is used to get connection characteristics information=
.
>> +
>> +     Requested_Characteristics parameter is a bitmask with currently th=
e
>> +     following available bits:
>> +
>> +             0       RSSI
>> +             1       TX Power
>
> Start with 0 =3D TX Power here. There is pretty much no point for RSSI si=
nce that will always be returned.

There will always be RSSI parameter in response but it does not need
to be valid (perhaps we can use Flags for this) unless we query for
RSSI on every request from user-space or poll for RSSI in background,
but I don't think this is what we really want here.

As I understand we want to minimize requests to controller so we do
something like: have timestamps for most recent RSSI and TX power
received and once information is requested, check which one can be
answered from cache and query controller only for missing one. This
implies that both values don't need to be from exactly the same point
of time but they both are no-older-than some interval. Does this make
sense?

> Also we need to note that all other bits are reserved and shall be set to=
 zero. Unknown bits will be ignored by the kernel on reception.
>
>> +     All the requested characteristics other than RSSI are returned in
>> +     EIR_Data.
>> +
>> +     This command generates a Command Complete event on success and
>> +     on failure.
>> +
>> +     Possible errors:        Busy
>> +                             Not Connected
>> +                             Not Powered
>> +                             Invalid Parameters
>> +                             Invalid Index
>
> How can this return Busy? As I said before, we need to just have an inter=
nal configured via debugfs in which this command will return the cached val=
ues. So even if you call this twice in a row or at the same time, we should=
 just return quickly.

In case requested values cannot be answered from cache we need to
query for them and when this is in ongoing we'll request Busy for
other requests. Or we can just queue requests and answer them when
response arrive so we don't need to return Busy.


BR,
Andrzej
