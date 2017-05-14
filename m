Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+M2ft9OM_rZhmZy7hxEffE2mw5kGEjvS0WcJcKxkkt_jcxtRQ@mail.gmail.com>
References: <CA+M2ft9OM_rZhmZy7hxEffE2mw5kGEjvS0WcJcKxkkt_jcxtRQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 14 May 2017 19:19:28 +0300
Message-ID: <CABBYNZLAD5Z_FP96weVpCMezdjU+Ebu8BQcY1bNdwf8-r2Dxcw@mail.gmail.com>
Subject: Re: Clarification on deprecated tools (e.g. hciconfig)
To: John Hendy <jw.hendy@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Sun, May 14, 2017 at 1:55 AM, John Hendy <jw.hendy@gmail.com> wrote:
> Hello,
>
>
> I use arch linux and noticed that the wiki states that some tools such
> as hciconfig are deprecated:[1]
>
> ### begin_quote
>
> Some tools such as hcitool and hciconfig have been deprecated
> upstream, and are no longer included in bluez-utils. Since these tools
> will no longer be updated, it is recommended that scripts be updated
> to avoid using them. If you still desire to use them, install
> bluez-utils-compat. See FS#53110 and the Bluez mailing list for more
> information. [2] [3]
>
> ### end_quote
>
> The bluez mailing list post is for a patch with the following heading:
>
> ### begin_quote
>
> This marks the following tools as deprecated as they are not longer
> maintained or have been replaced by other tools:
>
>   hciattach hciconfig hcitool hcidump rfcomm sdptool ciptool gatttool
>
> ### end_quote
>
> Is there a source of clarification on which of these tools is simply
> "not [no?] longer maintained" vs. "replaced"? I don't auto-enable BT
> on my computer and I'd like to switch to whatever I should be using if
> for no other reason than the news is fresh now. Perhaps in a year this
> method will be completely obsolete; by then I'll have forgotten all
> about this and wonder what's wrong.

All the tools using raw socket shall be considered deprecated, these
tools may interfere with the so called Management interface since they
can alter the controller state in a way that other applications cannot
detect. Note that for the most part bluetoothctl will be able to do
pretty much everything you want and more, for those operations not
support over D-Bus that are usually at HCI level you may want to use
btmgmt although we may actually turn hciconfig, hcitool, etc to either
use btmgmt to maintain backward compatibility until distros do the
switch.

> I'd be happy to update the arch wiki to point to any new information
> provided. For what it's worth, I think the information would be
> relevant in a widely accessible place (the official bluez site in my
> opinion); this question has already popped up in various places. [4]
> [5] [6] [7]

I guess the most practical solution would be to switch everything to
use bluetoothctl as much as possible, going with raw or mgmt socket
should only be mentioned as a last resort in case something went
wrong.

>
> Many thanks,
> John
>
> [1] https://wiki.archlinux.org/index.php/bluetooth
> [2] https://bugs.archlinux.org/task/53110
> [3] https://www.spinics.net/lists/linux-bluetooth/msg69239.html
> [4] https://www.mail-archive.com/gentoo-user@lists.gentoo.org/msg166798.html
> [5] https://github.com/chrippa/ds4drv/issues/123
> [6] https://unix.stackexchange.com/questions/352494
> [7] https://www.reddit.com/r/archlinux/comments/5x9yle
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
