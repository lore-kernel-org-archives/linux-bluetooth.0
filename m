Return-Path: <lcapitulino@conectiva.com.br>
Message-ID: <42B1E63F.204@conectiva.com.br>
Date: Thu, 16 Jun 2005 17:51:11 -0300
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [RESEND] - Fixes rfcomm program error codes.
References: <42B1DA59.6040608@conectiva.com.br> <1118957041.8980.101.camel@pegasus>
In-Reply-To: <1118957041.8980.101.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Marcel Holtmann wrote:
> Hi Luiz,
> 
> 
>>I sent this patch some days ago, but I saw that my e-mail client
>>took the bluez-users address. Hopes to not annoy you sending it
>>again (to the right place now).
>>
>>rfcomm program does not return proper error codes to the environment,
>>this makes hard to use it from a shell script or from another program.
>>
>>Here goes a patch to fix it. I didn't have much time to test it, so
>>any feedback is welcome.
>>
>>- Changes functions to return -1 on error and 0 on success
>>- Adds missing error checks
>>- Adds missing error messages
>>- Fixes rfcomm exit() return codes
> 
> 
> I don't see the advantages from changing "exit(1)" into "return -1".
> This doesn't fix program error codes.

 Sure, but actually, the functions are returning -1, while main()
checks this return value and does return 'exit(1)' on error. So, this
patch fixes the error codes.

 I guess you're speaking about some changes from 'exit(1)' to 'return -1'
I've made. I did that change, as I changed some 'return -errno' or added
proper return value to void functions.

 I saw that most programs (but not all) in the utils package calls exit(1)
directly in the functions when an error happens. IMHO, making functions
return -1 (instead of aborting directly) is pretty better because: 1) system
calls and libc follows that standard; 2) it's easier to copy and paste functions
in other programs; and 3) your program has only one exit point (in main()).

But of course, maybe it's not an issue, and if you wants to, I can change it to
exit in functions directly.

Thank you for reveiwing my patches,
 
-- 
Luiz Fernando N. Capitulino
