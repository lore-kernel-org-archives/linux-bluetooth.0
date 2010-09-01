Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Sep 2010 21:57:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sander van Grieken <sander@outrightsolutions.nl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: AVRCP future
Message-ID: <20100901185729.GB30041@jh-x301>
References: <201009011603.02153.sander@outrightsolutions.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201009011603.02153.sander@outrightsolutions.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sander,

On Wed, Sep 01, 2010, Sander van Grieken wrote:
> - Is anyone working on AVRCP, besides jprvita?

Maybe, but nothing I'm aware of.

> - Aside from the proposed D-Bus API in doc/control-api.txt, has anyone
> done some research how an AVRCP1.4 interface should look?

Mostly just ideas that haven't really been written down. It'd be easier
if we talked about specific features though than about a profile version
since different features will require different design solutions and
API's. E.g. in the MeeGo case we'd probably be talking to tracker in
order to implement media browsing, however other platforms might have a
different storage backend which means that we'll need some sort of
backend driver abstraction (we have a similar situation already in obexd
PBAP and contact storage).

> - Are there objections to conforming to section 2.3.2, i.e. untying
> the AVRCP connection from the A2DP connection?

If by that you mean adding Connect() and Disconnect() method calls to
the org.bluez.Control D-Bus interface, then I'd be happy to accept
patches for it. However, the automated connecting of AVRCP as triggered
by an A2DP connection should stay in order to keep good interoperability
and make things easy for the user interface code.

Johan
