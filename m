Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Jul 2012 10:28:20 +0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Anton Weber <ant@antweb.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: GSoC: Bluetooth Replayer update
Message-ID: <20120703082820.GA14566@joana>
References: <CA+6PnXxc8CQ7q6LGkDWbP_-2P+4U_MX3rTt237PHhN2nGXeYag@mail.gmail.com>
 <20120522020004.GG16942@joana>
 <CA+6PnXwKzOBBG61dDSpHEdXTd-GsURcHOq7y+tVGoEKSpiQTFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+6PnXwKzOBBG61dDSpHEdXTd-GsURcHOq7y+tVGoEKSpiQTFg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anton,

* Anton Weber <ant@antweb.me> [2012-07-02 16:32:23 +0100]:

> Hi everyone,
> 
> it's been a while since my last update but I wanted to wait until I
> have something to show and solve a few issues before I post here
> again.
> I made quite some progress during the past weeks and managed to get a
> running version of my "hcireplay" tool.
> 
> Here's an overview of what it can do so far:
> - replay of HCI commands, events and ACL data using VHCI
> - dump file parser for BTSnoop format (taken from hcidump)
> - timing functionality (delays using timestamps in the dump, modifier)
> - packet dump output (using monitor code)
> 
> What I've also done in the meantime:
> - set up a github repository for my work [1]
> - set up a project page on my website [2]
> - recorded a few dumps with btmon (thanks for the hint Gustavo)
> - more background reading
> 
> Right now the tool does most of the things I planned. A good demo is
> the "mouse-move" dump [3]
> which replays the sequence of bringing the interface up, connecting a
> Bluetooth mouse and moving it around.
> 
> If you want to give it a try, just grab the test dump and latest
> source from github [1] and build it with "make hcireplay/hcireplay".
> It would be great to get some feedback from the BlueZ community, since
> you will be the one using this tool most!

I didn't test your tool yet (once I do I'll have more feedback), but please
fold this tool under the tools/ folder.

	Gustavo
