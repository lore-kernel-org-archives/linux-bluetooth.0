Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110411160058.GB2195@joana>
References: <1301510036-17282-1-git-send-email-andre.dieb@signove.com>
	<20110411160058.GB2195@joana>
Date: Mon, 11 Apr 2011 17:18:43 +0000
Message-ID: <BANLkTi=p=nqbKxZbTRU8eGMBXKbXN4uh2Q@mail.gmail.com>
Subject: Re: [RFC 1/2] Add Type property to Device
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Andre Dieb Martins <andre.dieb@signove.com>,
	linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

On Mon, Apr 11, 2011 at 4:00 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> * Andre Dieb Martins <andre.dieb@signove.com> [2011-03-30 15:33:55 -0300]:
>
>> ---
>>  doc/device-api.txt |    4 ++++
>>  src/device.c       |   18 ++++++++++++++++++
>>  src/device.h       |    2 ++
>>  3 files changed, 24 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index d1feb18..a667296 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -130,6 +130,10 @@ Properties       string Address [readonly]
>>                       Proposed icon name according to the freedesktop.org
>>                       icon naming specification.
>>
>> +             string Type [readonly]
>> +
>> +                     Device type (BR/EDR, LE, BR/EDR/LE).
>> +
>>               uint32 Class [readonly]
>>
>>                       The Bluetooth class of device of the remote device.
>> diff --git a/src/device.c b/src/device.c
>> index d567952..96683de 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -228,6 +228,20 @@ static void device_free(gpointer user_data)
>>       g_free(device);
>>  }
>>
>> +const char *devtype2str(device_type_t type)
>> +{
>> +     switch (type) {
>> +     case DEVICE_TYPE_BREDR:
>> +             return "BR/EDR";
>> +     case DEVICE_TYPE_LE:
>> +             return "LE";
>> +     case DEVICE_TYPE_DUALMODE:
>> +             return "BR/EDR/LE";
>
> I think that  use "Dual Mode" is much better here.
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
> --


Marcel asked me to wait until we have a request from UI developers.

This property is more useful in the DeviceFound() signal, since it is
not clear how to guess the type of the device found. For the Adapter
and Device objects it is less relevant at the moment.

BR,
Claudio
