Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE07F9E8
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017251; cv=none; b=TVmsEIqqAAAy5c2MxxMvod2KgmYn5A95a7sp9a1/hAeooRUel1B26VMHkLIpUDaryuZ6b2gdi88LT77DWg6ExauJWKdGLQC8WjRdd1a2rVVBT/Hk+vrCjkowIzPTdzU7LVUx/KXWsiF/ETO54F+yY1QkG1iz/27UWyuIPCewNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017251; c=relaxed/simple;
	bh=f9Mogg+jvZKEZ8qLwBmspRnlfU0+Btg1bLoW3fc+npA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=u9LEMNod788Ah5qHrV1fdwvvC4Dw305DkpaIoxlaB/rTaH9nhtNULkem7BfEAWRy0xFdGHC+fYI0mJxiXcaKStfVzdBntZAyirKVaxy/NWj54I7EzCNi2ag6lki9e86MMhB9g+ATfaVqE7ive8f1DxJpvgYWt/RXzGp5BNVKAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45AB0XkX036714;
	Mon, 10 Jun 2024 20:00:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Mon, 10 Jun 2024 20:00:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45AB0Xlr036710
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 10 Jun 2024 20:00:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7d6f0ed3-678e-4fd5-bd64-f980e0035b87@I-love.SAKURA.ne.jp>
Date: Mon, 10 Jun 2024 20:00:32 +0900
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] Bluetooth: hci_core: cancel
 rx_work,cmd_work,tx_work,power_on,error_reset works upon hci_unregister_dev()
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <00000000000097c554060f215b50@google.com>
Content-Language: en-US
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        syzbot+da0a9c9721e36db712e8@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000097c554060f215b50@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting that calling hci_release_dev() from hci_error_reset()
due to hci_dev_put() from hci_error_reset() can cause deadlock at
destroy_workqueue(), for hci_error_reset() is called from
hdev->req_workqueue which destroy_workqueue() needs to flush.

We need to make sure that hdev->{rx_work,cmd_work,tx_work} which are
queued into hdev->workqueue and hdev->{power_on,error_reset} which are
queued into hdev->req_workqueue are no longer running by the moment

       destroy_workqueue(hdev->workqueue);
       destroy_workqueue(hdev->req_workqueue);

are called from hci_release_dev().

Call cancel_work_sync() on these work items from hci_unregister_dev()
as soon as hdev->list is removed from hci_dev_list.

Reported-by: syzbot <syzbot+da0a9c9721e36db712e8@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Completely untested. Please do tests with lockdep enabled before committing.
Maybe it is too early to cancel hdev->{rx_work,cmd_work,tx_work}.
Maybe there are more work items which should be canceled before
hci_unregister_dev() completes. I don't know...

 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dd3b0f501018..dbbe5e2da210 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2751,7 +2751,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	cancel_work_sync(&hdev->rx_work);
+	cancel_work_sync(&hdev->cmd_work);
+	cancel_work_sync(&hdev->tx_work);
 	cancel_work_sync(&hdev->power_on);
+	cancel_work_sync(&hdev->error_reset);
 
 	hci_cmd_sync_clear(hdev);
 
-- 
2.18.4


