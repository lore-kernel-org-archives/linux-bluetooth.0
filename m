Return-Path: <cyrus@holtmann.org>
Message-ID: <4A7B28D7.8040902@gmail.com>
Date: Thu, 06 Aug 2009 21:02:47 +0200
From: sancane <sancane@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: MCAP implementation in BlueZ
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
I have seen that BlueZ has begun to incorporate enhanced retransmission
mode support to L2CAP. This is a happy new because i work with medical
devices that have begun to incorporate health device profile (HDP) in
bluetooth communications. I would like to use that devices in linux and
i saw that MCAP is not included in the bluetooth linux stack so i was
thinking in develop it for BlueZ.
I've studying the possibility of integrate it as kernel module like
rfcomm does but  i have some doubts about that approximation. I think
that it is not the best place for it and i believe that is better
develop MCAP in user space.

Can anybody give some feedback before to start to implement this
functionality? advices and recommendations are welcome.

kind regards!
