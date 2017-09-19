Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1a507085-2113-dd3b-3bf3-07c55d359a9b@jp.fujitsu.com>
References: <20170918092325.32406-1-luiz.dentz@gmail.com> <1a507085-2113-dd3b-3bf3-07c55d359a9b@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Sep 2017 10:08:35 +0300
Message-ID: <CABBYNZJ05njFZbt7JQ6_P0Cz-sEK2HbUN0PEsRU8yYUEmx-jdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools: Only add unique entries to readline history
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Tue, Sep 19, 2017 at 5:14 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Luiz,
>
> On 09/18/2017 06:23 PM, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Don't add duplicate commands to historym this is similar to what
>> HISTCONTROL=ignoredups does.
>> ---
>>  client/main.c            | 3 ++-
>>  tools/bluetooth-player.c | 4 +++-
>>  tools/btmgmt.c           | 3 ++-
>>  tools/obex-client-tool.c | 3 ++-
>>  tools/obexctl.c          | 3 ++-
>>  5 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/client/main.c b/client/main.c
>> index 2cb449fd5..282e84003 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -2644,7 +2644,8 @@ static void rl_handler(char *input)
>>       if (!rl_release_prompt(input))
>>               goto done;
>>
>> -     add_history(input);
>> +     if (history_search(input, -1))
>> +             add_history(input);
>>
>
> I think it is better to add g_strstrip(), since this patch adds a
> command typed all characters to history and then adds the complemented
> command to history when it have white-space.

Yep, but as a separate change, this part of handling should really go
into a common code so we don't have to keep duplicating this on every
tool.

>>       cmd = strtok_r(input, " ", &arg);
>>       if (!cmd)
>> diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
>> index 9e199970d..c95b7497f 100644
>> --- a/tools/bluetooth-player.c
>> +++ b/tools/bluetooth-player.c
>> @@ -1086,7 +1086,9 @@ static void rl_handler(char *input)
>>               goto done;
>>
>>       g_strstrip(input);
>> -     add_history(input);
>> +
>> +     if (history_search(input, -1))
>> +             add_history(input);
>>
>>       argv = g_strsplit(input, " ", -1);
>>       if (argv == NULL)
>> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
>> index e7ea69937..e454d864d 100644
>> --- a/tools/btmgmt.c
>> +++ b/tools/btmgmt.c
>> @@ -4664,7 +4664,8 @@ static void rl_handler(char *input)
>>       if (prompt_input(input))
>>               goto done;
>>
>> -     add_history(input);
>> +     if (history_search(input, -1))
>> +             add_history(input);
>>
>>       if (wordexp(input, &w, WRDE_NOCMD))
>>               goto done;
>> diff --git a/tools/obex-client-tool.c b/tools/obex-client-tool.c
>> index d0ba8a651..d74ac77a1 100644
>> --- a/tools/obex-client-tool.c
>> +++ b/tools/obex-client-tool.c
>> @@ -242,7 +242,8 @@ static void parse_line(char *line_read)
>>               return;
>>       }
>>
>> -     add_history(line_read);
>> +     if (history_search(input, -1))
>> +             add_history(input);
>
> line_read is correct.

Good catch, will fix it.

>>
>>       g_shell_parse_argv(line_read, &argcp, &argvp, NULL);
>>
>> diff --git a/tools/obexctl.c b/tools/obexctl.c
>> index 46943d682..ece50f682 100644
>> --- a/tools/obexctl.c
>> +++ b/tools/obexctl.c
>> @@ -2081,7 +2081,8 @@ static void rl_handler(char *input)
>>       if (!strlen(input))
>>               goto done;
>>
>> -     add_history(input);
>> +     if (history_search(input, -1))
>> +             add_history(input);
>>
>>       if (wordexp(input, &w, WRDE_NOCMD))
>>               goto done;
>>
>
>
> Regards,
> Eramoto
>



-- 
Luiz Augusto von Dentz
