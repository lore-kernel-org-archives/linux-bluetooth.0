Return-Path: <cyrus@holtmann.org>
From: Ed Tomlinson <edt@aei.ca>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Bluetooth broken post rc7
Date: Thu, 14 Jul 2011 23:18:32 -0400
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Ilia Kolomisnky <iliak@ti.com>,
	David Miller <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201107142318.33080.edt@aei.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I booted to todays linux git and bluetooth is no longer working.  My magic mouse will not connect correctly.

Reverting: 

commit 9fa7e4f76f3658ba1f44fbdb95c77e7df3f53f95
Author: Gustavo F. Padovan <padovan@profusion.mobi>
Date:   Thu Jun 30 16:11:30 2011 -0300

    Bluetooth: Fix regression with incoming L2CAP connections
    
    PTS test A2DP/SRC/SRC_SET/TC_SRC_SET_BV_02_I revealed that
    ( probably after the df3c3931e commit ) the l2cap connection
    could not be established in case when the "Auth Complete" HCI
    event does not arive before the initiator send "Configuration
    request", in which case l2cap replies with "Command rejected"
    since the channel is still in BT_CONNECT2 state.
    
    Based on patch from: Ilia Kolomisnky <iliak@ti.com>
    
    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>

Fixes the bug here (things work like rc7).

Do we really need 9fa7e4f76f3658ba1f44fbdb95c77e7df3f53f95 in 3.0?

Thanks,

Ed Tomlinson
