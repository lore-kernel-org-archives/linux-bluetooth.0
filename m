Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=jnPSWAiYWWE6Z_oPswA-uXSOWWMfZKfcfgegH@mail.gmail.com>
References: <AANLkTi=jnPSWAiYWWE6Z_oPswA-uXSOWWMfZKfcfgegH@mail.gmail.com>
Date: Tue, 19 Oct 2010 11:31:33 +0300
Message-ID: <AANLkTikC6JVYwonDOPLgzsDWOD1cjiZ8zOc78TRZZZwc@mail.gmail.com>
Subject: Re: AVRCP 1.4 : Future on Target Role
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Shivendra Agrawal <ag.shivendra@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 19, 2010 at 9:16 AM, Shivendra Agrawal
<ag.shivendra@gmail.com> wrote:
> Hi All,
>
> I have been looking at AVRCP 1.4 in BlueZ and intending to
> enhance/develop this profile for the target role. I have been
> following the discussion initiated by Sander van Grieken earlier last
> month, and as I understand, they are premitive and has scope for
> further enhancements.

Joao Paulo also did some work in this area using MPRIS, I guess he
even publish his tree somewhere.

> In the current BlueZ implementation, control-api.txt mentions few
> methods e.g. SendVendoeDependent, ChangePlayback..., that are not
> referred/implemented in the code, or I may be unable to find at right
> place.
> Further, there are some more AVRCP 1.4 TG specific Notify and Browsing
> commands that can be added.

I would suggest you to take a look at media-api.txt, this is what we
area planning to use for streams and we should probably add support
for metadata and browsing (those 2 seems to be the most asked features
from avrcp nowadays). Actually metadata seems to fit nicely there, we
just need another interface to receive stream metadata, now browsing
is probably not so easy.

> I am willing to define some preliminary interface APIs for Target
> Media Applications to register itself with BlueZ, and would come back
> with some idea proposal for your suggestions on improvements.

If media players all agree on using MPRIS than we probably don't need
to have them registering to us, in the other hand Im not sure if MPRIS
API do cover everything in terms of avrcp, maybe you can figure this
out.

> I am keen to receive your feedback with some ideas and thoughts to put
> my effort in right direction.
>
> Question:
> Is anyone working on AVRCP 1.4 Target role profile development?

Joao Paulo (http://jprvita.wordpress.com/2010/07/22/avrcp-metadata/)
