Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Jun 2010 01:09:17 +0200
From: Dan Carpenter <error27@gmail.com>
To: Jiri Pirko <jpirko@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: potential bug in bnep_net_set_mc_list()
Message-ID: <20100618230916.GA5467@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is from ff6e2163f28a: "net: convert multiple drivers to use
netdev_for_each_mc_addr, part7"

net/bluetooth/bnep/netdev.c
   101                  i = 0;
   102                  netdev_for_each_mc_addr(ha, dev) {
   103                          if (i == BNEP_MAX_MULTICAST_FILTERS)
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   104                                  break;
   105                          memcpy(__skb_put(skb, ETH_ALEN), ha->addr, ETH_ALEN);
   106                          memcpy(__skb_put(skb, ETH_ALEN), ha->addr, ETH_ALEN);
   107                  }

"i" is never incremented here so the check is always false.

regards,
dan carpenter
