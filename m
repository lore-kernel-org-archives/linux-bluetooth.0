Return-Path: <cyrus@holtmann.org>
Subject: Re: Switching between SBC and MPEG audio on headsets
From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <AANLkTimF0Ux=-uQiWaWH14r3_YAuyp2o=QrmyeLkWWeT@mail.gmail.com>
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
	 <20110315170124.GA15712@jh-x301>
	 <AANLkTimF0Ux=-uQiWaWH14r3_YAuyp2o=QrmyeLkWWeT@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Mar 2011 23:38:31 +0100
Message-ID: <1300315111.4500.34.camel@donpedro>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On Tue, 2011-03-15 at 16:29 -0300, Luiz Augusto von Dentz wrote:
> Actually
> I would suggest configuring both endpoint since the beginning so that
> we only need to suspend/resume to switch between them, but I don't
> think many headsets would be able to handle this situation. 

Unfortunately, because of a rather silly flaw in the A2DP specifications
you cannot do this. The reason is simple. You would need a separate
L2CAP channel for each data link. A2DP uses up to three L2CAP channels
all on L2CAP PSM=0x19:

1) First is always signalling channel.
2) Second is always data channel.
3) Third is always Journaling channel (never really used).

So if you already had the first two, and you opened yet another on
PSM=0x19 from the same device, then it could be one of the following:

1) A new signalling channel (multi-profile).
2) A new data channel for already opened profile.
3) A new Journalling channel for already opened profile.

Because of the specification problem mentioned above, the problem is not
really solvable, and the implementation is forced to assume that the new
L2CAP channel is the 3rd channel (Journalling). The correct solution
would of course have been a dynamic PSM for each service, and for each
profile.

So current the only portable way of supporting multiple codecs is:

1) Close existing data channel.
2) Setup config.
3) Re-open data channel.
4) Send "start".

Anything else will most likely not work with the headsets in the wild.

And also a note: Do not *ever* cache the data from the discovery phase.
That would only make the same mistake many have done with SDP queries.
If you are using a multi-link headset, the other connected device might
have changed which codecs are available (or left), and in some cases it
could also change which options and settings are supported.

Thanks,

/pedro
