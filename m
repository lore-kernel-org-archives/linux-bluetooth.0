Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45704F38.9030706@prolly.org>
Date: Fri, 01 Dec 2006 10:50:16 -0500
From: Douglas Ward <douglas.ward@prolly.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1164939683.18828.24.camel@TesterBox.tester.ca>	<456FD9EE.1070000@prolly.org>
	<20061201135958.GA14926@sus.mcgill.ca>
In-Reply-To: <20061201135958.GA14926@sus.mcgill.ca>
Subject: Re: [Bluez-devel] mx5000tools 0.1
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

honestly? i found a patch in the archives that was actually the
reverse of what was needed to switch it into hci mode. i'm not exactly
sure what happened with that but i wrote a patch that was the basic
reverse of said patch and tested it... its in 3.7 i think...
definitely in CVS. I've been happily using hci mode ever since... it
isn't perfect however. sometimes the hci device needs a reset to work
correctly but not always. also sometimes i have to run hid2hci
multiple times. It's a pain in the butt but since I never reboot my
linux box it's a rare necessity. i'm not experienced with driver
hacking so i can't be much more help there... but I wasn't prepared to
be stuck in hid mode after spending $230 CAD on the keyboard set.

Martin Stolle wrote:
> How DID you get it into HCI mode?
>
> Martin
>
> On Fri, Dec 01, 2006 at 02:29:50AM -0500, Douglas Ward wrote:
>> good work, i'll try it out tomorrow. maybe i can help figure out this
>> image issue. I'd hate to be stuck in hid mode after all the searching i
>> did to get the damn thing into hci mode though...
>>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRXBPN1KDmmHy9Q32AQJvJhAAnB7xKOuqHcpPPd4lKeU59lGr/PbbKkJs
nyqNtFnqnwPBE63xHdvk86CxOWspdFYOlHLjfgak/vYE+JNjK9QUoSqbRAjRsLZ7
IA1XHbEZSGtA9dE63xQEfUWt1ldI7ewgXwzQ3uR9EYEo6V7uA764Gb9VVcGEjkLj
TTQvkSiDoLjVlRehyBwPp+OA1Wzk1KYyD0K+PlDO3nRKsFxTkmphwEX8ICRcqzlZ
LrgP8/LrOTOTbiLvo2IjUL/ayLb1gVS73IcjHJUpT66Wq/AtbSOKnlkhmrSYx4gj
+pk96SjJsXOMJ3yfZQLvF5uakBBnLOJUGfhHZJLY6Zm8x4+39Ih3S8RjP+y3oVuQ
OwSbXTLZ+/WXXmQK8kz37wqA8cAF/xNKP3Ct3cP/fnS6oyQBNO3/znx2GimTnQO5
d+5DdkJD9IET1mAmsRr+vq7bSCnTdOT4D/QwNyLs6wLcqeOVC15VzN9Kl9DeQzmD
YbEmmxaHuNdYj8BUvjZyCrpZ3B2v2YcRID3cO8krauDtWMMXGfRaLxPqgRXFdEp4
ElHG5oC/9x3XAn5gS1DXZATxb5INNjyErzsVkIUMmtoHJVk+c8tBlOoJ9Si3r0JR
Z3UgrqmtpRc5jcyilEOrHWduJ5s7G7j0Vo1JSeOSN72SZ3mWSSX98sEoTGz/M/pi
+ReR/vRhd0A=
=LPCb
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
