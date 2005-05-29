Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <429A1405.4050708@egabriel.de>
From: ligi <ligi@egabriel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] l2ping and timeout
References: <4295E697.9060802@palmsource.com> <4299F497.5080608@egabriel.de> <1117390157.7072.98.camel@pegasus>
In-Reply-To: <1117390157.7072.98.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sun, 29 May 2005 21:12:05 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:

> Hi Ligi,
>
>> I am confused about l2ping. The man says: -c count Send count
>> number of packets then exit.
>>
>> -c timeout Wait timeout for the response.
>
>
> no it does not.


OK - my man says that - I have the newest from the gentoo portage -
but it is from 2k2 ... Is there a newer man for l2ping ?

>
>> I need it to determine if a device is in range or out of range or
>> off. If anyone has even an better Idea than l2ping this would
>> help me too. A fast response when the Device is in range would be
>> cool cuz the early my light switches on the less I stumble ...
>
>
> Use the periodic inquiry feature of Bluetooth through the HCI raw
> socket for this.
>
Is there anything in the standart tool base for this?
Any link / doc that lets me know how to do this?

> Regards
>
> Marcel
>
>
>
thanx
ligi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCmhQF3NorRo/jFWIRAuaUAKDgJqulNjBewc4WR/yT0bOywqGiQACg0lLi
nRFSUpyle8/3IYuATskpEuY=
=8mVc
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
