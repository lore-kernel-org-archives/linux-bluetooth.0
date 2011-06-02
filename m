Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Add BT_POWER L2CAP socket option.
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Jaikumar Ganesh <jaikumarg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 02 Jun 2011 03:18:00 +0200
In-Reply-To: <20110601222048.GJ2564@joana>
References: <1306199164-28310-1-git-send-email-jaikumar@google.com>
	 <20110530221141.GI2556@joana>
	 <BANLkTi=VyYixDBp33mANPwjiOtCwitTM_A@mail.gmail.com>
	 <20110601222048.GJ2564@joana>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1306977481.7131.10.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Based on discussions on linux-bluetooth and patches submitted by
> > Andrei Emeltchenko.
> > 
> > Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>
> > ---
> >  include/net/bluetooth/bluetooth.h |    8 ++++++++
> >  include/net/bluetooth/hci_core.h  |    2 +-
> >  include/net/bluetooth/l2cap.h     |    1 +
> >  net/bluetooth/hci_conn.c          |    9 ++++++---
> >  net/bluetooth/hci_core.c          |    4 ++--
> >  net/bluetooth/l2cap_core.c        |    5 +++++
> >  net/bluetooth/l2cap_sock.c        |   36 ++++++++++++++++++++++++++++++++++++
> >  7 files changed, 59 insertions(+), 6 deletions(-)
> 
> I applied it, but please next time send a inline patch. Thanks.

actually rather see us clean up all the variables with proper flags
first and then redo this patch cleanly.

Regards

Marcel


