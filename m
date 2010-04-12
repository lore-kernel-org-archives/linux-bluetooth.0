Return-Path: <cyrus@holtmann.org>
Subject: Re: Regarding HS re-connection
From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
To: Iain Hibbert <plunky@rya-online.net>
Cc: nirav rabara <niravrabara@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1271059413.486818.580.nullmailer@galant.ukfsn.org>
References: <h2k912bb79a1004112146wd46cc9d6j36a0807563ed4d5d@mail.gmail.com>
	 <1271059413.486818.580.nullmailer@galant.ukfsn.org>
Content-Type: text/plain
Date: Mon, 12 Apr 2010 10:56:28 +0200
Message-Id: <1271062588.2867.8.camel@donpedro>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On Mon, 2010-04-12 at 09:03 +0100, Iain Hibbert wrote:
> I think your question stems from misunderstandings about pairing.
> Obviously, you can't force the HS to be paired with a device that it
> doesn't know about. You probably can't even connect to it unless you are
> paired with it..  Bluetooth is a cable-replacement technology and pairing
> is about setting up a trusted connection that does not need to be approved
> every time it needs to be made. If you can forcefully pair with a device,
> then any Joe with a radio could do it too from hundreds of meters away and
> there would be no security in that. That you the owner of each device must
> participate in the pairing process is intentional.

This is not always true. A portion of the newer headsets are in pairing
mode all of the time (or selected periods). If it at the same time uses
SSP and no other authentication, then there is not even a PIN which
blocks an attacker/connector (which is always 0000 on headsets anyway).
Personally i do not favor this approach, as it kills battery and makes
security a non existing function. Often this type of scheme is branded
as "pairing made simple" or similar. There is at least a few major
brands that do this, to avoid their hot-lines glowing with "i cannot
pair my headset!".

Thanks,

/pedro
