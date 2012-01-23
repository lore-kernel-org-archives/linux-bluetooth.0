Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Make l2cap_ertm_data_rcv static
Date: Mon, 23 Jan 2012 10:16:29 +0100
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"kanak.gupta@stericsson.com" <kanak.gupta@stericsson.com>, Andrei Emeltchenko
	<andrei.emeltchenko.news@gmail.com>
References: <1327309565-17367-1-git-send-email-szymon.janc@tieto.com> <1327309630.1955.89.camel@aeonflux>
In-Reply-To: <1327309630.1955.89.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201201231016.30030.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Szymon,

Hi,
 
> > It is not used outside of l2cap_core.c. Also l2cap_ertm_data_rcv is
> > only used after it is defined so there is no need for forward declaration.
> > 
> > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > ---
> >  net/bluetooth/l2cap_core.c |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> I assume that you and Andrei agreed here. If not, he needs to speak up.

Yeap, Andrei reworked a2mp patches and is fine with that change now:
http://www.spinics.net/lists/linux-bluetooth/msg20448.html


-- 
BR
Szymon Janc
