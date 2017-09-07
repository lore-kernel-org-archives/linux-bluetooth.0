Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] gatt-server: Implement NegotiatedMTU property on
 Device1
From: Jonah Petri <jonah@sense.com>
In-Reply-To: <CABBYNZ+hDikse562MN5sJu1y7BONou33EDaXd5a-ZNNvCT=-uA@mail.gmail.com>
Date: Thu, 7 Sep 2017 08:54:18 -0400
Cc: Emil Lenngren <emil.lenngren@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <7209D322-5E80-4507-9C5A-77FD0C53A7D4@sense.com>
References: <9B25967D-16B8-4335-BE03-8FFD02D400FB@sense.com>
 <CAO1O6sdd9KxagrbboW+9gpc+OBmsJo6S6g09imAoNxRv5tyA3Q@mail.gmail.com>
 <CABBYNZLfbhXfEsb=DY-1mzQdiZVmJ9Ka3GjdGiGYgoaqKhkB+A@mail.gmail.com>
 <5234EF82-463D-4521-ABDB-C68132933BD7@sense.com>
 <CABBYNZJ3eJBDCv-ZiVw_0WPRKGyHJzH4hE-gGkHXo+pxhU3cZw@mail.gmail.com>
 <1AE5314A-1E01-43B7-AFA3-4D82DA9ED755@sense.com>
 <CABBYNZ+uD+8+izUrGb+_U1JdgYTCormjftVzmPs9OGRAqT=XxA@mail.gmail.com>
 <1FA6F703-9CED-43FC-8CA0-BD3F1680EED9@sense.com>
 <CABBYNZLjRA5e0JuryigV+9wdMdHvLYUoSZpfJ=_Eh2rhfCiGfA@mail.gmail.com>
 <CAO1O6scnxYL9Jf3ev=+8AdxqXmt1mg2w8cDqARa+v7oBLXop8w@mail.gmail.com>
 <CABBYNZ+hDikse562MN5sJu1y7BONou33EDaXd5a-ZNNvCT=-uA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Sep 7, 2017, at 7:18 AM, Luiz Augusto von Dentz =
<luiz.dentz@gmail.com> wrote:
>=20
>>>=20
>>> So lets fix that and on the plus side you might get even better
>>> transfer speeds since we can bypass D-Bus entirely.

Hi Luiz,

You are totally right, but we're talking past each other here.

I have to conform to an existing app-level protocol, which transfers via =
GATT attributes on LE.  As Emil noted, there are *many* similar =
implementations out there.  Changing the protocol to solve the problem =
just isn't an option.

I'm not debating the merits of CoC.  It seems great!  I wish I could use =
it.  I can't.  All I'm asking is to implement a simple property to get =
the BTLE ATT MTU, so I can talk with my devices.

Jonah


