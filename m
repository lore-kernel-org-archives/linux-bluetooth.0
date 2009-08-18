Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix audio.conf parsing bug - sink and source were
 transposed.
From: Bastien Nocera <hadess@hadess.net>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org,
	Jaikumar Ganesh <jaikumar@google.com>
In-Reply-To: <35c90d960908181601x5d31192l459ce5ccdff84b8d@mail.gmail.com>
References: <1250634769-12220-1-git-send-email-npelly@google.com>
	 <35c90d960908181601x5d31192l459ce5ccdff84b8d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 00:08:32 +0100
Message-Id: <1250636912.12900.111.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-08-18 at 16:01 -0700, Nick Pelly wrote:
> On Tue, Aug 18, 2009 at 3:32 PM, Nick Pelly<npelly@google.com> wrote:
<snip>
> Jaikumar just gave me the heads up that this is by design.
> 
> Enable=Sink means that bluetoothd offers the Sink interface for remote
> devices - and that we are a source.
> Enable=Source means that bluetoothd offers the Source interface for
> remote devices - and that we are a sink.
> 
> I'd say its counter-intuitive, but we can live with it.

Comments in the code could fix that?

