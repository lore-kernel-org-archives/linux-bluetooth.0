Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Nov 2013 11:03:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/6] android/socket: Handle Android events for server
 socket
Message-ID: <20131127090306.GA28690@x220.p-661hnu-f1>
References: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1385474750-18331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20131126154602.GB25005@x220.p-661hnu-f1>
 <20131127080051.GC3149@aemeltch-MOBL1>
 <20131127082128.GA23732@x220.p-661hnu-f1>
 <20131127082942.GD3149@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131127082942.GD3149@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Nov 27, 2013, Andrei Emeltchenko wrote:
> > > I assume this would be primary used to clean up socket structure if
> > > Android decides to stop listen().
> > 
> > Which HAL method would "stop listen()" be done with? I don't see such a
> > method in the HAL (please correct me if I'm wrong though). If there's no
> > such method it's not possible to stop the listening socket, and hence
> > you're just adding dead code here.
> 
> This is listening on socketpair descriptor, the other end was sent to
> Android framework. So we might get some signal or socket close.

You'll need to explain in more detail how this could happen. We should
already have other places looking for the HAL-side going a way (e.g. if
it crashes) and then calling the necessary cleanup functions.

Johan
