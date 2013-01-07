Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <39D5295DD81346F9A6FC2AFB8D19919F@sisodomain.com>
References: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
	<20130107131215.GC914@pzkagis.cz>
	<39D5295DD81346F9A6FC2AFB8D19919F@sisodomain.com>
Date: Mon, 7 Jan 2013 22:00:11 +0200
Message-ID: <CABBYNZ+0H3t-jwbp_-iUeFw2NOqXuWmwBiw8xjqP5bx6D7gomQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] audio: Replace g_hash_table_contains() with g_hash_table_lookup()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: Ludek Finstrle <luf@pzkagis.cz>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Jan 7, 2013 at 3:52 PM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> Hi Ludek,
>
> --------------------------------------------------
> From: "Ludek Finstrle" <luf@pzkagis.cz>
> Sent: Monday, January 07, 2013 6:42 PM
> To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
> Cc: <linux-bluetooth@vger.kernel.org>
> Subject: Re: [PATCH 1/2] audio: Replace g_hash_table_contains() with
> g_hash_table_lookup()
>
>
>> Hello,
>>
>> Mon, Jan 07, 2013 at 06:03:52PM +0530, Jaganath Kanakkassery napsal(a):
>>>
>>> g_hash_table_contains() is supported only from GLib 2.32. If BlueZ has to
>>> build against GLib 2.28 this patch replaces g_hash_table_contains() to
>>> g_hash_table_lookup()
>>> ---
>>>  profiles/audio/player.c |    7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
>>> index 8748893..4198bdb 100644
>>> --- a/profiles/audio/player.c
>>> +++ b/profiles/audio/player.c
>>> @@ -172,8 +172,13 @@ static gboolean get_status(const GDBusPropertyTable
>>> *property,
>>>  static gboolean setting_exists(const GDBusPropertyTable *property, void
>>> *data)
>>>  {
>>>  struct media_player *mp = data;
>>> + const char *value;
>>> +
>>> + value = g_hash_table_lookup(mp->settings, property->name);
>>> + if (value == NULL)
>>> + return FALSE;
>>>
>>> - return g_hash_table_contains(mp->settings, property->name);
>>> + return TRUE;
>>>  }
>>
>>
>> Doesn't
>>
>> return g_hash_table_lookup(mp->settings, property->name) != NULL;
>>
>> do the same? Maybe it's againist some code style but looks better
>> than several lines.
>
>
> I think
> return g_hash_table_lookup(mp->settings, property->name) ? TRUE : FALSE;
> would be better?

Shorter form is  != NULL, so lets go with it, still haven't figure out
why we didn't bring back glib-compat for such functions, when we
finally upgrade it will take much more time to revert this one by one.


--
Luiz Augusto von Dentz
