Return-Path: <cyrus@holtmann.org>
From: Sander van Grieken <sander@outrightsolutions.nl>
To: "David Stockwell" <dstockwell@frequency-one.com>
Subject: Re: AVRCP 1.3/1.4 current implementation
Date: Sat, 30 Oct 2010 20:54:47 +0200
Cc: =?iso-8859-1?q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"Shivendra Agrawal" <ag.shivendra@gmail.com>,
	"Waldemar Rymarkiewicz" <Waldemar.Rymarkiewicz@tieto.com>,
	"Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
References: <201010191147.34241.sander@outrightsolutions.nl> <AANLkTi=ThA2ojhj8PBHK_VybmFcHO91K0g=y7nhfTBAO@mail.gmail.com> <AF6253527A02449484D3BA2FF254AE2B@freqoneremote>
In-Reply-To: <AF6253527A02449484D3BA2FF254AE2B@freqoneremote>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201010302054.47867.sander@outrightsolutions.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Saturday 30 October 2010 19:57:31 David Stockwell wrote:
> Hello to all,
> 
> In my earlier work, I noticed that in audio/manager.c, function 
> handle_uuids, when the UUID was found for an AVRCP target or controller, it 
> would only launch avrcp_connect IF a Sink was enabled and present.
> 
> I suspect this was done to make sure that if a headset or similar was 
> connecting, it would make sure the audio side of the connection was up and 
> running before enabling the control side of the interface.
> 
> However, my device has no audio side, it is a pure AVRCP CT, so there is no 
> audio-side connection.  In previous testing, I just unconditionally started 
> avrcp_connect and it all worked fine for my purposes.  I am wondering if 
> there is any other impact.

Yes the current implementation only (implicitly) connects the RCP if a connection is made 
to a DTP (audio) profile, or if a RCP connection request is received from the peer.

I have already implemented a DBUS method to connect only the RCP, but is only tested with 
devices that also have the DTP profile, so this might not work if there's no DTP profile 
detected on the peer. The code uses a struct audio_device * to pass along to the various 
RCP functions, that might or might not be available when the peer has no DTP profile..

I think we can add the factoring out of the audio_device dependency to the TODO list. 
Probably something along the lines of defining a struct control_device and have a pointer 
to an optional audio_device struct in there.

I've made this stuff available in my git at github:

git://github.com/accumulator/bluez.git

grtz,
Sander
