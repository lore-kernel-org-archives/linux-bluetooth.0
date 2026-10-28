Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175204;
	b=ni4ePjMgSPAqhkcTcyLZg+6kEKPhl9+wwy4KhDEu7chUSVbe0VldwxvqEzC8/VL0Yixz
	 u80qVSPKQ+bwq+D4RU7lM5pdt4CTbTmHnqgAxayAciH5ZBlMmJLWXq8JiyPawUasjjte/
	 0XUFmPAbRGsGJIovKaP9QFpZ/wmxCB8iEzgsBxFR+HKRVDHs+AUdPlRpzJCqr73p4orWA
	 cPHxida1dVigB2L5feMzUX30vTecRpPLufTWqSSDmdNO++E9edgiwAmcgZgeYgGXiogG+
	 HADzhWLgM6hv/ZDfWtKpcEVkr5yXioIxGAjkBu/ESoY14ILmEagdPsN2td0ABsAK9lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175204;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=WV/r+4sWZBdElVQxtKMn2ptupq6J3p+CEZC0CHn3HIc=;
	b=5Sn24i+8C5jj8/K0uYrtX9Z9UEon9oWwEEv+nrMh4Pyqm4FkGfki+0jXoqCjJXtDjJFu
	 rlBNpy+EM9xHBiJfgVyDgErhQt9UI3HHAiBZr2EpH4RtTsFKv9W0llv8rvcSdxqbV4dzV
	 HmXdQd8ywyL0BCadmGAXnp0tIyrWTpDU0mYDqF1SYxavhuBDIA6wq7lZUsCZ5PqyDsSat
	 213lqeQNcYUGmV9uzPm4/JnMECjHv4OfViCOkm3+nfJZv+NyhcwUOQ/UgiG77Fbo64kkb
	 cKcBvR2sCL4fRKX6JRaxYWN58BXMZQP+FgWxLVeaQ47aoyzL/yhLJPpX+Jr/E/pupjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CqAo67WS;
	arc=none smtp.remote-ip=203.205.221.190
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB6606A321;
	Wed, 28 Oct 2026 08:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFAB6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CqAo67WS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793175180; bh=WV/r+4sWZBdElVQxtKMn2ptupq6J3p+CEZC0CHn3HIc=;
	h=From:To:Cc:Subject:Date;
	b=CqAo67WS9utRjhZKZB9pDnU0F6YFdCzKjNU417EesOd5h1jIWBxJM4y9nrWZr9aTb
	 wJWrAG5lUsqtRwTzSpgo/TUuvjlMYF1xqng9k7h4JiZcWYXA2f230oSdvSPw9VSI+U
	 p57FXNmCRZWlcRSfoj3M8DnKdRG1CgxmytCHbTHc=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 33AA1E74; Wed, 28 Oct 2026 16:12:58 +0800
X-QQ-mid: xmsmtpt1793175178ta81eiyj6
Message-ID: <tencent_13E8A8381F9A288CD4F9EFE391122712D307@qq.com>
X-QQ-XMAILINFO: MAUQIEZVArhL7xRxH8sL4S1et+bi/3ASSrp4Piw3Y62ivnLmCoVEoW+6OGjq7a
	 1PHT5LSUQnv6nAFVuO4gGlWLT/puvRstNSyUjNwTDUQ2Vqtf8EOCv53trGwF37tA7pKx1zRkeA+M
	 zX3devxlYgnlGsdup+geHKxM/peYrRKQNAOnQoMOPAiwy8SuLN2TtzHzYQ32+zoeQYpoQoQh21Rn
	 pO+lHSi1LI7KMJnc8GyqGrkaXiL9GY6VXTbErmv5aVrhz8RWTjgZxlfShIQtnseYguPJZxbZH9r/
	 XWIONvjOolvAqj9+e0FNyikm+1VETGCywbCPr53JmhCYofZKgC2VzAhaBNTgN5AV0/5b7sSqQzd1
	 ZAn0vG+8gxwtPEsv0jUV/CUx0U+xWLQiRJu+KVgBx8Ma27c+37EBFMKR6fz9UCVQOMomqzT6/VCZ
	 wwyTA71YDK+7g/gLOA7XiHrfkR0s7SInU/IV7pBXUBE9FoV7Em4vwDcxbIdjMsGH5ZS64lDiZ93T
	 +tQJpnBz2rXTtUsq1SJF33GAvLP4iC03sa4OTHRT6alSiYyKVjDMp1I7zlgzgrAculuZ8WRqStwP
	 FR0t91Pews90O9H1DyOEr6y2PjnMGirhe9aGotoS8waiiK/Pv9wlgB05bj2Yjjv/ELdDg0/iqN1a
	 T51YA2qeLy1zXu2jWm4hq2uUDNljFD5pZF0hcgzVF3SIN1XGeiks0piourpGpVCGuV2kQi+MIBWn
	 NXuNG/QIQ7XBsb4gtxdhfAAq49vj3HlFMyP4stPssc2SDXtxdcX90aopWZOdwNzv7AlEKitlQEZz
	 UIMTStXZA1Ix9n2WjFyHBuop6aCI4V5iQ/rWhdqb3y/J5+GTTG0kGo8WkFeOuxJI47hI+V+uqrBu
	 Ka9j51TA+Y2bmSUdH5HA/98gmBjGNuv+jGjYg42jZE6RpAQZRE5MFe0IxcJmy70VWaTpLbrmVkNC
	 UdFSVtaQrhE9YYT33bku1km2K3plWK4vU2yTx43XPI8KM4cr0/rwWuZe5OSkkRkuaDJVNAsEWxR/
	 b0uzkFWVADS1pFmwhhg8ALMgGsmBJ17Ml5AlJ/YK/WID0h4tddkfwDQltTNKo=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Yang Guikun <yangguikun19@qq.com>
To: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject:
 [BUG] Bluetooth: cmd_work queued into draining workqueue in hci_cmd_timeout()
Date: Wed, 28 Oct 2026 16:12:58 +0800
X-OQ-MSGID: <179317517818.40652.12402169261900132377@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

hci_cmd_timeout() queues hdev->cmd_work unconditionally, without checking
HCI_CMD_DRAIN_WORKQUEUE.  When it fires while hci_dev_close_sync() is
inside drain_workqueue(), __queue_work() sees __WQ_DRAINING and warns:

  workqueue: cannot queue hci_cmd_timeout on wq hci1

Call trace from the crash:

  __queue_work kernel/workqueue.c:2304
  call_timer_fn kernel/time/timer.c:1748
  expire_timers kernel/time/timer.c:1794
  run_timer_softirq kernel/time/timer.c:2405
  ...
  touch_wq_lockdep_map kernel/workqueue.c:4037
  __flush_workqueue kernel/workqueue.c:4079
  drain_workqueue kernel/workqueue.c:4243
  hci_dev_close_sync net/bluetooth/hci_sync.c:5436
  hci_dev_do_close net/bluetooth/hci_core.c:499
  hci_rfkill_set_block net/bluetooth/hci_core.c:890
  rfkill_set_block net/rfkill/core.c:360
  rfkill_fop_write net/rfkill/core.c:1316
  vfs_write
  ksys_write

hci_dev_close_sync() sets HCI_CMD_DRAIN_WORKQUEUE before draining:

  hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
  synchronize_rcu();
  ...
  drain_workqueue(hdev->workqueue);

but hdev->cmd_timer is cancelled only after drain_workqueue(), in the
"Drop last sent command" block.  A cmd_timer that expires during the drain
therefore reaches hci_cmd_timeout() and queues cmd_work into the draining
workqueue.

Three producers already honour the flag: hci_cmd_work() (hci_core.c:4121),
handle_cmd_cnt_and_timer() (hci_event.c:3766) and hci_sched_tx()
(hci_core.c:3292, added by 6610c6fe4b89).  hci_cmd_timeout() is the
remaining one.

hci_cmd_timeout() runs from timer softirq, so unlike the tx_work producers
fixed by 6610c6fe4b89 it is not serialised against the close path by any
socket lock.

Reproducer: with an HCI device up and a command outstanding (cmd_timer
pending), write a "block" event to /dev/rfkill.  The rfkill handler
invokes hci_dev_do_close() -> hci_dev_close_sync(); the pending cmd_timer
expires during drain_workqueue().

Still present on current mainline.  hci_cmd_timeout() at
net/bluetooth/hci_core.c:1444 in d135ab453a74 is unchanged:

  atomic_set(&hdev->cmd_cnt, 1);
  queue_work(hdev->workqueue, &hdev->cmd_work);

The same code is in net (2cffcf1aeabb) and net-next (734bef548a96).

A fix in line with hci_sched_tx():

  atomic_set(&hdev->cmd_cnt, 1);
  rcu_read_lock();
  if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
      queue_work(hdev->workqueue, &hdev->cmd_work);
  rcu_read_unlock();

The effect is a dropped cmd_work and a WARNING; the work item is not
re-queued and nothing is freed twice.

Regards,
Yang Guikun

