Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EA1B6E.3070303@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] scooped by pocketpc (a2dp)
References: <41E93682.9040907@xmission.com> <41E93B4F.1010600@dark-reality.de>
In-Reply-To: <41E93B4F.1010600@dark-reality.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 16 Jan 2005 00:44:46 -0700

Lars,

> all programs that use openh323/pwlib (latter for hardware abstraction)
> use alsalib, because pwlib can be compiled against alsalib or oss or both.

hmm. i see a menu for alsa devices but our userspace a2dp device 
(currently stubbed out, but not implemented) doesn't show up. i set it 
up as documented in btsco/bt/BUILD

> That leads to - at least - gnomemeeting and openphone supporting alsa
> directly :)

that looks like a good option, esp when gm supports sip

> I'm not that interested because my headset only supports the mono
> headset profile... ;)

a2dp does not address using a microphone, so if you use a2dp, you have 
to choose a different device for audio in.

> writing the a2dp alsa driver should be similar to the btsco alsa part,
> maybe we can build one thing for both purposes, or at least keep
> structures similar so that both projects can support each other best!

well i want to try putting a2dp in a userspace driver since that might 
be the best way to go. (that's an issue that may not be totally worked 
out but i think we decided that it looks attractive enough to at least 
try writing alsa-lib drivers)

if it works well, we might rewrite the sco driver to be in userspace.

brad


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
