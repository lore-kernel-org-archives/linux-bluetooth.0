Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <cbf0aec9041119160441592e2c@mail.gmail.com>
From: =?ISO-8859-1?Q?Henryk_Pl=F6tz?= <ploetz@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
In-Reply-To: <1100901846.7213.101.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <418DB442.2050801@uen.org> <1100822368.7164.98.camel@pegasus>
	 <419DB6E1.8000203@xmission.com> <1100864484.7213.19.camel@pegasus>
	 <419E20C3.7@xmission.com> <1100883199.7213.27.camel@pegasus>
	 <1100885959.7213.31.camel@pegasus> <1100897144.7213.63.camel@pegasus>
	 <419E6AD8.7050104@xmission.com> <1100901846.7213.101.camel@pegasus>
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
Date: Sat, 20 Nov 2004 01:04:11 +0100

Moin,

On Fri, 19 Nov 2004 23:04:06 +0100, Marcel Holtmann <marcel@holtmann.org> w=
rote:
> What we need is an easy way to calculate the frame size from the frame
> header without decoding the frame data itself.=20

I just re-discovered that in the A2DP spec. It's on page 70, section 12.9.

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
