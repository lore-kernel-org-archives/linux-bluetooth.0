Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Feb 2011 17:12:22 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [PATCH v2] Bluetooth: Use ERR_PTR as return error from
 hci_connect
Message-ID: <20110227201222.GE2166@joana>
References: <y>
 <4d640a47.a21fec0a.065e.466f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d640a47.a21fec0a.065e.466f@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

* anderson.briglia@openbossa.org <anderson.briglia@openbossa.org> [2011-02-22 16:10:53 -0300]:

> From: Ville Tervo <ville.tervo@nokia.com>
> 
> Use ERR_PTR mechanism to return error from hci_connect.
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c   |    4 ++--
>  net/bluetooth/l2cap_core.c |   10 ++++------
>  net/bluetooth/mgmt.c       |    4 ++--
>  net/bluetooth/sco.c        |    6 +++---
>  4 files changed, 11 insertions(+), 13 deletions(-)

Patch is applied now, but I had to fix it, your error handling was still
wrong. Here are the changes I did to your patch:

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0bbb6c6..c9f9cec 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -841,7 +841,7 @@ int l2cap_do_connect(struct sock *sk)
        struct hci_conn *hcon;
        struct hci_dev *hdev;
        __u8 auth_type;
-       int err = 0;
+       int err;
 
        BT_DBG("%s -> %s psm 0x%2.2x", batostr(src), batostr(dst),
                                                        l2cap_pi(sk)->psm);
@@ -869,6 +869,7 @@ int l2cap_do_connect(struct sock *sk)
        conn = l2cap_conn_add(hcon, 0);
        if (!conn) {
                hci_conn_put(hcon);
+               err = -ENOMEM;
                goto done;
        }
 
@@ -890,6 +891,8 @@ int l2cap_do_connect(struct sock *sk)
                        l2cap_do_start(sk);
        }
 
+       err = 0;
+
 done:
        hci_dev_unlock_bh(hdev);
        hci_dev_put(hdev);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 26f2f04..42fdffd 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -204,6 +204,7 @@ static int sco_connect(struct sock *sk)
        conn = sco_conn_add(hcon, 0);
        if (!conn) {
                hci_conn_put(hcon);
+               err = -ENOMEM;
                goto done;
        }
 
-- 
Gustavo F. Padovan
http://profusion.mobi
