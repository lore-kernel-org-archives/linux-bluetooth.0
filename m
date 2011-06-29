Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=VFT++3BN9KumrXczvCmzuaJTb9w@mail.gmail.com>
References: <1309263917-14931-1-git-send-email-sancane@gmail.com>
	<BANLkTi=VFT++3BN9KumrXczvCmzuaJTb9w@mail.gmail.com>
Date: Wed, 29 Jun 2011 15:01:48 +0200
Message-ID: <BANLkTim5AsPrzKe3BE7w+EeuMt_GwifwkQ@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

(cut)
>
>> +
>> +                       This callback gets called when a measure has been
>> +                       scanned in the thermometer. The Time entry in the dict
>> +                       will be only present if the device supports storing of
>> +                       data. The time value is expressed in seconds since epoch.
>> +                       The value represented is (mantissa) x (10**exponent)
>> +                       See foot note for special values when treating with
>> +                       health devices.
>
> IIRC, the "Type" value is also optional.
>

Sorry, I didn't see this comment before.
You are right, there are two ways to notify the type of the
measurements. In a non-static fashion the Temperature Characteristic
will be used instead of adding this information with the measure at
notification time. On the other hands, the Temperature Characteristic
won't be used If the thermometer can take measurements from different
places. In this case the type information will be added when the
natification occurs. Only one of both methods can be used but not both
at the same time.

The first version of the API included the type as property when static
values were used. At last, we decided get ride of this property to
always include it in the callback. It is just an idea take from Luiz
Augusto's comments to simplify the API. You can see the old API
discussion in previous emails if you feel like it.

Best regards.
