Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1619E2FF-4B8E-4842-A32F-F99823D29B54@holtmann.org>
References: <1371586427-7909-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1371586427-7909-4-git-send-email-lucas.demarchi@profusion.mobi>
 <22954997-7A12-45B3-BA58-13F02AFE3184@holtmann.org> <20130619090850.GA4161@x220>
 <1619E2FF-4B8E-4842-A32F-F99823D29B54@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 19 Jun 2013 10:40:52 -0300
Message-ID: <CAMOw1v4r-rYrEt65bnxi0dbm4U_cxHGR6Aa63TdGW8onMxBhDg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] client: Display command even with no description
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 19, 2013 at 7:31 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
>>>> Having no description doesn't mean it's not an available command. So add
>>>> command to the output of "help" command, even if it has no description.
>>>> ---
>>>> client/main.c | 5 ++---
>>>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/client/main.c b/client/main.c
>>>> index b0a66d8..54af807 100644
>>>> --- a/client/main.c
>>>> +++ b/client/main.c
>>>> @@ -1182,10 +1182,9 @@ static void rl_handler(char *input)
>>>>     printf("Available commands:\n");
>>>>
>>>>     for (i = 0; cmd_table[i].cmd; i++) {
>>>> -           if (cmd_table[i].desc)
>>>> -                   printf("\t%s %s\t%s\n", cmd_table[i].cmd,
>>>> +           printf("\t%s %s\t%s\n", cmd_table[i].cmd,
>>>>                                             cmd_table[i].arg ? : "    ",
>>>> -                                           cmd_table[i].desc);
>>>> +                                           cmd_table[i].desc ? : "");
>>>
>>>
>>> if I remember this correctly, then I was doing it to be able to hide
>>> commands from the help output. Mainly commands that are on purpose
>>> duplicates.
>>
>> So the right fix is to add the missing descriptions then? Lucas, can you
>> provide an updated patch that does this?
>
> actually I wanted to hide these commands on purpose.

So you can't pair a device starting from remote using bluetoothctl on
purpose? Or is adding a description to at least "default-agent" ok?

Lucas De Marchi
