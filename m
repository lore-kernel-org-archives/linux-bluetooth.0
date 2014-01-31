Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140131075447.GB18867@aemeltch-MOBL1>
References: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
	<1391123008-26767-4-git-send-email-luiz.dentz@gmail.com>
	<20140131075447.GB18867@aemeltch-MOBL1>
Date: Fri, 31 Jan 2014 09:14:41 -0800
Message-ID: <CABBYNZKQEyvtfOpsdypLHenORsOGDvNEe+JS5=BEooiPu4JXOA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] audio/AVRCP: Fix coding style
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jan 30, 2014 at 11:55 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Thu, Jan 30, 2014 at 03:03:28PM -0800, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  profiles/audio/avrcp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index ac861d2..4521bc4 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -2161,7 +2161,7 @@ static struct media_item *parse_media_folder(struct avrcp *session,
>>               name[namelen] = '\0';
>>       }
>>
>> -     item =  media_player_create_folder(mp, name, type, uid);
>> +     item = media_player_create_folder(mp, name, type, uid);
>
> what is the point creating this patch instead of merging with previous one
> which introduced this style issue?

Just a honest mistake, will fix it.


-- 
Luiz Augusto von Dentz
