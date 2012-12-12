Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Dec 2012 20:55:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/11] obexd: Port bluetooth plugin to use external
 profile support
Message-ID: <20121212185513.GA29962@x220.P-661HNU-F1>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
 <20121212120236.GA11264@x220.ger.corp.intel.com>
 <CANT-zCWrF=xz-ud=tKbds9Fag5uH+ryLL3ZiQG=APqcZgEq0ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANT-zCWrF=xz-ud=tKbds9Fag5uH+ryLL3ZiQG=APqcZgEq0ug@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Dec 12, 2012, Mikel Astiz wrote:
> I'm a bit confused with these recent changes. I haven't been following
> this closely so I guess I'm missing the Big Plan but let me start with
> the basics: both bluetoothd and obexd repositories were merged but I
> believe both daemons are still going to be separate daemons, is this
> correct?
> 
> If yes, it makes sense that obexd makes use of the "external profile"
> infrastructure.
> 
> But in that case, why would we add any obex-specific code into
> bluetoothd? My understanding was that, if a profile is implemented as
> an external profile, the bluetoothd core would not be aware of it.

No, bluetoothd still takes care of SDP record registration,
server/client socket handling, authorization, etc. Some external
profiles (like HFP implemented through oFono) also take part in the
Device.Connect connection procedure (this is particularly important for
HFP since it needs to be the first of the audio profiles to be
connected).

>From the L2CAP/RFCOMM connection establishment onwards the external
profile takes over though through the NewConnection method.

Johan
