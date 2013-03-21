Return-Path: <cyrus@holtmann.org>
Message-ID: <1363852154.2681.3.camel@novo>
Subject: Re: [PATCH 0/6] The Autopair strikes back
From: Bastien Nocera <hadess@hadess.net>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org, marcel@holtmann.org
Date: Thu, 21 Mar 2013 08:49:14 +0100
In-Reply-To: <1363839008-8405-1-git-send-email-deymo@chromium.org>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Alex,

On Wed, 2013-03-20 at 21:10 -0700, Alex Deymo wrote:
> Hello!
> This is a rework of the autopair.c plugin we had at some point in BlueZ 4.

Happy to see it come back!

> The goal of this patch set is to make the pairing process easier for 
> devices that have a fixed and dumb pincode (like 0000 or 1234) or that
> accept any pincode as long as the same pincode is entered on the device
> (keyboards/combos). The goal is:
>  * Don't ask the user (i.e. the agent) a question if we know the right answer.
> This makes the user happier. =)

Is there any chance you could use:
https://git.gnome.org/browse/gnome-bluetooth/tree/wizard/pin-code-database.xml
even it means converting it to a different format?

This would mean more supported devices out-of-the-box? I'd be happy
maintaining the list outside of the bluez tree if the bluez developers
don't want to take on the burden of maintaining it.

Cheers
