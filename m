Return-Path: <cyrus@holtmann.org>
Message-ID: <50128D31.7090102@linux.intel.com>
Date: Fri, 27 Jul 2012 14:44:33 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v15 10/14] audio: Move HFP HF server to telephony.c
References: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com> <1343292324-959-11-git-send-email-frederic.danis@linux.intel.com> <CANT-zCUWdfDtKpjZFX+NFnaGt0Thp5C7uzpwvXU6qpMtZzOStw@mail.gmail.com>
In-Reply-To: <CANT-zCUWdfDtKpjZFX+NFnaGt0Thp5C7uzpwvXU6qpMtZzOStw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Mikel,

On 27/07/2012 10:50, Mikel Astiz wrote:
>> +       const char *connecting_uuid;
>> +       const char *connecting_path;
>
> I would suggest renaming this to something like
> connecting_transport_path or connecting_transport. Otherwise the code
> is sometimes confusing IMO.
>
> Furthermore, you're actually using gateway_set_media_transport_path()
> in the internal API.

I will rename it to connecting_transport_path.

>> @@ -141,8 +130,19 @@ static void change_state(struct audio_device *dev, gateway_state_t new_state)
>>
>>   void gateway_set_state(struct audio_device *dev, gateway_state_t new_state)
>
> Perhaps not directly related to your patch but... why do we have this
> function anyway as opposed to change_state?
>
> If you compare to headset_set_state, it seems really inconsistent.
>
>>   {
>> +       struct gateway *gw = dev->gateway;
>> +
>>          switch (new_state) {
>>          case GATEWAY_STATE_DISCONNECTED:
>> +               if (gw->msg) {
>> +                       DBusMessage *reply;
>> +
>> +                       reply = btd_error_failed(gw->msg, "Connect failed");
>> +                       g_dbus_send_message(dev->conn, reply);
>> +                       dbus_message_unref(gw->msg);
>> +                       gw->msg = NULL;
>> +               }
>> +
>>                  gateway_close(dev);
>>                  break;
>
> <snip>
>
>> @@ -573,6 +419,11 @@ int gateway_close(struct audio_device *device)
>>                  gw->sco = NULL;
>>          }
>>
>> +       if (gw->tel_dev) {
>> +               telephony_device_disconnect(gw->tel_dev);
>> +               gw->tel_dev = NULL;
>> +       }
>> +
>
> Don't we also need to clear connecting_uuid and specially connecting_path?

Yes, you're right, I should clear them.

Regards

Fred


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

