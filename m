Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E519DF9D;
	Thu,  3 Oct 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965734; cv=none; b=XkylLRZIuJo3fCBX8Vm2PrcoMSSzTlBTVcCv6VxLCgHFrypvl/fj48Y63rdaZXCD6Z10Xbtqv5WOHxJBWHP3AY2C0Fd5LdQcAvLLgSCzTdNfvMlVAPE9KhBUL2SYfN17aFp7v3o2H5yMjUCUE2MuRhYB5XRRAxq9HnciLHU2UH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965734; c=relaxed/simple;
	bh=Kb0x/26TYRqZxPb6qmWEVa8XyqmU83s/wqbgbkI7LC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsvJ+DeaIFDZLxL//isEsYQcguJ6wwGrokYdHvTL/IwqB/EgsrjJlY4ZPqGkBP/25jq6HJEOtGXy7pM8wn08TOMdgCbd8TLXSVcW7JZPrvTkrVdmAyYHprVeOEbbi4ALby57AoAdmqQAE+W0kpcJBkRrW32KFRchrpdBfZBOsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N2cZys8M; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N2cZys8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=//iRvm/yY0slAVRPzkdXEEZUm5gMFFVlQPK3B3aedpg=;
	b=N2cZys8MQfE4O+wiuE6GlTsexCz4RhcmDMSWkDU7mzYbqfdqsmRJ07E3XxIs5B
	XLxwL6k4vQxQUcvvryhA9PRjNp3FrSU1OJcYGQRJ+J937XEDeUnDI8RCH/JK2OhK
	WxwmRxJ2sLH/IStgqaLE9d8RzJOCw/2RpJ64wWvoJDr5I=
Received: from localhost (unknown [36.5.132.7])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3_68Oqv5m4qIvAw--.58153S2;
	Thu, 03 Oct 2024 22:28:30 +0800 (CST)
Date: Thu, 3 Oct 2024 22:28:29 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 set_powered_sync
Message-ID: <Zv6qDfzdXMrSjGkE@fedora>
References: <000000000000932e45061d45f6e8@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000932e45061d45f6e8@google.com>
X-CM-TRANSID:_____wD3_68Oqv5m4qIvAw--.58153S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW5uF1UKF4kZFykJrW5KFg_yoWxZFb_WF
	1Ivay7Wr15CFWYqFsFkF17ZFWkAFySgF1xC3yjvrW8K3sIga1DAr47ZFn5Ary5uwsrA3W3
	Crn8XFySyrWUKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRknY3UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBRtamb+n-aA-gAAs8

#syz test

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5533e6f561b3..259b18eb0b20 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5187,8 +5187,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
 
 	if (!auto_off && !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-	    hci_dev_test_flag(hdev, HCI_MGMT))
+	    hci_dev_test_flag(hdev, HCI_MGMT)) {
+		hci_req_sync_lock(hdev);
 		__mgmt_power_off(hdev);
+		hci_req_sync_unlock(hdev);
+	}
 
 	hci_inquiry_cache_flush(hdev);
 	hci_pend_le_actions_clear(hdev);

-- 
Best,
Qianqiang Liu

