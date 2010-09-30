Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100930085136.GC3048@vigoh>
References: <1285836334-7012-1-git-send-email-michalski.raf@gmail.com>
	<20100930085136.GC3048@vigoh>
Date: Thu, 30 Sep 2010 11:15:14 -0400
Message-ID: <AANLkTikra1mdu2t_QdCXjd=DaSJOXtcMQWwJK2hsRZMe@mail.gmail.com>
Subject: Re: [PATCH] Fix handlig for gboolean mce_bt_set field
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Rafal Michalski <michalski.raf@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 30, 2010 at 4:51 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
>> diff --git a/plugins/maemo6.c b/plugins/maemo6.c
>> index c96731d..45d96b8 100644
>> --- a/plugins/maemo6.c
>> +++ b/plugins/maemo6.c
>> @@ -71,7 +71,8 @@ static gboolean mce_signal_callback(DBusConnection *connection,
>>
>>               /* set the adapter according to the mce signal
>>                  and remember the value */
>> -             mce_bt_set = sigvalue & MCE_RADIO_STATE_BLUETOOTH;
>> +             mce_bt_set = (sigvalue & MCE_RADIO_STATE_BLUETOOTH) ==
>> +                                             MCE_RADIO_STATE_BLUETOOTH;
>
> Alternatively you can do
>        mce_bt_set = !!(sigvalue & MCE_RADIO_STATE_BLUETOOTH)

I'm a bit late, but:

mce_bt_set = (sigvalue & MCE_RADIO_STATE_BLUETOOTH) != 0;

would equally work.

PS: yes, I know it's already commited. :). Interestingly, there is
only one more occurrence of this idiom already in bluez code:

input/device.c:	connected = !!g_slist_find_custom(idev->connections, NULL,

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
