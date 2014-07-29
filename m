Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: marcel@holtmann.org
Cc: jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/7] 6lowpan: trivial iphc changes
Date: Tue, 29 Jul 2014 23:46:57 +0200
Message-Id: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this patch series contains some trivial changes. Changing current naming of
the header compression pointer. The current one is named hc06 which stands for
header compression draft-06. We are most rfc complaint for the things we
support right now. Other patches use some API functions which was introduced
in some previous patches and IPv6 API for detect ipv6 address-scopes instead own
implemented functions.

- Alex

Alexander Aring (7):
  6lowpan: iphc: rename hc06_ptr pointer to hc_ptr
  6lowpan: iphc: use sizeof in udp uncompression
  6lowpan: iphc: cleanup use of lowpan_fetch_skb
  6lowpan: iphc: cleanup use of lowpan_push_hc_data
  6lowpan: iphc: use ipv6 api to check address scope
  6lowpan: iphc: remove check on null
  6lowpan: remove unused LOWPAN_FRAG_SIZE define

 include/net/6lowpan.h |  24 -------
 net/6lowpan/iphc.c    | 177 +++++++++++++++++++++++++-------------------------
 2 files changed, 90 insertions(+), 111 deletions(-)

-- 
2.0.3
