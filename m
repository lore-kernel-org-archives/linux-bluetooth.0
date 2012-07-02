Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120522020004.GG16942@joana>
References: <CA+6PnXxc8CQ7q6LGkDWbP_-2P+4U_MX3rTt237PHhN2nGXeYag@mail.gmail.com>
	<20120522020004.GG16942@joana>
Date: Mon, 2 Jul 2012 16:32:23 +0100
Message-ID: <CA+6PnXwKzOBBG61dDSpHEdXTd-GsURcHOq7y+tVGoEKSpiQTFg@mail.gmail.com>
Subject: GSoC: Bluetooth Replayer update
From: Anton Weber <ant@antweb.me>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

it's been a while since my last update but I wanted to wait until I
have something to show and solve a few issues before I post here
again.
I made quite some progress during the past weeks and managed to get a
running version of my "hcireplay" tool.

Here's an overview of what it can do so far:
- replay of HCI commands, events and ACL data using VHCI
- dump file parser for BTSnoop format (taken from hcidump)
- timing functionality (delays using timestamps in the dump, modifier)
- packet dump output (using monitor code)

What I've also done in the meantime:
- set up a github repository for my work [1]
- set up a project page on my website [2]
- recorded a few dumps with btmon (thanks for the hint Gustavo)
- more background reading

Right now the tool does most of the things I planned. A good demo is
the "mouse-move" dump [3]
which replays the sequence of bringing the interface up, connecting a
Bluetooth mouse and moving it around.

If you want to give it a try, just grab the test dump and latest
source from github [1] and build it with "make hcireplay/hcireplay".
It would be great to get some feedback from the BlueZ community, since
you will be the one using this tool most!
(And I should slowly move to the bugfixing stage of my project).
As always, just to contact me directly if you have any questions that
are too specific for the mailing list!

One problem that I came across is that the host isn't always sending
the HCI commands to initialise
the newly connected controller in the same order. So hcireplay might
get stuck waiting for a particular
packet in the sequence. Anderson and I decided that the solution for
this problem for now would be
to process the less relevant part (in this case the init sequence) of
the dump separately instead of replaying it.

So I'll be looking at following things now:
- emulator integration
- configuration file support

For those who are reading about this project for the first time, I
linked to my previous post on my website [2] in the "GSoC" section.

Best,
Anton

[1] https://github.com/antweb/bluez-ant
[2] http://antweb.me/index.php/gsoc2012.html
[3] http://antweb.me/index.php/gsoc2012.html?file=tl_files/projects/hcireplay/mouse-move.btsnoop
