Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] [PATCH] New keytab storage
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075564322.2720.42.camel@pegasus>
References: <1075506991.14644.114.camel@akka.yeti.nocrew.org>
	 <1075509170.3594.36.camel@pegasus>
	 <1075510549.14644.135.camel@akka.yeti.nocrew.org>
	 <1075511922.3594.49.camel@pegasus>
	 <1075541234.14644.149.camel@akka.yeti.nocrew.org>
	 <1075562590.2720.13.camel@pegasus>
	 <1075563628.14644.161.camel@akka.yeti.nocrew.org>
	 <1075564322.2720.42.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1075565012.14644.176.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sat, 31 Jan 2004 17:03:32 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

lör 2004-01-31 klockan 16.52 skrev Marcel Holtmann:
> But I think we should discuss some design goals of the new device manager.

Great idea. What's your plan for it?

> I don't see what kind of mess in "glib-ectomy" you mean, but go ahead
> and send a patch for it. 

Some bads, I think:

  - The API can be improved
  - Tons of ugly (even in opionon) typedef:s
  - No style

Fredrik
