Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] New keytab storage
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075563628.14644.161.camel@akka.yeti.nocrew.org>
References: <1075506991.14644.114.camel@akka.yeti.nocrew.org>
	 <1075509170.3594.36.camel@pegasus>
	 <1075510549.14644.135.camel@akka.yeti.nocrew.org>
	 <1075511922.3594.49.camel@pegasus>
	 <1075541234.14644.149.camel@akka.yeti.nocrew.org>
	 <1075562590.2720.13.camel@pegasus>
	 <1075563628.14644.161.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1075564322.2720.42.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 31 Jan 2004 16:52:02 +0100

Hi Fredrik,

> > the compat directories contains the old code until all parts are
> > replaced. This is why it is called compat. Don't focus on it.
> 
> Since the "new" hcid was lost and there is no replacement, I'll work 
> on the old code. I think it's very useful. I'm currently cleaning up 
> the mess in "glib-ectomy" and preparing it for a DBus connection.

it is not very hard to replace this code, but I am a little bit busy and
the CVS is dead at the moment. But I think we should discuss some design
goals of the new device manager.

I don't see what kind of mess in "glib-ectomy" you mean, but go ahead
and send a patch for it. The D-Bus support is one of the things I
definitively want to have in the next release, so every patch would help
here. Please keep both separate, because small patches are easier to
review.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
