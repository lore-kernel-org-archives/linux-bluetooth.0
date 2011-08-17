Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ovasik@redhat.com" <ovasik@redhat.com>
Subject: Re: [PATCH 5/8] Added NULL check before dereferencing
References: <op.v0av70tbh52hc0@dhcp-25-209.brq.redhat.com>
 <CABBYNZJ3pUUQOcgRDUH21cMzPigiibQLem4ZViOLZJfFmvLpUQ@mail.gmail.com>
Date: Wed, 17 Aug 2011 10:45:05 +0200
MIME-Version: 1.0
From: "Pavel Raiskup" <praiskup@redhat.com>
Message-ID: <op.v0cnxfarh52hc0@dhcp-25-209.brq.redhat.com>
In-Reply-To: <CABBYNZJ3pUUQOcgRDUH21cMzPigiibQLem4ZViOLZJfFmvLpUQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Tue, Aug 16, 2011 at 12:49 PM, Pavel Raiskup <praiskup@redhat.com>  
> wrote:
>> ---
>>  plugins/hciops.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/plugins/hciops.c b/plugins/hciops.c
>> index ecc0e86..e975eb5 100644
>> --- a/plugins/hciops.c
>> +++ b/plugins/hciops.c
>> @@ -593,7 +593,8 @@ static gboolean init_adapter(int index)
>>        } else {
>>                adapter = manager_find_adapter(&dev->bdaddr);
>>                /* FIXME: manager_find_adapter should return a new ref */
>> -               btd_adapter_ref(adapter);
>> +               if (adapter)
>> +                       btd_adapter_ref(adapter);
>
> Perhaps we should either make manager_find_adapter to return a new ref
> or create a function e.g. manager_get_adapter which does that for us.

actually, I don't have as good experiences (and time now) for such  
improvements.
This patch has not removed "FIXME"! -- it was thought like null deref.  
prevention
patch only.

Pavel
