Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EEB342E.7030205@bmw-carit.de>
References: <1323952435-3244-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZJ9QgLPJQoudjRGZfMF5CHV5LaHUNZf8Hcojh5bjMgaTQ@mail.gmail.com>
	<4EEB342E.7030205@bmw-carit.de>
Date: Fri, 16 Dec 2011 15:02:10 +0200
Message-ID: <CABBYNZJCGd9jzFC_JHMcSFZe0zUqRckaYKAw3OtGYgAk2jFW6Q@mail.gmail.com>
Subject: Re: [RFC] media: assertion to check that transport exists
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Dec 16, 2011 at 2:06 PM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
> Hi Luiz,
>
>
> On 12/16/2011 09:43 AM, Luiz Augusto von Dentz wrote:
>>
>> IMO assert on daemon are not that great, it may help while developing but
>> why not run with valgrind and let it crash?
>
>
> I was not that much proposing to add the assertion, but to discuss if that
> assertion should hold or not.
>
> Basically my question is: is it guaranteed that a transport will exist while
> a gateway is connected or playing?

Yes it should exist if media API is being used, while we are
connecting we attempt to create the transport.

> If yes, I think there is a bug somewhere, because those assertions do fail
> sometimes.

Probably, but it should be easier if you debug the state transitions.

> I was specifically asking this regarding the internal state of the daemon,
> but the same question could be formulated for the state exposed in D-Bus.

It should be consistent, I would start by analyzing the logs, there
seems to be at least one place where it call clear_configuration
without being disconnected see media.c:endpoint_reply, that is when
the endpoint stop responding.

-- 
Luiz Augusto von Dentz
