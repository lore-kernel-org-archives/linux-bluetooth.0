Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] [PATCH] tcsendbreak and flow control on
	hciattach(csrchip)
From: Marcel Holtmann <marcel@holtmann.org>
To: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <39417DF3286A66428FA558987839F44F152D9B@SINTEFXCH01.sintef.no>
References: <39417DF3286A66428FA558987839F44F152D9B@SINTEFXCH01.sintef.no>
Content-Type: text/plain
Message-Id: <1097497821.9474.15.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Oct 2004 14:30:21 +0200

Hi Dag,

> This solves the problem for me, but I do not know if it is needed for
> other Bluetooth chips or other hardware platforms:
> 
> This patch is against 2.9, but I believe it would be the same for 2.10.

please use "diff -u".

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
