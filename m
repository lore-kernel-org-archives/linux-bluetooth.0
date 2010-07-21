Return-Path: <cyrus@holtmann.org>
Message-ID: <4C470F22.7040102@aircable.net>
Date: Wed, 21 Jul 2010 12:15:46 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
References: <4C46324D.5070800@aircable.net>	<20100721101934.GA12188@jh-x301> <AANLkTikcy_R0SOhL52AD372_DTA3c2pUVEY85lh3ZEj3@mail.gmail.com>
In-Reply-To: <AANLkTikcy_R0SOhL52AD372_DTA3c2pUVEY85lh3ZEj3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz,
>> I don't really understand the need for these changes, but admitedly the
>> function does have issues since it first checks for !ctxt->session and
>> then later for ctxt->session even though at that point it's already
>> guaranteed that ctxt->session is not NULL.
>>      
> Yep, I suspect it is something else too, there doesn't seems to be a
> call to bt_cancel_discovery in the last trace sent to the list, but
> the check for ctxt->session there seems buggy, we should always remove
> the context doesn't matter if it is connected or not.
>    
I think the problem is that the watch function is still registered even 
though we no longer have a session... maybe this doesn't make sense, no 
way we have a context and don't have a session.

Still if there's no session the context never gets released.

> @Manuel: Does valgrind give you a nice bracktrace when it bluetoothd segfaults?
>
> Normally I use something like this:
>
>    
>> sudo valgrind --trace-children=yes ./bluetoothd -dn
>>      
Check the other email, I made it by running bluetoothd -ndt (this is a 
feature I commited, which uses instrumentation-functions from gcc, a 
really nice feature).

Manuel

