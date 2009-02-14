Return-Path: <cyrus@holtmann.org>
From: Tomas Winkler <tomas.winkler@intel.com>
To: stable@kernel.org,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] btsdio fixes on error path
Date: Sat, 14 Feb 2009 13:02:04 +0200
Message-Id: <1234609326-583-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Please add btsdio fixes for error path to stable release.  Some sdio devices are not so stable so we are hitting this often and it leaves kernel in bad state.
Bluetooth: Fix TX error path in btsdio driver -  is needed for 2.6.27 and 2.6.28 kernel
btsdio: free sk_buff with kfree_skb  - is needed for 2.6.27 kernel


Commit messages as appears upstream:

commit 7644d63d1348ec044ccd8f775fefe5eb7cbcac69
Author: Tomas Winkler <tomas.winkler@intel.com>
Date:   Sun Nov 30 12:17:18 2008 +0100
 
    Bluetooth: Fix TX error path in btsdio driver
    
    This patch fixes accumulating of the header in case packet was requeued
    in the error path.
    
    Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
 
commit cbfd24a75f98fe731547d3bc995f3a1f1fed6b20
Author: Sergio Luis <sergio@larces.uece.br>
Date:   Sun Oct 26 23:08:48 2008 -0700
 
    btsdio: free sk_buff with kfree_skb
    
    free sk_buff with kfree_skb, instead of kree
    
    Signed-off-by: Sergio Luis <sergio@larces.uece.br>
    Signed-off-by: David S. Miller <davem@davemloft.net>



---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
