Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <458BCA8D.5030001@jambit.com>
Date: Fri, 22 Dec 2006 13:07:41 +0100
From: Frank Heimbaecher <frank.heimbaecher@jambit.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F6B7AE.1030209@jambit.com> <4582A310.60905@jambit.com>
	<4583A020.2040808@xmission.com> <4587D051.8080703@jambit.com>
In-Reply-To: <4587D051.8080703@jambit.com>
Subject: Re: [Bluez-devel] How to use sbc.c ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello

I found out that sbc.c, as it is, works for big endian. On little endian
machines you cannot recognize an audio file after encoding and decoding.
So I changed the code a bit:

sbc_decode():
// fh 20.12.06: original source code assumes big endian
// so we have to change the order of the following 2 statements
*ptr++ = (s & 0x00ff);
*ptr++ = (s & 0xff00) >> 8;

sbc_encode():
// fh 20.12.06: original source code assumes big endian
// so we have to exchange [0] and [1] here
int16_t s = (ptr[1] & 0xff) << 8 | (ptr[0] & 0xff);

Would it be a suggestion to work with a macro LITTLE_ENDIAN here?

And very interesting for me: Are there other places in the code that
need to be adapted to little endian? Because the result after decoding
is still poor: volume is too low, speed is too high (probably data
missing) and sound is quite shallow. When I write the resulting data to
a file, it is smaller than the original.

Thanks for help
Frank

-- 
Dipl.-Inform. Frank Heimbaecher, Senior Software Architect

jambit Software Development & Management GmbH
Nymphenburger Strasse 13-15, D-80335 Muenchen

http://www.jambit.com    where innovation works

Tel.: +49.89.45 2347-42
Fax:  +49.89.45 2347-70


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
