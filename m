Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix audio.conf parsing bug - sink and source were
 transposed.
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Nick Pelly <npelly@google.com>, linux-bluetooth@vger.kernel.org,
	Jaikumar Ganesh <jaikumar@google.com>
In-Reply-To: <1250636912.12900.111.camel@localhost.localdomain>
References: <1250634769-12220-1-git-send-email-npelly@google.com>
	 <35c90d960908181601x5d31192l459ce5ccdff84b8d@mail.gmail.com>
	 <1250636912.12900.111.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 22 Aug 2009 13:06:45 -0700
Message-Id: <1250971605.2950.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > Jaikumar just gave me the heads up that this is by design.
> > 
> > Enable=Sink means that bluetoothd offers the Sink interface for remote
> > devices - and that we are a source.
> > Enable=Source means that bluetoothd offers the Source interface for
> > remote devices - and that we are a sink.
> > 
> > I'd say its counter-intuitive, but we can live with it.
> 
> Comments in the code could fix that?

I prefer that we add comments in the code and the configuration file.

Nick, please send a patch that adds these comments.

Regards

Marcel


