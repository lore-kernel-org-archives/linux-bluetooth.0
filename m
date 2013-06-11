Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Jun 2013 11:07:40 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC v1 5/9] doc: add RequestPairingSession() and
 ReleasePairingSession()
Message-ID: <20130611100740.GA26145@joana>
References: <1370909011-19315-1-git-send-email-gustavo@padovan.org>
 <1370909011-19315-5-git-send-email-gustavo@padovan.org>
 <1370944815.2973.9.camel@novo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370944815.2973.9.camel@novo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Bastien Nocera <hadess@hadess.net> [2013-06-11 12:00:15 +0200]:

> On Tue, 2013-06-11 at 01:03 +0100, Gustavo Padovan wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > 
> > Those methods improve the tracking of the Discoverable and Pairable
> > properties for Pairing purposes. One could call RequestPairingSession()
> > to get a Pairing session.
> > 
> > ReleasePairingSession() releases a session. If the client exits without
> > calling the ReleasePairingSession() the session is also released.
> > When the last session is released both Discoverable and Pairing goes back
>                                                           ^^^^^^^
> Paired. Though Pairing does go back to its original "False" value...

Actually it is "Pairable". The original value is the one before start the
first Pairing Session. Maybe I should rewrite this part.

> 
> > the their original value.
> > 
> > The Pairing property tracks if the there is a ongoing Pairing session.
> 
> I agree with Marcel that "Pairing" is a confusing name. PairingMode?

The I would to rename the methods to EnablePairingMode() and so on.

	Gustavo
