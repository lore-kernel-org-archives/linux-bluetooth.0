Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Mar 2015 12:16:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	Stefan Seyfried <stefan.seyfried@googlemail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] core/gatt-database: Fix memory corruption
Message-ID: <20150312101648.GA9353@t440s.lan>
References: <550043CD.7080202@ubnt.com>
 <CABBYNZLW19LcNQerGUa+U0DTn26HR9LpMqi2=RcPHwiFCHbC9g@mail.gmail.com>
 <550052CA.20407@ubnt.com>
 <5500B15B.9090508@message-id.googlemail.com>
 <55014D38.4040506@ubnt.com>
 <CABBYNZKR1O7G0yt-7mM6Q7aQZG3B6=ArXAhZHY5n6wqMrqkFdA@mail.gmail.com>
 <55015449.3040202@ubnt.com>
 <CABBYNZKVUT2Z3L519iR09ZdT-m9dTHugUm2qaYwwJv-ZQ4f6yw@mail.gmail.com>
 <55015D16.5060307@ubnt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55015D16.5060307@ubnt.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

On Thu, Mar 12, 2015, Andrejs Hanins wrote:
> Thanks, works fine also for me now. Am I right, that even though this
> is a quite nasty bug IMO, there will be no new BlueZ release soon, as
> 5.29 was born just yesterday?

We'll likely release 5.30 earlier than planned, maybe end of next week
or something like that. There are several other features that we should
be able to get into it (like the GattProfile1 interface support), so it
wont have to be a pure bug-fix release.

Johan
