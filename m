Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <cbf0aec904111910383520ec7f@mail.gmail.com>
From: =?ISO-8859-1?Q?Henryk_Pl=F6tz?= <ploetz@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
In-Reply-To: <1100822368.7164.98.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <418DB442.2050801@uen.org> <419543B3.8050601@xmission.com>
	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>
	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>
	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <1100822368.7164.98.camel@pegasus>
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
Date: Fri, 19 Nov 2004 19:38:44 +0100

Moin,

On Fri, 19 Nov 2004 00:59:28 +0100, Marcel Holtmann <marcel@holtmann.org> w=
rote:

> I just tested it and the result so far is very great. Keep on working on
> it.

Thanks. I'm getting more and more confident in that my bitstream
decoding is correct, but I can't seem to get the synthesis done. I got
me some books on compression from the library and read the chapters
about subband coding, but they basically said what I knew (or figured)
anyways.

> What format do you think is the easiest to encode/decode?

In what respect to?=20

> And btw your file creation should be this command:
>         fh =3D open("bla_.au", O_WRONLY|O_CREAT|O_TRUNC, 0644);

Ahh, thanks. I had wondered why it kept doing funny things, but didn't
investigate further.

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
