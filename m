Return-Path: <cyrus@holtmann.org>
Message-ID: <1356318418.29264.39.camel@aeonflux>
Subject: Re: [PATCH] Fix missing config.h includes
From: Marcel Holtmann <marcel@holtmann.org>
To: Cristian =?ISO-8859-1?Q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 23 Dec 2012 19:06:58 -0800
In-Reply-To: <1356313961.29264.38.camel@aeonflux>
References: <1356309150-22990-1-git-send-email-crrodriguez@opensuse.org>
	 <1356313961.29264.38.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cristian,

> > ---
> >  attrib/att.c                      | 4 ++++
> >  attrib/gattrib.c                  | 4 ++++
> >  attrib/interactive.c              | 5 +++++
> >  attrib/utils.c                    | 4 ++++
> >  btio/btio.c                       | 5 +++++
> >  obexd/plugins/phonebook-tracker.c | 4 ++++
> >  profiles/gatt/manager.c           | 4 ++++
> >  profiles/health/hdp.c             | 4 ++++
> >  profiles/health/mcap.c            | 4 ++++
> >  profiles/sap/sap-u8500.c          | 4 ++++
> >  tools/btiotest.c                  | 5 +++++
> >  tools/obex-client-tool.c          | 4 ++++
> >  unit/test-gobex-apparam.c         | 4 ++++
> >  unit/test-gobex-header.c          | 4 ++++
> >  unit/test-gobex-packet.c          | 4 ++++
> >  unit/test-gobex-transfer.c        | 4 ++++
> >  unit/test-gobex.c                 | 4 ++++
> >  unit/util.c                       | 4 ++++
> >  18 files changed, 75 insertions(+)
> 
> please break this up into one patch per directory and prefix the subject
> line with that directory.

since we are just before the BlueZ 5.0 release and this seems to be a
useful fix, I split it by myself. Next time this is your job.

Regards

Marcel


