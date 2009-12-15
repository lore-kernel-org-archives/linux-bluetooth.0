Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1260813183.4041.15.camel@localhost.localdomain>
References: <1251085520-9094-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <508e92ca0912140236t2c93a8a1q3aae97cf9e7bdfd@mail.gmail.com>
	 <1260813183.4041.15.camel@localhost.localdomain>
Date: Tue, 15 Dec 2009 10:03:16 +0200
Message-ID: <508e92ca0912150003w6c12e0f5q9430c6fafb51e6ba@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add locking scheme to timeout callbacks.
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>, linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I am actually forgiving when people send patches as attachments since
> sometimes the corporate email servers are just stupid. However gzipped
> patches is where I draw the line. Please re-send it.

Please check patch below:

Subject: [PATCH] Bluetooth: Fix locking scheme regression.

When locking was introduced the error path branch was not taken
into account. Error was found in sparse code checking. Kudos to
Jani Nikula.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
Acked-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 947f8bb..6f5d98f 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1208,6 +1208,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	bh_lock_sock(sk);
 	if (l2cap_pi(sk)->retry_count >= l2cap_pi(sk)->remote_max_tx) {
 		l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk);
+		bh_unlock_sock(sk);
 		return;
 	}

-- 
1.6.0.4
