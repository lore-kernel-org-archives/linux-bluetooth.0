Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech MX900 oddities and solutions
From: Marcel Holtmann <marcel@holtmann.org>
To: fd@cisco.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078917509.32636.453.camel@metal.cisco.com>
References: <1078912919.32148.356.camel@metal.cisco.com>
	 <1078915401.2537.14.camel@pegasus>
	 <1078917509.32636.453.camel@metal.cisco.com>
Content-Type: text/plain
Message-Id: <1078918790.2537.29.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Mar 2004 12:39:50 +0100

Hi Frederic,

> I forgot to say that. The problem is that it did not compile anything
> (Make says there is "nothing to make for all"). I may have done dirty
> things while fiddling around. I will try downloading again from CVS and
> do it cleanly.

I checked it again and if you give --enable-compat to libs2 and utils2
configure everything will be compiled.

> Don't you thing hcitool should be made current and not just "compat" ?
> It is a precious tool...

Actually my replacement for hcitool which uses the new Bluetooth library
is not ready and every code in compat uses the old library.

> You mean the multibyte stuff, right ? What about the -mh4 patch, util2
> and lib2 ? Will they be made grand public soon ?

Sending in the multi-byte patch is job of the input guys. Everything
from -mh4 is already present in 2.6.4-rcX. The libs2 and utils2 will
take some time before they go real public.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
