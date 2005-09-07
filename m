Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Properly replace an existing key value
	pair in a text file
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <431F0F7C.9090006@tcs.hut.fi>
References: <431ECC4D.9030302@tcs.hut.fi> <1126094276.10631.22.camel@blade>
	 <431F0F7C.9090006@tcs.hut.fi>
Content-Type: text/plain
Message-Id: <1126114397.10631.80.camel@blade>
Mime-Version: 1.0
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
Date: Wed, 07 Sep 2005 19:33:17 +0200

Hi Ville,

> Yes. I located the problem in Gentoo's bluez-utils-2.19 and since it 
> hasn't yet been fixed in the CVS repository, I'm quite certain it still 
> is present ;-)
> 
> I noticed the problem when hcid just wouldn't update the link key in 
> var/lib/bluetooth/<hwaddr>/linkkeys, even though the debug statements 
> claimed otherwise. The textfile_put() function clearly works incorrectly 
> since zero is a valid value for the len variable, but the if (len <= 0 
> || ..) check causes the the function to exit before anything is written.

this sounds plausible. Your patch is applied to the CVS. Thanks.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
