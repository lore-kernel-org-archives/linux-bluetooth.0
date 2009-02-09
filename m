Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluez as A2DP-SNK?
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcel Witte <wittemar@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <498F6E1F.6080906@googlemail.com>
References: <498F6E1F.6080906@googlemail.com>
Content-Type: text/plain
Date: Mon, 09 Feb 2009 13:32:24 +0100
Message-Id: <1234182744.4705.8.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Is it possible to use bluez as A2DP-SNK? In the wiki it's just described
> how to use it as SRC with ALSA, and while searching the web I just found
> a thread on the bluez.devel-newsgroup from march 2005, saying that it is
> not yet implemented. Is it now implemented? Would it be hard to implement?

it is not implemented, but feel free to work on an implementation for
the A2DP sink. It should not be that hard since all the base work is
already present.

Regards

Marcel


