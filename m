Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB0173;
	Sat, 15 Jun 2024 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416269; cv=none; b=JV+Hv46eLsdWdPHYLA/hj4K82G8JPPYPUJnzlGj4nhyOuhRvOsH35pIKAi4s9gMi8jT8ChVnyenz3Lfup7U5BVscR+vGM4L/bBNgLPRssosr8YClGyIuoLppHNe3FxyOginTMpv16c5vB9TS93jf4WaGIf5TsLQ+FioMsVP6kUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416269; c=relaxed/simple;
	bh=I0OxXa9DgS8CNov9zFCmY334i6ViZ/0pIgrmqKDoC8U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Q/aKEuC3ixLQMyLPUtGXzu3rPIcspBa1n5gC+RWw0xbqu1TnLbm8tHRwlJYCX7UJr3phrzvrUHrYzFiAtPy4NyjTXedttjDjTMhVdCRPmw/ylLKd8S8+ZWutbp6XjLmznewbxc2imKq4nQL+4SUlAzsSmf19nFzf925AfvrOceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EQxEAqsH; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EQxEAqsH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718415956; bh=BliPspMfZpsfUZHQ6OIFoJYpdtijvhqaem6dtHKkTHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQxEAqsHEWDO7UuMl7QhInY9w6SY2ej5GrRZgrRyCo9O/uyRjjUPSUyt/nKYChfXq
	 sZdSit6cXe898DPnBhwh/cMVe3pe9X0G/tvhavOy6dMifr9x0NLgAsMlkbQjvVNi5I
	 DEiBSJeWIALmlMLGP6PIIDX3khTi2lX+vWmem0EU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B758D0B6; Sat, 15 Jun 2024 09:45:53 +0800
X-QQ-mid: xmsmtpt1718415953thiu5vney
Message-ID: <tencent_8D9918CF808DC6A5FF8DCB12055DECDDF107@qq.com>
X-QQ-XMAILINFO: Mg/0DM1Zd+nHD5TKWnIAKflqlS7gH06+79ZA7FoSIoEVqm0uA2J5eHDrzeu02z
	 rYfWTkIWkhNmVlXQnHNR9kqqtCvPzcTK5I8hjyPziqr+Ntcz2sr5GXeQzv+QaotA0l6ZVm8TG2Kv
	 Qt8gT02EltLJS+nsJEZv6xEzKlungZN0wOef5+ybT8YCMqs8guF68VxWEOyciDsjWc+kNJ9MFexM
	 K7ceoxcilNTAXzZXxTsdpnNTJX8hSYzzPULx6boHRJQ9M+hWfmQv47yMzD1zzq1y7bekNTCtLiBx
	 ClxSOESbX97WEiU6yeD1QpKbt/jAg1RzfyJxkeTnqVr7omFBqxcn5gTJUm5Y8ZjFMw+swPSDSAv6
	 FhkHr/xyqbYG1xOEDo6H+voOr0QpZPdxmVmghdornb/D9B7vO4LJV1LNsH4guTG8JaltSXBIl2hT
	 xbNAOLnFQFurxsQ81togNoUaulpLujRr3xo0dZUQ5eKR2Y7wMVNwtiWsbitJdn/lshF0bZIYwFJ7
	 QpgU0afxZScpOanDJK8TdTngMHomKR0AP+itZU4p3/C5Ts6Wb/oTa9qA0TPM0Joa5JCVt3+skguU
	 4T8+t5AlkmKmvoqFYXV8cdIayU6GK8IRmND4Ddaksz0WCiMxJPHf8U4sJXJczCKa9gyf/G9c5Us1
	 g+trQnCE0KCQMJZ/hKbxwgQ+QSpN3MFoUDNCaRDSew5sg6jkrU98TS7a8yr/fbt/Y8TMVkbCgY4/
	 5ghhFCaGRX/Ud/ZM2pSHzoVqDb83NpgORtF8alj5OF0/x38Sf3GnBye83aX88SUiFsU5JOz0i7t1
	 Sz6C7r2/yAX0FxaE8xJMtLepkVWyIU01xjUu1n/w4yNXDqlNG3SpUyAkJ2+wRIlnmvDhgBAhxCvs
	 KMhzdqv1DEs/yRzc5GGYmSqPiszynh58J+J+Yd25lU5q1ty5d8c/T2fUcqRtq/U8IdGdo3fYmqDh
	 01UtpJwNZoGsuLHALCXw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: luiz.dentz@gmail.com
Cc: eadavis@qq.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] bluetooth/l2cap: sync sock recv cb and release
Date: Sat, 15 Jun 2024 09:45:54 +0800
X-OQ-MSGID: <20240615014553.3405535-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZKArASNApkJPvJn8C4HE0y5aZy0X2ZrOjjdrsDhBO+7rQ@mail.gmail.com>
References: <CABBYNZKArASNApkJPvJn8C4HE0y5aZy0X2ZrOjjdrsDhBO+7rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The problem occurs between the system call to close the sock and hci_rx_work,
where the former releases the sock and the latter accesses it without lock protection.

           CPU0                       CPU1
           ----                       ----
           sock_close                 hci_rx_work
	   l2cap_sock_release         hci_acldata_packet
	   l2cap_sock_kill            l2cap_recv_frame
	   sk_free                    l2cap_conless_channel
	                              l2cap_sock_recv_cb

If hci_rx_work processes the data that needs to be received before the sock is
closed, then everything is normal; Otherwise, the work thread may access the
released sock when receiving data.

Add a chan mutex in the rx callback of the sock to achieve synchronization between
the sock release and recv cb.

Sock is dead, so set chan data to NULL, avoid others use invalid sock pointer.

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/l2cap_sock.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6db60946c627..f45cdf9bc985 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1239,6 +1239,10 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
+	 * sock pointer.
+	 */
+	l2cap_pi(sk)->chan->data = NULL;
 	/* Kill poor orphan */
 
 	l2cap_chan_put(l2cap_pi(sk)->chan);
@@ -1481,12 +1485,25 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
-	lock_sock(sk);
+	/* To avoid race with sock_release, a chan lock needs to be added here
+	 * to synchronize the sock.
+	 */
+	l2cap_chan_hold(chan);
+	l2cap_chan_lock(chan);
+	sk = chan->data;
 
+	if (!sk) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		return -ENXIO;
+	}
+
+	pi = l2cap_pi(sk);
+	lock_sock(sk);
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
@@ -1535,6 +1552,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return err;
 }
-- 
2.43.0

