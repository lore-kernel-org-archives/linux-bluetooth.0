Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1AE5314A-1E01-43B7-AFA3-4D82DA9ED755@sense.com>
References: <9B25967D-16B8-4335-BE03-8FFD02D400FB@sense.com>
 <CAO1O6sdd9KxagrbboW+9gpc+OBmsJo6S6g09imAoNxRv5tyA3Q@mail.gmail.com>
 <CABBYNZLfbhXfEsb=DY-1mzQdiZVmJ9Ka3GjdGiGYgoaqKhkB+A@mail.gmail.com>
 <5234EF82-463D-4521-ABDB-C68132933BD7@sense.com> <CABBYNZJ3eJBDCv-ZiVw_0WPRKGyHJzH4hE-gGkHXo+pxhU3cZw@mail.gmail.com>
 <1AE5314A-1E01-43B7-AFA3-4D82DA9ED755@sense.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Sep 2017 22:57:48 +0300
Message-ID: <CABBYNZ+uD+8+izUrGb+_U1JdgYTCormjftVzmPs9OGRAqT=XxA@mail.gmail.com>
Subject: Re: [PATCH v2] gatt-server: Implement NegotiatedMTU property on Device1
To: Jonah Petri <jonah@sense.com>
Cc: Emil Lenngren <emil.lenngren@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonah,

On Wed, Sep 6, 2017 at 6:44 PM, Jonah Petri <jonah@sense.com> wrote:
> Hello Luiz,
>
> Thanks for looking at my proposal.
>
>> On Sep 6, 2017, at 10:14 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.co=
m> wrote:
>>
>> Your implementation is not really LE specific, in fact it will cause
>> the clients to believe they connected over LE if the MTU appears,
>> besides with cross transport pairing and dual mode topology this has
>> to work either way or then we have to disable GATT completely on
>> BR/EDR.
>
> Of course, yes, my previous implementation is not appropriate for this ne=
w API.  There's differences of opinion about what the API should be, and I'=
m proposing a revised API to address feedback from yourself and others.  If=
 there's consensus that my revised API is appropriate, I'll then propose an=
 implementation.
>
>>
>> Also, the AcquireWrite and AcquireNotify should fulfil most of the use
>> cases where GATT is used just as transport to another protocol, is
>> that what you are intending to do?
>
> I'm merely conforming to an existing protocol, which requires me to only =
publish GATT attributes which are length <=3D MTU - 3.  This is because we =
can't depend on Long Read and Long Write support from BTLE clients.  In cas=
es where a larger MTU has been negotiated, I need to take advantage of it, =
for optimal throughput.

Im afraid I don't follow what you are saying about publishing GATT
attributes, the spec doesn't require Long procedures by clients but
that doesn't mean you should omit attributes where their values are
bigger than the MTU or anything like that. Im also not sure why
throughput would be relevant, GATT/ATT is not throughput oriented, it
is a request/response protocol with 30 seconds timeout and on top of
that we have yet another request/response IPC.

>
> I didn't design the protocol, but it's out there in the wild, and I need =
to support it.
>
>>
>> Having an API just for a very specific use case that in the future may
>> actually disappear with OSes adopting L2CAP CoC is not very nice.
>
> We already have several LE-specific APIs (e.g. LEAdvertisingManager), so =
I don't understand this objection.  BTLE GATT will be with us essentially f=
orever.  Also, I've proposed marking this dbus property as experimental, so=
 I don't see the problem with trying it out.  It addresses a real need.
>
> Best,
>
> Jonah



--=20
Luiz Augusto von Dentz
