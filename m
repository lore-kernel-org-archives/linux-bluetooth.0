Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] sniff mode
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <EFCD68F7BFDB06468769D4D9EAAA938709664754@scsmsx401.amr.corp.intel.com>
References: 
	 <EFCD68F7BFDB06468769D4D9EAAA938709664754@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1131738319.6542.4.camel@blade>
Mime-Version: 1.0
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
Date: Fri, 11 Nov 2005 20:45:19 +0100

Hi Trevor,

> See the output below.  It says "Unsupported Feature of
> Parameter value" -- so, I suppose this means either that the feature
> isn't supported by my particular BT device, or that I'm getting
> something wrong :-).  This is a fairly new SilliconWave dongle, so I
> would assume it would work...   (I've also tried with other devices with
> similar results).
> 
> The other question would be if I'm getting the parameters right, but...
> I'm not quite sure how to figure that one out. I've tried a variety of
> parameters, but they all end up the same.

use the latest hcidump. It might decode the sniff request for you.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
