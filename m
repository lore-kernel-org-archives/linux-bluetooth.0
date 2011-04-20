Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Apr 2011 14:04:32 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linville@tuxdriver.com
Cc: linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-2.6 2011-04-20
Message-ID: <20110420170432.GA2301@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

Four small fixes for 2.6.39. An incorrect refcnt balance for hci connection by
Ville Tervo, a warning fix in the command timer by Vinicius Gomes, an ERTM
fix by Ruiyi Zhang, and SCO synchronization fix by Luiz Augusto von Dentz.

Please pull or let me know any problems. Thanks.


The following changes since commit 332704a51498a7e29aa92c19dc03f11f80b71bfe:

  iwlegacy: fix tx_power initialization (2011-04-13 15:09:53 -0400)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git master
                                                                                                     
Luiz Augusto von Dentz (1):                                                                          
      Bluetooth: fix shutdown on SCO sockets                                                         
                                                                                                     
Ruiyi Zhang (1):                                                                                     
      Bluetooth: Only keeping SAR bits when retransmitting one frame.                                
                                                                                                     
Ville Tervo (1):                                                                                     
      Bluetooth: Fix refcount balance for hci connection                                             
                                                                                                     
Vinicius Costa Gomes (1):                                                                            
      Bluetooth: Fix keeping the command timer running                                               

 net/bluetooth/hci_core.c   |    5 ++---
 net/bluetooth/hci_event.c  |    2 --
 net/bluetooth/l2cap_core.c |    1 +
 net/bluetooth/sco.c        |    9 +++++++++
 4 files changed, 12 insertions(+), 5 deletions(-)

-- 
Gustavo F. Padovan
http://profusion.mobi
