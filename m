Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <cbf0aec9041119104437a6d6ac@mail.gmail.com>
From: =?ISO-8859-1?Q?Henryk_Pl=F6tz?= <ploetz@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
In-Reply-To: <419DB6E1.8000203@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <418DB442.2050801@uen.org> <1100306337.7349.29.camel@pegasus>
	 <41957BC1.507@xmission.com> <1100351199.7349.50.camel@pegasus>
	 <41970F25.4020902@xmission.com> <1100446172.21403.16.camel@pegasus>
	 <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <1100822368.7164.98.camel@pegasus> <419DB6E1.8000203@xmission.com>
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
Date: Fri, 19 Nov 2004 19:44:43 +0100

Moin,

> If that looks like the right direction, I need to work on delineating
> the sbc frames inside the sbc file so i can put on the media packet
> headers and the media payload headers. Is it straightforward?

Well, from what I understand the SBC frames can greatly vary in length
and one can't know the length before unpacking the bitstream (or at
least calculating the 'bits' array). That's why my code works like it
does: the sbc_unpack_frame() returns the length of the frame that it
just unpacked so the calling code can know how many bytes to skip.

There should be a correlation between the bitpool value used and the
length of the frame, but I didn't look into this. Even then one would
have to parse the frame header to know what parameters have actually
been used and calculate the length based on that.

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
