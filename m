Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2a9506371001211320r6dc7958h5b0040cec6f79e4b@mail.gmail.com>
References: <1264105871-27322-1-git-send-email-padovan@profusion.mobi>
	 <1264105871-27322-2-git-send-email-padovan@profusion.mobi>
	 <2a9506371001211320r6dc7958h5b0040cec6f79e4b@mail.gmail.com>
Date: Thu, 21 Jan 2010 19:25:19 -0200
Message-ID: <fbf08281001211325g33b2828cve6dcd9201d83f558@mail.gmail.com>
Subject: Re: [PATCH 2/2] Implement HandsfreeGateway Interface
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, ofono@ofono.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jan 21, 2010 at 7:20 PM, Vinicius Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Gustavo,
>
> On Thu, Jan 21, 2010 at 5:31 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
>> +       gw->sco = chan;
>> +       g_io_channel_ref(chan);
>> +
>
> You must have forgotten to change this.
>
>> @@ -307,17 +565,15 @@ struct gateway *gateway_init(struct audio_device *dev)
>>  {
>>        struct gateway *gw;
>>
>> +       gw = g_new0(struct gateway, 1);
>> +
>>        if (!g_dbus_register_interface(dev->conn, dev->path,
>>                                        AUDIO_GATEWAY_INTERFACE,
>>                                        gateway_methods, gateway_signals,
>>                                        NULL, dev, NULL))
>>                return NULL;
>>
>
> Seems like gw is leaking if registration fails. Move it down a little, perhaps?

Sounds good.  Thanks. :)

>
>> -       debug("in gateway_init, dev is %p", dev);
>> -       gw = g_new0(struct gateway, 1);
>> -       gw->state = GATEWAY_STATE_DISCONNECTED;
>>        return gw;
>> -
>>  }
>>
>
>
> Cheers,
> --
> Vinicius Gomes
> INdT - Instituto Nokia de Tecnologia
>



-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
