Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <cbf0aec904111910327e0231f7@mail.gmail.com>
From: =?ISO-8859-1?Q?Henryk_Pl=F6tz?= <ploetz@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
In-Reply-To: <419CBF0A.2030201@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <418DB442.2050801@uen.org> <419543B3.8050601@xmission.com>
	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>
	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>
	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <419CBF0A.2030201@xmission.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 19 Nov 2004 19:32:54 +0100

Moin,

On Thu, 18 Nov 2004 08:26:02 -0700, Brad Midgley <bmidgley@xmission.com> wr=
ote:

> Can I put what you've given us in a module in our bluetooth-alsa
> sourceforge cvs and make you a developer?

Sure. My sourceforge username is henryk.

> I think the structs you have should probably be marked as __attribute__
> ((packed)) so they don't get realigned by gcc. I'm not sure if there's a
> portable alternative.

Ok, will do that.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
