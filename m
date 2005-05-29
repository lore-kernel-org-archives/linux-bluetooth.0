Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4299F497.5080608@egabriel.de>
From: ligi <ligi@egabriel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <4295E697.9060802@palmsource.com>
In-Reply-To: <4295E697.9060802@palmsource.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] l2ping and timeout
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
Date: Sun, 29 May 2005 18:57:59 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am confused about l2ping. The man says:
           -c count
              Send count number of packets then exit.

           -c timeout
              Wait timeout for the response.

- -c 1s - my first issue didnt work!
I need it to determine if a device is in range or out of range or off.
If anyone has even an better Idea than l2ping this would help me too.
A fast response when the Device is in range would be cool cuz the
early my light switches on the less I stumble ...


ligi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCmfSW3NorRo/jFWIRAnSLAKDf6D3eIGA5wQSm5SXa7nO6GZMUYwCguJ03
wNoaSXPYY14oOnzsWkntumM=
=86Ig
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
