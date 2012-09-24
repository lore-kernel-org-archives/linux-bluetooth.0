Return-Path: <cyrus@holtmann.org>
Message-ID: <1348495002.7637.4.camel@obelisk.thedillows.org>
Subject: Re: [RFC, PATCH] hid-ps3remote: handle multiple keypresses for
 joypad buttons
From: David Dillow <dave@thedillows.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	David Herrmann <dh.herrmann@googlemail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org, jkosina@suse.cz
Date: Mon, 24 Sep 2012 09:56:42 -0400
In-Reply-To: <1348485938-20510-1-git-send-email-ospite@studenti.unina.it>
References: <20120921220659.1e257048fed597061efb07f9@studenti.unina.it>
	 <1348485938-20510-1-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-09-24 at 13:25 +0200, Antonio Ospite wrote:
> In order to make this work I have to put joypad buttons only in one of
> the key maps, I don't know if that is compatible with the Harmony
> adapter.

I suspect it is, but I'll try to test later tonight. Feel free to merge
my patch and yours and push it upstream under your name/copyright; I'm
not attached to it.

> diff --git a/drivers/hid/hid-ps3remote.c b/drivers/hid/hid-ps3remote.c
> index 11a6c1f..fa2e50d 100644
> --- a/drivers/hid/hid-ps3remote.c
> +++ b/drivers/hid/hid-ps3remote.c
> @@ -49,6 +49,26 @@
>   * The keymap is generally ordered by the physical location of the buttons,
>   * as this makes it easier to verify a correct mapping during testing.
>   */

You'd have caught this in cleanup, I'm sure, but the above comment no
longer makes sense.

> +static const unsigned int ps3remote_keymap_1[] = {

Probably want a better name -- again, something I'm sure you would have
done during cleanup of this proof-of-concept.

>  static const unsigned int ps3remote_keymap[] = {

This map probably should now be ordered per David H. since we're no
longer following the physical layout.

Thanks,
Dave

