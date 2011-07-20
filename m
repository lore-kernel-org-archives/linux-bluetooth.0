Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLG9E46Ls1Rtj76OKNb1bFnPvM89Ru3EtXZsV0A+sffGQ@mail.gmail.com>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZLG9E46Ls1Rtj76OKNb1bFnPvM89Ru3EtXZsV0A+sffGQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 20 Jul 2011 09:55:04 -0300
Message-ID: <CAMOw1v6pqzZHum1-1_SzUWNgsn4C6joYSBDghB_cLe7wwCRbFQ@mail.gmail.com>
Subject: Re: [RFC 00/19] Implement AVRCP 1.3 profile - TG role
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On Wed, Jul 20, 2011 at 5:21 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Lucas,
>
> On Tue, Jul 19, 2011 at 10:49 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
> > This series implement all the mandatory and some optional features in AVRCP 1.3
> > profile, target role.
> >
> > It passed all the related PTS tests and it's slightly tested with a Sony
> > MEX-BT2900 car kit.
> >
> > Current limitation:
> >  * It does not support message continuation in case the metadata
> >   doesn't fit one AV/C packet.
> >  * The D-Bus API doesn't use an agent. Thus it's possible that two applications
> >   screw up the data passed to the control interface. I made this on purpose,
> >   since it allows me to easily test the interface. Future versions shall
> >   remove this limitation.
>
> I don't think it is a good idea to introduce a new API knowing its
> limitation, also in some systems we can have different players e.g.
> video player and music player and iirc some pdus can address those
> players separately. So if you really want this for testing purpose I
> would suggest using another interface which should be disabled by
> default, this way applications know it is unstable and we can
> experiment with it.

What I tried to say is that the interface is as is because it's still
for testing. I'm not intending to upstream it without the agent.

> > I preferred the API written on doc/control-api.txt rather than the past tentatives
> > of using mpris. I'm not sure it's worth supporting it, but I'd like to hear
> > opinions. Considering both approaches need the client to be modified in
> > order to support the agent, maybe using mpris would just be too much hassle.
>
> I think we might need an agent API anyway, since MPRIS players might
> be siting in the session bus so bluetoothd cannot really connect to
> them directly, in the other hand there is nothing preventing someone
> to write an agent that uses MPRIS to talk to players.

In that case, the agent could perfectly talk to our D-Bus interface
and use MPRIS to talk to players. Or use MPRIS on both ends.
