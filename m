Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] A2DP vs. microphone
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41EE770F.8030302@xmission.com>
References: <41EE770F.8030302@xmission.com>
Content-Type: text/plain
Message-Id: <1106151937.8190.126.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 19 Jan 2005 17:25:37 +0100

Hi Brad,

> i just added this to our docs and I want to bounce it off you guys to 
> make sure I'm reading things right:
> 
> A2DP provides a way to send stereo high-quality audio to some of the
> newer headsets. This is one-way audio, so if you were expecting to get
> something like a gaming headset (talking to other players, getting
> stereo sound back from the game) I guess the spec is lacking. It might
> be theoretically possible for a headset to accept simultaneous SCO and
> A2DP connections to do this but even if it's possible, no headset
> allows it.

SCO is bidirectional and thus using a Bluetooth headset for gaming is
possible. The A2DP is a distribution service and you can have multiple
sink and source combination. So a headphone can also have a microphone
channel to send high quality voice (for voice recognition) back. However
I haven't seen such a product so far, but it seems that the Toshiba SR-1
may is capable of something like that. Check my webpage.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
