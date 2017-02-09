Return-Path: <szymon.janc@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <3CF37350-C135-465D-9075-C1ED3B0D6F60@holtmann.org>
References: <20170209010508.150518-1-mcchou@chromium.org> <3CF37350-C135-465D-9075-C1ED3B0D6F60@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Thu, 9 Feb 2017 09:07:37 +0100
Message-ID: <CAAEJBhKR8W4g8Oyd+W-KRTrRkY-kueFiDRxA_fUD1J3sQ61OaA@mail.gmail.com>
Subject: Re: [PATCH] device: Add device type property
To: Marcel Holtmann <marcel@holtmann.org>
Cc: mcchou@chromium.org, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, josephsih@chromium.org, ortuno@chromium.org,
	Eric Caruso <ejcaruso@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 9 February 2017 at 08:37, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eric,
>
>> This allows us to gather information about whether a device
>> supports BR/EDR, BLE, or both. It appears as DBus Property
>> "Type" on the org.bluez.Device1 interface.
>>
>> This is tested with the following steps:
>> Scan for devices and request the type property of a specific remote devi=
ce,
>> using:
>>  # dbus-send --print-reply --system --dest=3Dorg.bluez <obj path> \
>>    org.freedesktop.DBus.Properties.Get \
>>      string:org.bluez.Device1 string:Type
>> or request the type of all remote devices, using:
>>  # dbus-send --print-reply --system --dest=3Dorg.bluez / \
>>    org.freedesktop.DBus.ObjectManager.GetManagedObjects | \
>>      grep -B1 -A2 Type
>> and check for "BR/EDR", "LE", and "DUAL"
>> ---
>> doc/device-api.txt |  5 +++++
>> src/device.c       | 31 +++++++++++++++++++++++++++++++
>> 2 files changed, 36 insertions(+)
>>
>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index 13b28818e..2f3100cd5 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -141,6 +141,11 @@ Properties       string Address [readonly]
>>
>>                       The Bluetooth class of device of the remote device=
.
>>
>> +             string Type [readonly, optional]
>> +
>> +                     The carriers supported by this remote device. If i=
t
>> +                     exists, it can be one of "BR/EDR", "LE", or "DUAL"=
.
>> +
>
> I don=E2=80=99t like upper-case for values of this type. We have kept the=
m normally all lower-case.
>
> Anyhow, actually you can deduct this information already from existing Cl=
ass and Appearance values. If Class exists it is BR/EDR and if Appearance e=
xists it is LE. If both exist it is dual-mode device. Only trick part might=
 be that Appearance is optional, but we could just fill it in with some gen=
eric value. Would need to look that up.

I think that if we decide to go with dedicated prop for this, it
should rather be an array of strings of supported technologies
eg [LE, BR/EDR] instead of string for device type. That way we could
leave room for extending those easily if needed in
the future (eg with AMP ?).

--=20
pozdrawiam
Szymon K. Janc
