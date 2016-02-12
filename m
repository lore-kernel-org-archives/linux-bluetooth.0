Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 12 Feb 2016 11:05:42 +0100
From: Maxime Chevallier <chevalliersebmax@gmail.com>
To: johan.hedberg@intel.com, linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH 0/1] lib : Add hci_le_set_advertising_parameters
Message-ID: <20160212100542.GA32201@vps217108.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I realised I didn't follow the submitting rules in my
previous attemps submitting this patch.

This patch adds the le_set_advertising_parameters
function to hci_lib. I hope this function belongs here,
please feel free to make any comments.

This was tested with a marvell 88W8887 controller.

Maxime Chevallier (1):
  Added set_advertising_parameters function to lib.

 lib/hci.c     | 39 +++++++++++++++++++++++++++++++++++++++
 lib/hci_lib.h |  5 +++++
 2 files changed, 44 insertions(+)

-- 
2.1.4

