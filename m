Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] New keytab storage
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075510549.14644.135.camel@akka.yeti.nocrew.org>
References: <1075506991.14644.114.camel@akka.yeti.nocrew.org>
	 <1075509170.3594.36.camel@pegasus>
	 <1075510549.14644.135.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1075511922.3594.49.camel@pegasus>
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
Date: Sat, 31 Jan 2004 02:18:43 +0100

Hi Fredrik,

> Can I ask where the new code is?

I started already coding the new device manager, but accidentally I
deleted that code from my harddisk.

However you should talk a look at libs2 and utils2 from CVS.

> I'd be happy to skip them. The original source (bluez-utils-2.4.tar.gz)
> contains these files for some reason though.

Generate the diffs againt the CVS sources.

> The main reason for this typedef is that the original code did things
> like this:
> 
>     unint8_t link_key_t[16];
>     ...
>     memcpy(key0, key1, 16);
> 
> which, I think, is a lot worse than:
> 
>     memcpy(key0, key1, sizeof(link_key_t));
> 
> Don't you agree? (An alternative is to use #define LINK_KEY_SIZE 16
> instead of course.)

I am not sure how to handle this link key issue in general, but that was
not the argument. See below.

> > than the *_t version must match the structure and not define something 
> > complete different.
> 
> What do you mean?

If you typedef something and it ends with "_t" you should avoid to have
a struct with the same prefix, but different meaning. This example is
ok, but it is not good coding style (typedefs are ugly).

	struct abc {
		int a;
		int b;
		int c;
	};

	typedef struct abc abc_t;

Hope you get my point.

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
