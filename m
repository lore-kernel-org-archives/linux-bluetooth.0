Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCWK+feaYDNxiq=urOGFrt+0WFKWmbhMecqe3igioGR1aw@mail.gmail.com>
References: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
	<1372864541-10763-2-git-send-email-luiz.dentz@gmail.com>
	<20130704142829.GA13087@samus.indt.org>
	<CANT-zCWK+feaYDNxiq=urOGFrt+0WFKWmbhMecqe3igioGR1aw@mail.gmail.com>
Date: Mon, 8 Jul 2013 13:00:29 +0300
Message-ID: <CABBYNZK3aNcw1yBzbpkbhVAFdb9e+563XL_9YS2PRx_74gybbA@mail.gmail.com>
Subject: Re: [RFC 01/20] audio/sink: Use service user_data for private data
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Jul 5, 2013 at 9:38 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Hi Vinicius,
>
> On Thu, Jul 4, 2013 at 4:28 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
>> Hi,
>>
>> On 18:15 Wed 03 Jul, Luiz Augusto von Dentz wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> This remove the need of forward declaration of struct sink and prepare
>>> for a complete removal of struct audio_device.
>>> ---
>>>  profiles/audio/avdtp.c  |  2 +-
>>>  profiles/audio/device.c | 54 ++++++++++++++++++++++++++++++-------------------
>>>  profiles/audio/device.h |  3 +--
>>>  profiles/audio/sink.c   | 29 +++++++++++++++-----------
>>>  profiles/audio/sink.h   |  5 +++--
>>>  5 files changed, 55 insertions(+), 38 deletions(-)
>>>
>>
>> [snip]
>>
>>> @@ -171,30 +175,25 @@ static void device_avdtp_cb(struct audio_device *dev, struct avdtp *session,
>>>  }
>>>
>>>  static void device_sink_cb(struct audio_device *dev,
>>> -                             sink_state_t old_state,
>>> -                             sink_state_t new_state,
>>> -                             void *user_data)
>>> +                             btd_service_state_t old_state,
>>> +                             btd_service_state_t new_state)
>>>  {
>>>       struct dev_priv *priv = dev->priv;
>>>
>>> -     if (!dev->sink)
>>> -             return;
>>> -
>>>       priv->sink_state = new_state;
>>>
>>>       switch (new_state) {
>>> -     case SINK_STATE_DISCONNECTED:
>>> +     case BTD_SERVICE_STATE_UNAVAILABLE:
>>> +     case BTD_SERVICE_STATE_DISCONNECTED:
>>>               if (dev->control) {
>>>                       device_remove_control_timer(dev);
>>>                       if (priv->avctp_state != AVCTP_STATE_DISCONNECTED)
>>>                               avrcp_disconnect(dev);
>>>               }
>>>               break;
>>> -     case SINK_STATE_CONNECTING:
>>> -             break;
>>> -     case SINK_STATE_CONNECTED:
>>> -             break;
>>> -     case SINK_STATE_PLAYING:
>>> +     case BTD_SERVICE_STATE_CONNECTING:
>>> +     case BTD_SERVICE_STATE_CONNECTED:
>>> +     case BTD_SERVICE_STATE_DISCONNECTING:
>>>               break;
>>>       }
>>>  }
>>> @@ -222,6 +221,20 @@ static void device_avctp_cb(struct audio_device *dev, avctp_state_t old_state,
>>>       }
>>>  }
>>>
>>> +static void service_cb(struct btd_service *service,
>>> +                                             btd_service_state_t old_state,
>>> +                                             btd_service_state_t new_state,
>>> +                                             void *user_data)
>>> +{
>>> +     struct audio_device *dev = user_data;
>>> +
>>> +     if (dev->btd_dev != btd_service_get_device(service))
>>> +             return;
>>> +
>>> +     if (service == dev->sink)
>>> +             device_sink_cb(dev, old_state, new_state);
>>> +}
>>> +
>>>  struct audio_device *audio_device_register(struct btd_device *device)
>>>  {
>>>       struct audio_device *dev;
>>> @@ -236,8 +249,7 @@ struct audio_device *audio_device_register(struct btd_device *device)
>>>       dev->priv->dc_id = device_add_disconnect_watch(dev->btd_dev,
>>>                                                       disconnect_cb, dev,
>>>                                                       NULL);
>>> -     dev->priv->sink_callback_id = sink_add_state_cb(dev, device_sink_cb,
>>> -                                                                     NULL);
>>> +     dev->priv->service_cb_id = btd_service_add_state_cb(service_cb, dev);
>>
>> I just want to bring up an issue not related to the patch in itself.
>>
>> Wouldn't it be better if the state changed callback were per service? I can
>> see it being used a lot.
>>
>> Or was this point already discussed?
>
> I don't remember this being discussed.
>
> I do however agree with your proposal, there would be several
> interested users of this per-service callback. Perhaps
> btd_service_add_state_cb() can be extended with a pointer than can be
> optionally be NULL to express "any service"?

Yep, I think that is a good idea because I end up with a device list
on policy module to that holds policy private data per device, anyway
we might need a device driver infra similar to adapter driver and we
can probably have info such as class, device id, product id and so on
to probe the right driver, so we could have device/class specific
drivers if needed.
