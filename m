Return-Path: <james.cameron@hp.com>
Date: Mon, 28 Jun 2004 09:34:37 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: 256436@bugs.debian.org,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up script
Message-ID: <20040627233437.GD28828@hp.com>
References: <20040627133325.GA23996@hp.com> <1088366793.3774.70.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088366793.3774.70.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

G'day Marcel,

Thanks for the reply.  I wasn't aware of the net.agent script in
hotplug.  Now that you've drawn my attention to it, I see it should
work.  The Debian package provides /usr/share/doc/hotplug/README.Debian
which explains how to use it.  I'll give it a try.

As for removing the code in order to rely on hotplug, I don't like that
because I've got some small disk and small memory systems that I'd like
to configure statically.

-- 
James Cameron
