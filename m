Return-Path: <cyrus@holtmann.org>
Message-ID: <AF6253527A02449484D3BA2FF254AE2B@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Cc: "Sander van Grieken" <sander@outrightsolutions.nl>,
	"Shivendra Agrawal" <ag.shivendra@gmail.com>,
	"Waldemar Rymarkiewicz" <Waldemar.Rymarkiewicz@tieto.com>,
	"Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
References: <201010191147.34241.sander@outrightsolutions.nl> <AANLkTikgKM1MNpwP2JL1GdERZ60dE6dkFNC=rdyQDhOV@mail.gmail.com> <AANLkTi=ThA2ojhj8PBHK_VybmFcHO91K0g=y7nhfTBAO@mail.gmail.com>
In-Reply-To: <AANLkTi=ThA2ojhj8PBHK_VybmFcHO91K0g=y7nhfTBAO@mail.gmail.com>
Subject: AVRCP 1.3/1.4 current implementation
Date: Sat, 30 Oct 2010 12:57:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello to all,

In my earlier work, I noticed that in audio/manager.c, function 
handle_uuids, when the UUID was found for an AVRCP target or controller, it 
would only launch avrcp_connect IF a Sink was enabled and present.

I suspect this was done to make sure that if a headset or similar was 
connecting, it would make sure the audio side of the connection was up and 
running before enabling the control side of the interface.

However, my device has no audio side, it is a pure AVRCP CT, so there is no 
audio-side connection.  In previous testing, I just unconditionally started 
avrcp_connect and it all worked fine for my purposes.  I am wondering if 
there is any other impact.

I could submit the patch in which avrcp_connect is unconditionally called. 
Or, I could just wait until all of the uuids are processed (after the 
g_slist_foreach in audio_probe), then launch avrcp_connect if either (a) a 
sink is connected and enabled as at present, or (b) if no sink is called for 
or provided by the CT/TG (as expressed in SDP), just launch avrcp_connect 
without the sink.  Are there any other impacts that this might cause?

To Joao, I would like to test my device against the GSOC work you did; can 
you send me the URL?  If you are farther along, no sense re-inventing the 
wheel. Thanks/obrigado.

David Stockwell 

