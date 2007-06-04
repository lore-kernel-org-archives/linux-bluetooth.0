Return-Path: <vitervo@nokia.com>
Date: Mon, 4 Jun 2007 14:55:33 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Patch] Keep rfcomm device in list until it's freed
Message-ID: <20070604115532.GI6310@null.research.nokia.com>
References: <20070601111156.GB6310@null.research.nokia.com> <1180711261.6726.6.camel@aeonflux.holtmann.net> <20070604083531.GF6310@null.research.nokia.com> <1180946944.13429.21.camel@violet> <20070604103256.GH6310@null.research.nokia.com> <1180953879.13429.25.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180953879.13429.25.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> Hi Ville,
> 
> do you have a simple re-producer for it. I need to test this on my Quad
> G5 before pushing this upstream.

Nope. Claudio said that he had some way to reproduce the bug with some
cvs version. I haven't tried that yet. I need to install some distro to
test machine first. However I tested this with N800 and it works fine on
arm.

1. utils/serial/port.c comment line 151 "g_io_channel_close"
2. comment the last line of utils/serial/test-serial : "serial.DisconnectService(device)"
call  "test-serial address channel"  the first time,  after establish
the connection press ctrl+c and execute the same command again

-- 
Ville
