Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <422F838B.2060700@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco volume commands
References: <Pine.LNX.4.62.0503092351590.6694@block>
In-Reply-To: <Pine.LNX.4.62.0503092351590.6694@block>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 09 Mar 2005 16:15:23 -0700

Guys,

I made the change in cvs.

My ericsson headset stopped working, so I'm going to ask people to try 
out the current cvs and let me know if there are any headsets that won't 
accept volume changes prefixed with AT. I'm surprised it worked before.

Florian--which headset are you using again? I remember hearing about 
this problem on the Motorola HS-801 at least.

Brad

Florian Echtler wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello everyone,
> 
> I noticed that in btsco.c from CVS, line 465 and 470, the string
> that is to be sent to the headset seems to be lacking an "AT" 
> prefix. After adding that, my headset now correctly changes its
> volume when done via alsamixer (previously, it ignored that).
> 
> If desired, I can prepare a patch.
> 
> Yours, Florian
> - -- 
> Preserve wildlife - pickle a squirrel today!
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.6 (GNU/Linux)
> 
> iD8DBQFCL39q7CzyshGvatgRAqDAAJ9N8jKS7IMcZryqctfxTNjM9UoIFgCg2Vop
> VNn5oa7oazG22PPYY6mH6Mg=
> =cdwz
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
