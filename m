Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] [PATCH] New keytab storage
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075562590.2720.13.camel@pegasus>
References: <1075506991.14644.114.camel@akka.yeti.nocrew.org>
	 <1075509170.3594.36.camel@pegasus>
	 <1075510549.14644.135.camel@akka.yeti.nocrew.org>
	 <1075511922.3594.49.camel@pegasus>
	 <1075541234.14644.149.camel@akka.yeti.nocrew.org>
	 <1075562590.2720.13.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1075563628.14644.161.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sat, 31 Jan 2004 16:40:28 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

lör 2004-01-31 klockan 16.23 skrev Marcel Holtmann:
> the compat directories contains the old code until all parts are
> replaced. This is why it is called compat. Don't focus on it.

Since the "new" hcid was lost and there is no replacement, I'll work 
on the old code. I think it's very useful. I'm currently cleaning up 
the mess in "glib-ectomy" and preparing it for a DBus connection.

Fredrik
