Return-Path: <cyrus@holtmann.org>
Message-ID: <1370944815.2973.9.camel@novo>
Subject: Re: [RFC v1 5/9] doc: add RequestPairingSession() and
 ReleasePairingSession()
From: Bastien Nocera <hadess@hadess.net>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Tue, 11 Jun 2013 12:00:15 +0200
In-Reply-To: <1370909011-19315-5-git-send-email-gustavo@padovan.org>
References: <1370909011-19315-1-git-send-email-gustavo@padovan.org>
	 <1370909011-19315-5-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2013-06-11 at 01:03 +0100, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> Those methods improve the tracking of the Discoverable and Pairable
> properties for Pairing purposes. One could call RequestPairingSession()
> to get a Pairing session.
> 
> ReleasePairingSession() releases a session. If the client exits without
> calling the ReleasePairingSession() the session is also released.
> When the last session is released both Discoverable and Pairing goes back
                                                          ^^^^^^^
Paired. Though Pairing does go back to its original "False" value...

> the their original value.
> 
> The Pairing property tracks if the there is a ongoing Pairing session.

I agree with Marcel that "Pairing" is a confusing name. PairingMode?


