Return-Path: <cyrus@holtmann.org>
Message-ID: <1348539215.15050.6.camel@obelisk.thedillows.org>
Subject: Re: [RFC, PATCH] hid-ps3remote: handle multiple keypresses for
 joypad buttons
From: David Dillow <dave@thedillows.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	David Herrmann <dh.herrmann@googlemail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org, jkosina@suse.cz
Date: Mon, 24 Sep 2012 22:13:35 -0400
In-Reply-To: <1348495002.7637.4.camel@obelisk.thedillows.org>
References: <20120921220659.1e257048fed597061efb07f9@studenti.unina.it>
	 <1348485938-20510-1-git-send-email-ospite@studenti.unina.it>
	 <1348495002.7637.4.camel@obelisk.thedillows.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-09-24 at 09:56 -0400, David Dillow wrote:
> On Mon, 2012-09-24 at 13:25 +0200, Antonio Ospite wrote:
> > In order to make this work I have to put joypad buttons only in one of
> > the key maps, I don't know if that is compatible with the Harmony
> > adapter.
> 
> I suspect it is, but I'll try to test later tonight. Feel free to merge
> my patch and yours and push it upstream under your name/copyright; I'm
> not attached to it.

Yep, this works with the Harmony.

I think the logic you are using may result in some combinations being
missed -- say Triangle + Play -- but I'm not sure how much it matters. I
can rework the first version (building a custom report based on the
funky rules of coding) in the next few days, or you can push your
version if you'd like. Or perhaps a middle way, that erases the buttons
reported in the bitmap from the byte array, but otherwise keeps track of
the last press in that area to avoid weirdness when the user presses a
button combo that cannot be reported due to the HW limitations.

Dave

