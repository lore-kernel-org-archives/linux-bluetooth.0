Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472838AC6E
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778971225; cv=none; b=a8s/qsvCDFHFNJfbsQ+sqSTu3oVTYgXnwB8euZbR2ZB88sQC3wRh86d3BeNQXaRUtJDoOJMja1hSqb5HimTeMmqP6Qi0iy6vVDcRk9LtznPmxxzGqMxtsNxnq7An6PAvgYP9lzLUCVH09j6h8Vfm/0fqWWVsjS01ZWJofxqBy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778971225; c=relaxed/simple;
	bh=MDwqzzPxpTpr7wvYUP7Ufir6bdMVkAztbi1Zb4r8XeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmKwL0Te4vb5OAx0OwfsM739gbQ18+fVJ8yYmK7nKwIx7F0ARflKgNfd5Xl8MmU/N3IKks3gcc5ofVFmnFfZ3zYt7VQvIB21q9MGsd9zI/cOtKTfjYnMWv83xnpYR2qSeW1t+Cl9WptpZBMBUS+zK6LYN5mtWbtKDS0CW/SUKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=KWjcgPDG; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="KWjcgPDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1778971222;
	bh=6+dytzmVokVDStxNbKqqHM9kTlgMW+5d48+NzqFuckA=;
	h=From:Subject:Date:Message-ID;
	b=KWjcgPDGM/fvzk6cm5P1BiOsHDIGatN6A+/0DRXMvjc/2fIqFKKC3OMWA1fXk9ox2
	 WK9/BfVdcAw8zzW9iNThyHdpdgff3DSTDrgSd6REBKBB4N9VO/cwfzejIsODo/yFht
	 +SSQh7YG6uXSNV1wgeAuR0+mfUGY/lHhwxBYGfWc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A08F24B00002E91; Sat, 17 May 2026 06:40:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2650226685180
X-SMAIL-UIID: B2818D37D17A480695A921A8E0DDA772-20260517-064013-1
From: Hillf Danton <hdanton@sina.com>
To: Safa Karakus <safa.karakus@secunnix.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
Date: Sun, 17 May 2026 06:40:00 +0800
Message-ID: <20260516224002.754-1-hdanton@sina.com>
In-Reply-To: <20260516181504.3076260-1-safa.karakus@secunnix.com>
References: <20260516092139.2618159-1-safa.karakus@secunnix.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 21:15:04 +0300 Safa Karakus wrote:
> bt_accept_dequeue() unlinks a not-yet-accepted child from the parent
> accept queue and release_sock()s it before returning, so the returned
> sk has no caller reference and is unlocked.
> 
> l2cap_sock_cleanup_listen() walks these children on listening-socket
> close.  A concurrent HCI disconnect drives hci_rx_work ->
> l2cap_conn_del() which runs l2cap_chan_del() + l2cap_sock_kill() and
> frees the child sk and its l2cap_chan; cleanup_listen() then uses both:
> 
>   BUG: KASAN: slab-use-after-free in l2cap_sock_kill
>     l2cap_sock_kill / l2cap_sock_cleanup_listen / __x64_sys_close
>   Freed by: l2cap_conn_del -> l2cap_sock_close_cb -> l2cap_sock_kill
> 
Feel free to add the regular KASAN uaf calltrace to help understand your fix.
