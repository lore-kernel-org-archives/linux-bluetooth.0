Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: make RFCOMM sockets to inherit parent's priority
Date: Fri,  4 Nov 2011 16:03:50 +0200
Message-Id: <1320415430-2054-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320415430-2054-1-git-send-email-luiz.dentz@gmail.com>
References: <1320415430-2054-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes priority set on a listen socket to be passed when accepting
new connections.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/rfcomm/sock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 40988e2..81d658d 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -260,6 +260,7 @@ static void rfcomm_sock_init(struct sock *sk, struct sock *parent)
 
 	if (parent) {
 		sk->sk_type = parent->sk_type;
+		sk->sk_priority = parent->sk_priority;
 		pi->dlc->defer_setup = bt_sk(parent)->defer_setup;
 
 		pi->sec_level = rfcomm_pi(parent)->sec_level;
-- 
1.7.6.4

