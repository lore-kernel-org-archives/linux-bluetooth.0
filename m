Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201201031658.17771.post@hendrik-sattler.de>
References: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com>
	<1325598744-18855-3-git-send-email-luiz.dentz@gmail.com>
	<201201031658.17771.post@hendrik-sattler.de>
Date: Wed, 4 Jan 2012 00:31:13 +0200
Message-ID: <CABBYNZK2upSD5i37vNbV7Fcdp65dsnekVYYqmfR4q_cLVwqp_Q@mail.gmail.com>
Subject: Re: [PATCH obexd 3/4] gobex: automatically use SRM when transport
 type is SOCK_SEQPACKET
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Tue, Jan 3, 2012 at 5:58 PM, Hendrik Sattler <post@hendrik-sattler.de> wrote:
>>
>> So only in case of PUT or GET requests SRM is automatically configured,
>> applications can still enable it manually for other operations by adding
>> the headers like before but it is not recommended.
>>
>> Note that it would be a good practice to indicate SRM support by using
>> value 0x02, but since that should happens during CONNECT command it is
>> not done automatically for requests when acting as a client, server
>> responding to indicate requests will automatically add SRM headers though.
>
> I think you misread the specs here.
>
> SRM is not enabled for "requests" but for sessions and SRM is valid until
> disabled again. This includes _all_ requests and responses, not only GET and
> PUT but the authors of the OBEX spec have a strange way to write things.
> The SRMP headers only affect PUT and PUT, though.

That is what the OBEX spec says, but GOEP 2.0 says otherwise, actually
PUT and GET may also be used without CONNECT and the even the OBEX
spec state both PUT, GET and SETPATH supporting SRM headers.

> Additionally, the spec says:
> "Client devices supporting SRM must issue a Single Response Mode (SRM) header
> [...] during all CONNECT requests [...]".

That is still possible, by adding the headers manually, but
automatically configuration will only be done for PUT/GET because of
the way GOEP 2.0 is using SRM restrict that:

>   "SRM headers shall not be sent in the Connect request or response
>   packets (note, this is to preserve backwards compatibility). SRM shall
>   be enabled through Put and Get operations only."

You can get GOEP 2.0 from bluetooth.org, you might find it interesting
specially the examples are completely different from the ones OBEX
spec has and we have to support them both.

-- 
Luiz Augusto von Dentz
