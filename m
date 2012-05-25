Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5pMVKSeSLbU2Xbg+erLfeZvzzE3WjsCYwK=-t6zEyv8A@mail.gmail.com>
References: <1337865771-11777-1-git-send-email-luiz.dentz@gmail.com>
	<1337865771-11777-4-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v5pMVKSeSLbU2Xbg+erLfeZvzzE3WjsCYwK=-t6zEyv8A@mail.gmail.com>
Date: Fri, 25 May 2012 11:21:13 +0300
Message-ID: <CABBYNZ+MQOG4AAk6ztWZBaF5+iTMzNvJUZetou=r4zq_tKqkaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/6] audio: Fix signature type for transport Volume
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, May 24, 2012 at 7:50 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> On Thu, May 24, 2012 at 10:22 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Signature is now uint16 instead of byte
>> ---
>>  audio/transport.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/audio/transport.c b/audio/transport.c
>> index 4ad8608..6ed5d21 100644
>> --- a/audio/transport.c
>> +++ b/audio/transport.c
>> @@ -1076,5 +1076,5 @@ void media_transport_update_volume(struct media_transport *transport,
>>
>>        emit_property_changed(transport->conn, transport->path,
>>                                MEDIA_TRANSPORT_INTERFACE, "Volume",
>> -                               DBUS_TYPE_BYTE, &transport->volume);
>> +                               DBUS_TYPE_UINT16, &transport->volume);
>
> If you are changing it to uint16_t, why are you saying it's a "fix"?
>
> You should change transport->volume type together with this patch as well.

Its a fix because this was first introduced and byte type, but you are
right about uint16_t should be done in this patch.


-- 
Luiz Augusto von Dentz
