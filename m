Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+3_KA4Lg2jJ9CJfUNv0jG-n2S5J__SNOMxJenOGeL+GQ@mail.gmail.com>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
 <1357935934-20033-2-git-send-email-jprvita@openbossa.org> <CABBYNZ+3_KA4Lg2jJ9CJfUNv0jG-n2S5J__SNOMxJenOGeL+GQ@mail.gmail.com>
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Date: Mon, 14 Jan 2013 11:05:51 -0300
Message-ID: <CAAngNMZDdYyNZ4F+3o6sG8rJC=PBCXyFKufMmY_Ud2k8xd3=gw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/11] transport: Initialize the "Volume" property
 with 50%
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jan 13, 2013 at 12:22 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Joao,
>
> On Fri, Jan 11, 2013 at 10:25 PM, João Paulo Rechi Vita
> <jprvita@openbossa.org> wrote:
>> ---
>>  profiles/audio/transport.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
>> index a4370a5..6ffa98a 100644
>> --- a/profiles/audio/transport.c
>> +++ b/profiles/audio/transport.c
>> @@ -787,7 +787,7 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
>>                 struct a2dp_transport *a2dp;
>>
>>                 a2dp = g_new0(struct a2dp_transport, 1);
>> -               a2dp->volume = -1;
>> +               a2dp->volume = 63;
>>
>>                 transport->resume = resume_a2dp;
>>                 transport->suspend = suspend_a2dp;
>> --
>> 1.7.11.7
>
> Does the spec say anything regarding this? Actually it seems this
> value must be set by PA if it does support volume notification, which
> means a new version of PA, then it should set the value when the card
> is initialized, otherwise if the endpoint doesn't set a value it
> should remain -1/not available. If volume is not set by the endpoint
> we should either return and error upon register notification or return
> maximum volume always and refuse to SetAbsoluteVolume, my guess is
> that the latter is better for IOP reasons since the remote device may
> register to volume while the endpoint is setting up the transport so
> the volume may be set latter.
>
>

I agree the right value will come from PA. The problem is that the
org.bluez.MediaTransport.Volume property doesn't exist when volume is
< 0 or > 127 and PA will not be able to inform the correct volume
value. Should we simply remove volume_exists(), or do you have any
other suggestion?

--
João Paulo Rechi Vita
Openbossa Labs - INdT
