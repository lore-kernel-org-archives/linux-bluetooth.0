Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70143803A
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831439; cv=none; b=Gavbj2gUAFsAY/JBJfkt9FIRzDPSXOXYNzVJyuU8ZfCpYBDDzU1s0TKWrDMqtXdu5ZB7LqO+v7oCop6oKeY7CVrGmPUJYFFHarI92elJi/Wm6W0WI7tlH7COLH/LnRW6rsLCQW6/qkjKMLgcZQpOXGGPVxjJxS2BVYqGnDXdnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831439; c=relaxed/simple;
	bh=zAiIqjEq1PJzlL9PdRrntSGjgYjD8Cqnn1b2Cqti99w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIs/zDU6CLn0wdgAL5/ewe7jhz5iSxRWI7UI9/pucekYxRpKyF1t32PoofrW+GrvEWvAYj+K5pOIg1ScTs5H7lBajFUQqpSFjoXSk2Ut2OXHkqw6Zz9Pv2GIpdyi/E44uG1VkCqK+G+sx/fOHeKQPXcr+fqEbQSm9pzKvhb2PHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=B5/mEvZR; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="B5/mEvZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1785831433;
	bh=byv4oEyKpKrb2CLZ9br7ntOwAjBK+Kdi4NDKE3Um25U=;
	h=From:Subject:Date:Message-ID;
	b=B5/mEvZR71HBzzjdH16TM0h4dol07pHF9pWapTTcFAZJznMJNWo3+KamB0Omogxjt
	 7ilEGy1DHgAasirkYr7TtnMXBQpMdkPAMHxRnIqC40MMiel22sC3p7ngklIY3wfRhB
	 7dQpXlBM2w9OAY6lMfwjoBVHQm9Gjd5e++D3wtH8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.154.155])
	by sina.com (10.54.253.33) with ESMTP
	id 6A719FFA00001307; Tue, 4 Aug 2026 16:16:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9224806685544
X-SMAIL-UIID: EAF91A9817B5490E914C0233EE1EEC9D-20260804-161659-1
From: Hillf Danton <hdanton@sina.com>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
Date: Tue,  4 Aug 2026 16:16:49 +0800
Message-ID: <20260804081650.937-1-hdanton@sina.com>
In-Reply-To: <152f33eec417ee82f74df8be814e68a6064d2efb.camel@iki.fi>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 04 Aug 2026 08:40:16 +0300 Pauli Virtanen wrote:
>
> There is no UAF there, Task 1 holds a reference on sk at this point, if
> you look at the code sock_put() follows.
> 
If the subsequent put works without both race and mm leak, then it is the
very evidence of uaf with race.
