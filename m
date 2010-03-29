Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 2/2] Emit Adapter.PropertyChanged when UUIDs change
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20100329074539.GA20839@jh-x301>
References: <1269644076-10544-1-git-send-email-francisco.alecrim@openbossa.org>
	 <1269644076-10544-2-git-send-email-francisco.alecrim@openbossa.org>
	 <20100329074539.GA20839@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Mar 2010 01:29:01 -0700
Message-ID: <1269851341.11714.203.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > Emitting Adapter.PropertyChanged signal when UUIDs change. D-Bus message
> > to inform that adapter properties changed.
> > ---
> >  src/adapter.c       |   75 ++++++++++++++++++++++++++++++++++++++++++++------
> >  src/adapter.h       |    1 +
> >  src/sdpd-database.c |    3 ++
> >  3 files changed, 70 insertions(+), 9 deletions(-)
> 
> Thanks for the patches. In principle they look good, but I haven't
> applied them yet due to one thing that looks a bit strange: both the SDP
> server record UUID (0x1000) as well as the public browse group UUID
> (0x1001) always show up in the UUIDs list. I wonder if there'd be any
> clean way to avoid getting them into the list. Marcel, do you have any
> idea about this or is it even a problem that these UUIDs are always in
> the list?

these UUIDs are always in the server, but not in the public browse group
and we skip them on purpose. The only reason why they are always present
is that the specification requires it.

Regards

Marcel


