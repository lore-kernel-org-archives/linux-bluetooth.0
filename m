Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 19 Mar 2012 15:55:45 +0100
Subject: RE: [PATCH obexd v0 05/11] client: transfer api merges put and get
Message-ID: <66BD268F973E3544A665E5F503FB38B71AE959AEC1@DC01.bmw-carit.intra>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1331559165-28367-6-git-send-email-mikel.astiz.oss@gmail.com>
 <CABBYNZKKWhEXvULPUpTp6bRPfUV+QeX2nVZbdNJVPFFL6mSPvw@mail.gmail.com>
In-Reply-To: <CABBYNZKKWhEXvULPUpTp6bRPfUV+QeX2nVZbdNJVPFFL6mSPvw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >
> > A new enum type is used to distinguish put and get transfers.
> >
> > This is more convenient since it is done when registering the
> > transfer, and not when it is actually started. The main benefits
> would be:
> >    - Some actions can be taken during creation, such as opening
> files.
> >    - session.c gets simplified.
> >    - The size of a put transfer can be exposed in D-Bus, while
> queued.
> >    - The type of transfer (put or get) can be exposed in D-Bus.
> >
> > None of these D-Bus changes are included in this patch.
> 
> In this case I would prefer register_put/register_get instead of yet
> another parameter and a enum with 2 values.
> 

The main problem with this is that, when you want both file-based and memory-based transfers (see patch v0 07/11), you would have 4 possible combinations.

Another (less relevant) reason is that some client code could be interested in checking this field. For example the agent needs to know that currently.

I would even propose we make this field public in D-Bus in the future, so it would be weird that you have less information in the internal api.

Cheers,
Mikel

