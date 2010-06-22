Return-Path: <cyrus@holtmann.org>
Message-ID: <4C206E7F.5000604@gmail.com>
Date: Tue, 22 Jun 2010 10:04:15 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: johan.hedberg@gmail.com
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
References: <4C206507.40402@gmail.com> <20100622073841.GA13989@jh-x301> <4C206924.50303@gmail.com> <20100622075833.GA14319@jh-x301>
In-Reply-To: <20100622075833.GA14319@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/22/2010 09:58 AM, Johan Hedberg wrote:
>> # hcidump -XV
> <snip>
>> < ACL data: handle 42 flags 0x02 dlen 11
>>     L2CAP(d): cid 0x0041 len 7 [psm 3]
>>       RFCOMM(d): UIH: cr 0 dlci 18 pf 0 ilen 3 fcs 0x14
>>         OBEX: Put rsp(f): status 403 len 3
> 
> So obexd is responding with "forbidden" to the client.
> Possible reasons:
> 
> * obexd doesn't have write access to the directory it's trying to
>   write to
> 
> * You don't have an agent registered for obexd that could accept
>   the request or you're not running obexd in the auto-accept mode
>   (the -a switch).

Yeah, -a solved the problem. What does it mean to have an agent
registered? What is agent?

Thanks.
