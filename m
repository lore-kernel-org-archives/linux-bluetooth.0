Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Oct 2009 09:02:17 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: dun profile
Message-ID: <20091015090217.377ac373@strolchi.home.s3e.de>
In-Reply-To: <2d5a2c100910141815l3300ee34p12fbbac2dd6a96b6@mail.gmail.com>
References: <2d5a2c100910141815l3300ee34p12fbbac2dd6a96b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, 14 Oct 2009 22:15:57 -0300
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi List,
> 
> Im trying to put an end to this problem of detecting rfcomm port
> properly, so what seems to be missing is to associate the profile to
> the port so that udev can properly announce it as modem in case of dun
> profile.

Can you be a bit more specific on what the actual problem is?

I mean, "/usr/bin/test-serial 11:22:33:44:55:66 dun" always gave me a
rfcomm device connected to the DUN profile (back then, when I had not
switched to PAN ;)

Do you want to create /dev/rfcommX automatically on adapter insertion?
Do you also want to connect it immediately? (I would not want that).
If it would connect "on demand", then it would need to do SDP queries
and find out the port at that time since the port can change.

Or am I totally off track? (probably ;)

Have fun,

	seife
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
