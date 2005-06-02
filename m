Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <429F5605.2070705@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Linking to BlueZ from non-GPL code
References: <EFCD68F7BFDB06468769D4D9EAAA93870774B6D7@scsmsx401.amr.corp.int	 el.com> <1117662296.31350.31.camel@pegasus> <1117688464.3908.6.camel@localhost.localdomain>
In-Reply-To: <1117688464.3908.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 02 Jun 2005 20:55:01 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Fredy P wrote:
> El mié, 01-06-2005 a las 23:44 +0200, Marcel Holtmann escribió:
[...]
>>>Is this still the current status of GPL/LGPL for the BlueZ libraries
>>>(libbluetooth.so) -- or has there been an update (I haven't found
>>>anything more recent on the mailing list about this).
>>nothing has changed at the moment. Ask Max for an update of changing the
>>BlueZ library from GPL to LGPL.
> For the free software and open source interest is not good idea change
> GPL to LGPL, can read this:
> http://www.gnu.org/licenses/why-not-lgpl.html

This debate is almost as old as the free software movement or the
introduction of the LGPL respectively.

The question is what you intend to achieve by putting sourcecode under
the GPL or LGPL.

Concerning libbluetooth I would strongly and also urgently propose to
put it under LGPL for several reasons.
First of all is that libbluetooth is part of BlueZ which is the official
Bluetooth stack for Linux. It should not limit the use of Linux in any
way. The limiting factor here is that GPL on a library renders all
programs that use it into GPL. For commercial software vendors this is a
no-go.

Yes, in an ideal world we would not care much but our world is far from
being ideal and currently I would strongly prefer wide use of Linux than
limiting the use.

LGPL on the library itself assures that the lib will remain free and
that changes to it will be put back into it. For a library there is no
need to be GPL. It simply limits its use which is not good.

So please yes, try to get hold of Max and ask for his permission...


Regards
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCn1YFJXeIURG1qHgRArjkAJ9efx3jQrLt9O2Znj46BavwZzK0SQCfU4uL
fKg+pkeilCsGJKX7BXSkWro=
=IJkL
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
