Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000b01c31953$e3a50a90$1a01010a@baked>
References: <000b01c31953$e3a50a90$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1052834579.13864.191.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 13 May 2003 16:02:52 +0200

Hi Daryl,

> How do I get those 5 patches from the bt-2.4 repository? Or better yet:
> Where is the bt-2.4 repository?

you can find the repository at http://linux-bt.bkbits.net/ and you need
to use Bitkeeper. You have to clone to repository as specified in the
bk-kernel-howto.txt and after that you can extract each patch step by
step.

	bk export -tpatch -du -h -r<cset>

Another way is the BK->CVS thing, but I never tried it.

If you have problems with Bitkeeper and you need the patches now, I can
send them to you. The new -mh patches have to wait until I finished some
other things.

Regards

Marcel




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
