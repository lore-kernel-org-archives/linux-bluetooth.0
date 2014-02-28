Return-Path: <cyrus@holtmann.org>
Message-ID: <5310AF70.1000601@gmail.com>
Date: Fri, 28 Feb 2014 09:46:56 -0600
From: Denis Kenzior <denkenz@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 3/8] shared/hfp: Add initial implementiation of processing
 commands
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com> <1393494006-20363-4-git-send-email-marcin.kraglak@tieto.com> <BA9EB144-665E-4A51-81EF-EEEFAB18C822@holtmann.org>
In-Reply-To: <BA9EB144-665E-4A51-81EF-EEEFAB18C822@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

 >> +	if (data[result.offset] == '+')
>> +		return process_extended(hfp, &result);
>> +	else
>> +		return process_basic(hfp, &result);
>
> Please do not do this. I mentioned this before, this basic vs extended is pointless.
>
> Command matching should be either based on commands like “D” or “+BRSF” and not bother trying to treat the + any special. See how src/emulator.c in oFono registers all the handlers.
>

There is a difference in syntax between basic commands and extended 
commands.  HFP only uses two basic commands, namely ATD and ATA so they 
might be simply handled as a special case.  Others are implicit, e.g. 
ATE, ATV, etc.

Regards,
-Denis
