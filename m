Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: John Hendy <jw.hendy@gmail.com>
Date: Sat, 13 May 2017 17:55:08 -0500
Message-ID: <CA+M2ft9OM_rZhmZy7hxEffE2mw5kGEjvS0WcJcKxkkt_jcxtRQ@mail.gmail.com>
Subject: Clarification on deprecated tools (e.g. hciconfig)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,


I use arch linux and noticed that the wiki states that some tools such
as hciconfig are deprecated:[1]

### begin_quote

Some tools such as hcitool and hciconfig have been deprecated
upstream, and are no longer included in bluez-utils. Since these tools
will no longer be updated, it is recommended that scripts be updated
to avoid using them. If you still desire to use them, install
bluez-utils-compat. See FS#53110 and the Bluez mailing list for more
information. [2] [3]

### end_quote

The bluez mailing list post is for a patch with the following heading:

### begin_quote

This marks the following tools as deprecated as they are not longer
maintained or have been replaced by other tools:

  hciattach hciconfig hcitool hcidump rfcomm sdptool ciptool gatttool

### end_quote

Is there a source of clarification on which of these tools is simply
"not [no?] longer maintained" vs. "replaced"? I don't auto-enable BT
on my computer and I'd like to switch to whatever I should be using if
for no other reason than the news is fresh now. Perhaps in a year this
method will be completely obsolete; by then I'll have forgotten all
about this and wonder what's wrong.

I'd be happy to update the arch wiki to point to any new information
provided. For what it's worth, I think the information would be
relevant in a widely accessible place (the official bluez site in my
opinion); this question has already popped up in various places. [4]
[5] [6] [7]


Many thanks,
John

[1] https://wiki.archlinux.org/index.php/bluetooth
[2] https://bugs.archlinux.org/task/53110
[3] https://www.spinics.net/lists/linux-bluetooth/msg69239.html
[4] https://www.mail-archive.com/gentoo-user@lists.gentoo.org/msg166798.html
[5] https://github.com/chrippa/ds4drv/issues/123
[6] https://unix.stackexchange.com/questions/352494
[7] https://www.reddit.com/r/archlinux/comments/5x9yle
