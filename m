Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH BlueZ 4/5] client: Display command even with no description
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130619090850.GA4161@x220>
Date: Wed, 19 Jun 2013 12:31:42 +0200
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Message-Id: <1619E2FF-4B8E-4842-A32F-F99823D29B54@holtmann.org>
References: <1371586427-7909-1-git-send-email-lucas.demarchi@profusion.mobi> <1371586427-7909-4-git-send-email-lucas.demarchi@profusion.mobi> <22954997-7A12-45B3-BA58-13F02AFE3184@holtmann.org> <20130619090850.GA4161@x220>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> Having no description doesn't mean it's not an available command. So add
>>> command to the output of "help" command, even if it has no description.
>>> ---
>>> client/main.c | 5 ++---
>>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/client/main.c b/client/main.c
>>> index b0a66d8..54af807 100644
>>> --- a/client/main.c
>>> +++ b/client/main.c
>>> @@ -1182,10 +1182,9 @@ static void rl_handler(char *input)
>>> 	printf("Available commands:\n");
>>> 
>>> 	for (i = 0; cmd_table[i].cmd; i++) {
>>> -		if (cmd_table[i].desc)
>>> -			printf("\t%s %s\t%s\n", cmd_table[i].cmd,
>>> +		printf("\t%s %s\t%s\n", cmd_table[i].cmd,
>>> 						cmd_table[i].arg ? : "    ",
>>> -						cmd_table[i].desc);
>>> +						cmd_table[i].desc ? : "");
>> 
>> 
>> if I remember this correctly, then I was doing it to be able to hide
>> commands from the help output. Mainly commands that are on purpose
>> duplicates.
> 
> So the right fix is to add the missing descriptions then? Lucas, can you
> provide an updated patch that does this?

actually I wanted to hide these commands on purpose.

Regards

Marcel

