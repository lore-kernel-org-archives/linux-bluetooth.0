Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1099151759.16247.18.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] RFCOMM service level security testing
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
Date: Sat, 30 Oct 2004 17:55:59 +0200

Hi Folks,

I released patch-2.6.9-mh3 some minutes ago and it contains the first
experimental version of the service level security implementation for
the RFCOMM layer.

The libs CVS is also updated to add the specific defines for using it
and rctest got some extra paramters for it, but it seems that the CVS
service for anonymous access from Sourceforge is broken and so most of
you won't get these modification. However this is not a big problem,
because you can use L2CAP_LM, L2CAP_LM_AUTH etc. for it. The values
behind these defines are identical and so this should work at least for
testing this new feature.

Please test this and send reports back to the mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
