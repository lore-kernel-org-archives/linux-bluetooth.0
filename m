Return-Path: <cyrus@holtmann.org>
Message-ID: <1370945641.2973.11.camel@novo>
Subject: Re: [RFC v1 5/9] doc: add RequestPairingSession() and
 ReleasePairingSession()
From: Bastien Nocera <hadess@hadess.net>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Tue, 11 Jun 2013 12:14:01 +0200
In-Reply-To: <20130611100740.GA26145@joana>
References: <1370909011-19315-1-git-send-email-gustavo@padovan.org>
	 <1370909011-19315-5-git-send-email-gustavo@padovan.org>
	 <1370944815.2973.9.camel@novo> <20130611100740.GA26145@joana>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2013-06-11 at 11:07 +0100, Gustavo Padovan wrote:
> * Bastien Nocera <hadess@hadess.net> [2013-06-11 12:00:15 +0200]:
> 
> > On Tue, 2013-06-11 at 01:03 +0100, Gustavo Padovan wrote:
> > > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > > 
> > > Those methods improve the tracking of the Discoverable and Pairable
> > > properties for Pairing purposes. One could call RequestPairingSession()
> > > to get a Pairing session.
> > > 
> > > ReleasePairingSession() releases a session. If the client exits without
> > > calling the ReleasePairingSession() the session is also released.
> > > When the last session is released both Discoverable and Pairing goes back
> >                                                           ^^^^^^^
> > Paired. Though Pairing does go back to its original "False" value...
> 
> Actually it is "Pairable".

Replaced the error by another error. Time for more coffee!

>  The original value is the one before start the
> first Pairing Session. Maybe I should rewrite this part.



