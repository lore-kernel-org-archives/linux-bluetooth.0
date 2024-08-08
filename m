Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AB218A922
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Aug 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113641; cv=none; b=OH9xc4f2O2TJf5JTcqDM7rxyxRVwiE4Ii3CLonimHcGY79yx19zuJOMCaJOLpf1C8b9z0O0LKRIyronsjzNbGGWaWo4HJ3f7YcnhxBMf55i1+A9YoJ++3q7xByRoxBtyYyugSoyurTzfhQ7uEfXIYYus7LWIdtcQmK7K61bJtfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113641; c=relaxed/simple;
	bh=kODzgVI1TluZZIddHpBvW0ElTZwEdXb/qgX3yNC7Awk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGJopeHXM4nIA46poqLs+od8UOFMRcTVe/JdjBLUUEE/Nh2re/kzUsaGoVAGM566XW2En5qCUEdiitYuWvlQvcIATqv5FjWTAIqmiDY0VL+HeHe0jkeLmam6jJFCJlFz7tWqfFCVQSEEXhJL+ATd3ZpLmC0onq6kpeHrdR62Bmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.75])
	by sina.com (10.185.250.21) with ESMTP
	id 66B4A00A000050AB; Thu, 8 Aug 2024 18:38:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8245633408333
X-SMAIL-UIID: D51D29BBBD6740BABCD5E7D8CCCA9FD9-20240808-183805-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pm?] INFO: trying to register non-static key in netdev_unregister_kobject
Date: Thu,  8 Aug 2024 18:37:54 +0800
Message-Id: <20240808103754.2783-1-hdanton@sina.com>
In-Reply-To: <000000000000795a2506196e7cd5@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 05:16:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    e67572cd2204 Linux 6.9-rc6
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13274a87180000

#syz test upstream  master

--- x/net/bluetooth/hci_core.c
+++ y/net/bluetooth/hci_core.c
@@ -2598,7 +2598,7 @@ int hci_register_dev(struct hci_dev *hde
 	if (!IS_ERR_OR_NULL(bt_debugfs))
 		hdev->debugfs = debugfs_create_dir(hdev->name, bt_debugfs);
 
-	error = device_add(&hdev->dev);
+	error = device_register(&hdev->dev);
 	if (error < 0)
 		goto err_wqueue;
 
--
