Return-Path: <cyrus@holtmann.org>
From: Sander van Grieken <sander@outrightsolutions.nl>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: AVRCP future
Date: Thu, 2 Sep 2010 10:20:50 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201009011603.02153.sander@outrightsolutions.nl> <20100901185729.GB30041@jh-x301>
In-Reply-To: <20100901185729.GB30041@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201009021020.50162.sander@outrightsolutions.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, 

Thanks for your feedback.

On Wednesday 01 September 2010 20:57:29 Johan Hedberg wrote:
> Hi Sander,
> 
> On Wed, Sep 01, 2010, Sander van Grieken wrote:
> > - Is anyone working on AVRCP, besides jprvita?
> 
> Maybe, but nothing I'm aware of.
> 
> > - Aside from the proposed D-Bus API in doc/control-api.txt, has anyone
> > done some research how an AVRCP1.4 interface should look?
> 
> Mostly just ideas that haven't really been written down. 

Argh, there a wiki would come in handy ;) It has probably gone over the list a few times, 
but I just joined the list and the web archives are.. cumbersome, and google didn't find 
much of avrcp in the list.

> It'd be easier
> if we talked about specific features though than about a profile version
> since different features will require different design solutions and
> API's. E.g. in the MeeGo case we'd probably be talking to tracker in
> order to implement media browsing, however other platforms might have a
> different storage backend which means that we'll need some sort of
> backend driver abstraction (we have a similar situation already in obexd
> PBAP and contact storage).

I'm not in favor of having (multiple) storage plugins. Simply because a storage backend is 
not a player. This distinction is important. MeeGo/tracker is a semantic index, so in 
theory you could browse the media through it, but the player might have 'smart' playlist, 
or is only able to play media of a certain kind. Also the current playlist is a player-
only thing (and is also a browsable item). So I think browsing should go _through_ the 
player.

I was more thinking of exposing a dbus interface that allows a player (or any TG) to 
register itself as a TG, then acting on signals/sending events/responses.

> > - Are there objections to conforming to section 2.3.2, i.e. untying
> > the AVRCP connection from the A2DP connection?
> 
> If by that you mean adding Connect() and Disconnect() method calls to
> the org.bluez.Control D-Bus interface, then I'd be happy to accept
> patches for it. However, the automated connecting of AVRCP as triggered
> by an A2DP connection should stay in order to keep good interoperability
> and make things easy for the user interface code.

Agreed.

> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
