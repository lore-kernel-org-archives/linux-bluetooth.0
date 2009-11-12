Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <837446.30282.qm@web111403.mail.gq1.yahoo.com>
References: <837446.30282.qm@web111403.mail.gq1.yahoo.com>
Date: Thu, 12 Nov 2009 15:06:43 -0700
Message-ID: <d89ddf300911121406r10097d55s733c32cb2d9f91ca@mail.gmail.com>
Subject: Re: Simultaneous outgoing audio streams
From: Brad Midgley <bmidgley@gmail.com>
To: Mark Stanovich <stanmj@yahoo.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mark

> Looking at the output again, I get something different, with a sco_bind: Address already in use error.  I guess this indicates that there can be only one SCO connection at a time?

>From memory, it seems this was a usb resource allocation issue. I
don't remember all the specifics at the moment, only that the
alternate setting of the isochronous interface needed to be adjusted
dynamically but we didn't have the right hook to do it.

-- 
Brad Midgley
