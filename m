Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a78fe881-49e0-790e-cbc5-513b0c005f39@felipetonello.com>
References: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
 <1473338340-7587-2-git-send-email-luiz.dentz@gmail.com> <a78fe881-49e0-790e-cbc5-513b0c005f39@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Sep 2016 15:58:24 +0300
Message-ID: <CABBYNZLUVCW2HhBY=vQiCz=mAFpNm=HOJbv15W2txRBa-FH33Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/5] core/device: Call profile disconnect if ATT disconnects
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Thu, Sep 8, 2016 at 6:33 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Luiz,
>
> On 08/09/16 13:38, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> If the profile accepts connections it should also be notified when ATT
>> disconnects so it can cleanup properly.
>> ---
>>  src/device.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 9586022..eda873f 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -4563,6 +4563,18 @@ static void attio_disconnected(gpointer data, gpointer user_data)
>>               attio->dcfunc(attio->user_data);
>>  }
>>
>> +static void disconnect_gatt_service(gpointer data, gpointer user_data)
>> +{
>> +     struct btd_service *service = data;
>> +     struct btd_profile *profile = btd_service_get_profile(service);
>> +
>> +     /* Ignore if profile cannot accept connections */
>> +     if (!profile->accept)
>> +             return;
>
> What if the profile has connect and not accept?

GATT drivers can only accept not connect so this specific to avoid
disconnecting BR/EDR profiles if both bearers are connected, we might
as well introduce a flag to indicate the driver is to be using with
GATT only if we want to make it more clear.

>> +
>> +     btd_service_disconnect(service);
>> +}
>> +
>>  static void att_disconnected_cb(int err, void *user_data)
>>  {
>>       struct btd_device *device = user_data;
>> @@ -4575,6 +4587,7 @@ static void att_disconnected_cb(int err, void *user_data)
>>       DBG("%s (%d)", strerror(err), err);
>>
>>       g_slist_foreach(device->attios, attio_disconnected, NULL);
>> +     g_slist_foreach(device->services, disconnect_gatt_service, NULL);
>>
>>       btd_gatt_client_disconnected(device->client_dbus);
>>
>>
>
> --
> Felipe



-- 
Luiz Augusto von Dentz
