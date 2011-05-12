Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 May 2011 19:32:46 +0200
From: Filip Palian <s3810@pjwstk.edu.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: l2cap and rfcomm: fix 1 byte infoleak to userspace.
Message-ID: <20110512173246.GC11166@backtrack>
References: <BANLkTik7WyQ977-+8XapTgBrVRMyexyHKg@mail.gmail.com> <1305163800.15916.169.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305163800.15916.169.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Structures "l2cap_conninfo" and "rfcomm_conninfo" have one padding
byte each. This byte in "cinfo" is copied to userspace uninitialized.

Signed-off-by: Filip Palian <filip.palian@pjwstk.edu.pl>
---
 net/bluetooth/l2cap_sock.c  |    1 +
 net/bluetooth/rfcomm/sock.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 299fe56..581310f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -446,6 +446,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
+		memset(&cinfo, 0, sizeof(cinfo));
 		cinfo.hci_handle = l2cap_pi(sk)->conn->hcon->handle;
 		memcpy(cinfo.dev_class, l2cap_pi(sk)->conn->hcon->dev_class, 3);
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 66cc1f0..784af0f 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -787,6 +787,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 
 		l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
 
+		memset(&cinfo, 0, sizeof(cinfo));
 		cinfo.hci_handle = l2cap_pi(l2cap_sk)->conn->hcon->handle;
 		memcpy(cinfo.dev_class, l2cap_pi(l2cap_sk)->conn->hcon->dev_class, 3);
 
-- 
1.5.6.3

Found by Marek Kroemeke and Filip Palian. Special thanks to Vasiliy Kulikov for advices.

Best regards.
