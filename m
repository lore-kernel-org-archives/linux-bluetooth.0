Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AA4204B
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jul 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722066594; cv=none; b=rZ7q748UgIQszOqzp9+vmGwitePK8xAC04ew5+LKudek0o5Cpc4ZQ/bnQ8IOQAETadEO0IqUAvKDvrmn8SPDEOnTqoYxlPsMoNqN9s0OOzy4H6RfGu5iYu+mcdp63zzkHcH2JCstdjTVc0O012xFgAiW0bDws4bjxaSNOaxpTZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722066594; c=relaxed/simple;
	bh=5bvlGGXgCY+v9eouaSHuQc1RRdtlNwlXC70fpLaN9XQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JLLRUWfU1IqPHuju0cobUoAgEtZoOp0+nFVyix9e6w2VIqzUKaQ7R2Wd8C0VBqy+AnyjKvmYKdYM+w/DsXxICFtoaMp1sUZoBvur2XHzGKErqT2rr72qB7Cs24KkkW+23xa2L48kUpnlIAMl1JSjP+3zElt02oAYpVjgR3sTQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46R7nb2B035301;
	Sat, 27 Jul 2024 16:49:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 27 Jul 2024 16:49:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46R7nbwq035297
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Jul 2024 16:49:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7f815a56-34bd-4aea-9072-312cfdd0d80a@I-love.SAKURA.ne.jp>
Date: Sat, 27 Jul 2024 16:49:37 +0900
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] Bluetooth: L2CAP: Fix missing unlock in l2cap_conless_channel
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com
References: <0000000000004ee343061e257ed5@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000004ee343061e257ed5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting that l2cap_chan_unlock(chan) is missing.

Reported-by: syzbot <syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=45ac74737e866894acb0
Fixes: f1a8f402f13f ("Bluetooth: L2CAP: Fix deadlock")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c3c26bbb5ddae..9988ba382b686 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6774,6 +6774,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	bt_cb(skb)->l2cap.psm = psm;
 
 	if (!chan->ops->recv(chan, skb)) {
+		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
 	}
-- 
2.43.5

