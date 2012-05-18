Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120518160634.GA8380@x220.P-661HNU-F1>
References: <1337356807-7199-1-git-send-email-luiz.dentz@gmail.com>
	<1337356807-7199-2-git-send-email-luiz.dentz@gmail.com>
	<20120518160634.GA8380@x220.P-661HNU-F1>
Date: Fri, 18 May 2012 19:07:57 +0300
Message-ID: <CABBYNZJfwZe5m+LrmjUzMVJjHRCCO6riVvk1gCOFGKUhBxvYBg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] AVRCP: Subscribe for VolumeChanged Notification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 18, 2012 at 7:06 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Fri, May 18, 2012, Luiz Augusto von Dentz wrote:
>> +             DBG("1");
>> +
>> +             if (sdp_get_profile_descs(rec, &list) < 0)
>> +                     return;
>> +
>> +             desc = list->data;
>> +
>> +             DBG("2");
>> +
>> +             if (desc && desc->version >= 0x0104) {
>> +                     DBG("3");
>> +                     register_volume_notification(player);
>> +             }
>
> The "1", "2" and "3" logs should probably be removed or at least changed
> to something more meaningful.

Opps


-- 
Luiz Augusto von Dentz
