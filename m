Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1508796837.28409.5.camel@hadess.net>
References: <20171023154814.20607-1-hadess@hadess.net> <20171023154814.20607-3-hadess@hadess.net>
 <CABBYNZLJabUx4LJK-bhMekYx1SNS79U1y0J+7KcSCN6g8X_wYQ@mail.gmail.com> <1508796837.28409.5.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Oct 2017 10:40:07 +0300
Message-ID: <CABBYNZ+MwZiPSxebrc4PrOrWJknnjUYTm97zKNHrR9X865nmCg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] profiles/battery: Remove unused bas.[ch]
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Oct 24, 2017 at 1:13 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Mon, 2017-10-23 at 23:39 +0300, Luiz Augusto von Dentz wrote:
>> Hi Bastian,
>>
>> On Mon, Oct 23, 2017 at 6:48 PM, Bastien Nocera <hadess@hadess.net>
>> wrote:
>> > The Battery Service characteristics are not children of the HoG
>> > characteristics, so there's nothing to consume in the input
>> > profile.
>> > Remove that code which duplicated most of the battery profile
>> > plugin.
>>
>> Id rather not do this, we actually do intend the maintain a small
>> helper library that can be unit tested, what bt_bas lacks is just
>> proper support of bt_gatt_client nothing else. Also for the record
>> this would probably break BfA HoG qualification which requires
>> battery
>> service to be supported as well, Android code does not have any other
>> bas implementation.
>
> That's fine, we can leave this file around. What about the other
> patches?

Id move the code around bt_gatt_client to bt_bas and let it handle the
internal details, the long term plan is to get rid of GAttrib so
perhaps we should start with bas.

-- 
Luiz Augusto von Dentz
