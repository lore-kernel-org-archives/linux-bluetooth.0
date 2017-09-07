Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1FA6F703-9CED-43FC-8CA0-BD3F1680EED9@sense.com>
References: <9B25967D-16B8-4335-BE03-8FFD02D400FB@sense.com>
 <CAO1O6sdd9KxagrbboW+9gpc+OBmsJo6S6g09imAoNxRv5tyA3Q@mail.gmail.com>
 <CABBYNZLfbhXfEsb=DY-1mzQdiZVmJ9Ka3GjdGiGYgoaqKhkB+A@mail.gmail.com>
 <5234EF82-463D-4521-ABDB-C68132933BD7@sense.com> <CABBYNZJ3eJBDCv-ZiVw_0WPRKGyHJzH4hE-gGkHXo+pxhU3cZw@mail.gmail.com>
 <1AE5314A-1E01-43B7-AFA3-4D82DA9ED755@sense.com> <CABBYNZ+uD+8+izUrGb+_U1JdgYTCormjftVzmPs9OGRAqT=XxA@mail.gmail.com>
 <1FA6F703-9CED-43FC-8CA0-BD3F1680EED9@sense.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 Sep 2017 13:22:02 +0300
Message-ID: <CABBYNZLjRA5e0JuryigV+9wdMdHvLYUoSZpfJ=_Eh2rhfCiGfA@mail.gmail.com>
Subject: Re: [PATCH v2] gatt-server: Implement NegotiatedMTU property on Device1
To: Jonah Petri <jonah@sense.com>
Cc: Emil Lenngren <emil.lenngren@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonah,

On Thu, Sep 7, 2017 at 3:09 AM, Jonah Petri <jonah@sense.com> wrote:
> Hi Luiz,
>
>> On Sep 6, 2017, at 3:57 PM, Luiz Augusto von Dentz <luiz.dentz@gmail.com=
> wrote:
>>
>>>>
>>>> Also, the AcquireWrite and AcquireNotify should fulfil most of the use
>>>> cases where GATT is used just as transport to another protocol, is
>>>> that what you are intending to do?
>>>
>>> I'm merely conforming to an existing protocol, which requires me to onl=
y publish GATT attributes which are length <=3D MTU - 3.  This is because w=
e can't depend on Long Read and Long Write support from BTLE clients.  In c=
ases where a larger MTU has been negotiated, I need to take advantage of it=
, for optimal throughput.
>>
>> Im afraid I don't follow what you are saying about publishing GATT
>> attributes, the spec doesn't require Long procedures by clients but
>> that doesn't mean you should omit attributes where their values are
>> bigger than the MTU or anything like that. Im also not sure why
>> throughput would be relevant, GATT/ATT is not throughput oriented, it
>> is a request/response protocol with 30 seconds timeout and on top of
>> that we have yet another request/response IPC.
>
> The protocol I=E2=80=99m implementing is a fairly typical =E2=80=98uart-o=
n-btle=E2=80=99 protocol, of the sort supported by many BT vendors, especia=
lly for embedded MCUs.  Reads of GATT attributes above the MTU - 3 threshol=
d are truncated in the client=E2=80=99s bt stack, but the clients typically=
 don=E2=80=99t realize it, so they get corrupted data.  However, for client=
s which support a larger MTU, the transfer speeds can be much faster, as th=
e MTU is larger.  (yes, we=E2=80=99re still talking about a few kb/sec, but=
 4x faster is 4x faster!)

I will have to repeat this over and over, there are better solutions
to this than GATT, what we are seeing here is perhaps the lack of
support in Android. After these many years of L2CAP CoC being around
it really beats me why no vendor took the task to just implement it
and contributed to Android instead of working around it via GATT/ATT
and then blaming the peripheral stack for the lack of serial over
GATT/ATT. Not only this would bring proper serial support but things
like IPSP, Object Transfer, and other profiles that do use L2CAP CoC.

> Of course, you=E2=80=99re right that BTLE isn=E2=80=99t exactly the right=
 way to do this.  You don=E2=80=99t need to convince me of this.  But I do =
have a need for getting the MTU, to implement the protocol without corrupti=
ng the data.  Most people implementing the server half of these protocols l=
ike this will have the same need.
>
> AcquireWrite and AcquireRead are not useful to me, as I=E2=80=99m impleme=
nting a gatt server, and those interfaces are marked as =E2=80=98Client Onl=
y=E2=80=99.

So lets fix that and on the plus side you might get even better
transfer speeds since we can bypass D-Bus entirely.

--=20
Luiz Augusto von Dentz
