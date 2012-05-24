Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 15:48:46 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 3/8] Bluetooth: Add l2cap_chan->ops->ready()
Message-ID: <20120524184846.GD10754@samus>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <1337821964-4618-3-git-send-email-gustavo@padovan.org>
 <1337821964-4618-4-git-send-email-gustavo@padovan.org>
 <20120524093958.GL24715@aemeltch-MOBL1>
 <20120524102342.GQ24715@aemeltch-MOBL1>
 <CAA37ikZvK=woaW_grv1t6PK0x0d3uz98MmjQL46z9PHPCJA0nA@mail.gmail.com>
 <20120524113018.GR24715@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120524113018.GR24715@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 14:30 Thu 24 May, Andrei Emeltchenko wrote:
> Hi Ulisses,
> 
> On Thu, May 24, 2012 at 08:17:23AM -0300, Ulisses Furquim wrote:
> > >> > +   void                    (*ready) (void *data);
> > >>
> > >> Again, why void *data ?
> > >
> > > I mean here that for fixed channels we do not need this function at this
> > > point since initialization is different.
> > 
> > So? What do you mean? This needs to be generic, I think. It's an
> > abstraction after all.
> 
> Fixed channels do not have configuration phase, they are created
> CONNECTED (at least A2MP).

You are right, but having this abstraction seems useful.

In LE, for example, we (ab)use the CONFIG phase for blocking the channel
while SMP is running (negotiating the encryption of the link), so any 
applications are not able to send data in a lower security level than
what they requested.

> 
> Best regards 
> Andrei Emeltchenko 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
