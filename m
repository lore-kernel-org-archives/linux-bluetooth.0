Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+-a5csWYzZ4YdH1G9ZCrp1KUHB9ayNQYC5=8ks+SzEvQ@mail.gmail.com>
References: <1344528453-27245-1-git-send-email-luf@pzkagis.cz>
	<CABBYNZ+-a5csWYzZ4YdH1G9ZCrp1KUHB9ayNQYC5=8ks+SzEvQ@mail.gmail.com>
Date: Mon, 8 Oct 2012 14:47:13 +0200
Message-ID: <CABBYNZ+uJQvNq25q7eNFzGxU1nb1nRXn57yV_KR5EXvymJo+mg@mail.gmail.com>
Subject: Re: [PATCH obexd] client: Fix pbap_select using absolute path with
 known locations
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ludek Finstrle <luf@pzkagis.cz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ludek,

On Fri, Aug 10, 2012 at 1:28 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Ludek,
>
> On Thu, Aug 9, 2012 at 7:07 PM, Ludek Finstrle <luf@pzkagis.cz> wrote:
>> pbap_select has to use absolute path with known location to support
>> repeatable pbap_select calls. In other way the second call fails.
>> ---
>>  client/pbap.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/client/pbap.c b/client/pbap.c
>> index 48dbac1..d8c39e5 100644
>> --- a/client/pbap.c
>> +++ b/client/pbap.c
>> @@ -232,14 +232,14 @@ static gchar *build_phonebook_path(const char *location, const char *item)
>>
>>         if (!g_ascii_strcasecmp(location, "INT") ||
>>                         !g_ascii_strcasecmp(location, "INTERNAL"))
>> -               path = g_strdup("telecom");
>> +               path = g_strdup("/telecom");
>>         else if (!g_ascii_strncasecmp(location, "SIM", 3)) {
>>                 if (strlen(location) == 3)
>>                         tmp = g_strdup("SIM1");
>>                 else
>>                         tmp = g_ascii_strup(location, 4);
>>
>> -               path = g_build_filename(tmp, "telecom", NULL);
>> +               path = g_build_filename("/", tmp, "telecom", NULL);
>>                 g_free(tmp);
>>         } else
>>                 return NULL;
>> --
>> 1.7.1
>>
>
> Applied, thanks.

This doesn't a regression with some phones e.g. iphone5, the problem
is not really the path as this is handled by obc_session_setpath, but
we should not use absolute in the name as in pull_phonebook.

-- 
Luiz Augusto von Dentz
