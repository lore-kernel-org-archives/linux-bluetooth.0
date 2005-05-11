Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42814E2F.1030503@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <1115722824.8949.242.camel@pegasus>	 <4280D256.1000804@xmission.com> <1115739962.12058.19.camel@pegasus>
In-Reply-To: <1115739962.12058.19.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-devel] Dealing with the bluez-utils dependencies
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
Date: Tue, 10 May 2005 18:13:35 -0600

Marcel

> So keeping the USB library dependency for a binary package is ok. The
> embedded people need to recompile with USB support.

if embedded users complain, have them make hid2hci etc building optional.

> All the PIN stuff is also working without D-Bus support.

oh, well that's good.

> It is already an own package called bluez-pin and not maintained by me.
> The problem is that for example the Debian bluez-utils package depends
> on bluez-pin and thus the dependency chain increases.

it could be changed to a recommendation if things are set up to fall 
back to a fixed pin number. it might be a lot of trouble if it's not 
required on the user side. i was pleasantly surprised the first time it 
"just worked" and ran the gtk pin gui.

brad


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
