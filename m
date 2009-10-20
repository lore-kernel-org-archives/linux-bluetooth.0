Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Oct 2009 08:39:10 +0100 (BST)
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: "linux-bluetooth\@vger\.kernel\.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Implements the OBEX server/SyncML client binding for
 syncEvolution (http://syncevolution.org/).
In-Reply-To: <1256023119.9142.19.camel@pohly-mobl1.ikn.intel.com>
References: <1256007499-19250-1-git-send-email-forrest.zhao@intel.com> <1256023119.9142.19.camel@pohly-mobl1.ikn.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1256024351.279827.7068.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 20 Oct 2009, Patrick Ohly wrote:

> > +       if (option_syncevolution == TRUE) {
> > +               services |= OBEX_SYNCEVOLUTION;
> > +               bluetooth_init(OBEX_SYNCEVOLUTION, "OBEX server for"
> > +                               " Syncevolution client", NULL,
> > +                               SYNCEVOLUTION_CHANNEL, TRUE, FALSE, FALSE,
> > +                               NULL);
> > +       }
> > +
>
> Which string is going to appear in the service description (the SDP
> part)? This one here? Mentioning "SyncML" would be useful. So I suggest
> "OBEX server for SyncML, using SyncEvolution". Leave out the
> "SyncEvolution client", because the term client is a) overloaded
> (SyncML/OBEX/D-Bus) and b) SyncEvolution could be both client and server
> in this context (SAN => SyncML client, SyncML message => SyncML server).

see SDP specification, you can provide ServiceName ("SyncML") and
ProviderName ("SyncEvolution") attributes in the service record..

iain


