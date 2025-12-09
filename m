Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F12FD699
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765278851; cv=none; b=lWqRi0WJYYgb8Dg/8v67dHy4TbKPfuvVOCiJvdNphCTg67cFIweO5aKR/uG/aBh3ejfGGMOdcl2808IskNZlkQzIyiPRR5U74RTWQxxRryR5ONoYVOTmco3xkxmcAM6rlns+kv04wb5r0GRFnuRMtTR/FV+R5nk/NQ9DShaM9Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765278851; c=relaxed/simple;
	bh=185Xtc8LYhqeGmt7iuhUyYp6objV+pbl5ydvpOo5rAI=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=nBApxrUN3i5YSqeP1PIK7IDTqgko1DY+anb8vwWhW2I+llvUsmnzRap2feZCpVmQIu/IDML/tWI2gzcz4mYVumpqBbXA6rmsEUZq5qSHISWTL2T8aymDNAtEALa7LUe9QNXk4LijvLzgwRr6V+/CndZ0ClDpUsY2A0x2LHRSfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dQbp33my3z6FyC3;
	Tue, 09 Dec 2025 19:14:03 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 5B9BDjIw090450;
	Tue, 9 Dec 2025 19:13:45 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 9 Dec 2025 19:13:48 +0800 (CST)
Date: Tue, 9 Dec 2025 19:13:48 +0800 (CST)
X-Zmail-TransId: 2af96938046c4ad-85b5d
X-Mailer: Zmail v1.0
Message-ID: <202512091913482995g3tuUooeQXYsAKhu5WC7@zte.com.cn>
In-Reply-To: <CABBYNZKy8Tska8N-9U0yR=M=tT9XtQ+O-Y4oQp4gy6LV1GOphg@mail.gmail.com>
References: 20251208203056891J84Xq6wiMu3r7HXa_mRb3@zte.com.cn,20251208203245047U3UW5v2aGUumhmvjLl96E@zte.com.cn,CABBYNZKy8Tska8N-9U0yR=M=tT9XtQ+O-Y4oQp4gy6LV1GOphg@mail.gmail.com
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <luiz.dentz@gmail.com>
Cc: <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <chen.junlin@zte.com.cn>, <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgMS8yXSBCbHVldG9vdGg6IGhjaV9jb25uOiBBZGQgdHJhY2Vwb2ludHMgZm9yIGRlYnVnZ2luZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5B9BDjIw090450
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 09 Dec 2025 19:14:03 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6938047B.004/4dQbp33my3z6FyC3

>Is this preferred over just using the likes of bt_dev_dbg/dynamic
>debug though? Or you use it just not to spam with the rest of the
>debug files like hci_conn.c may have?
>https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
>it does seem to be possible to enable debugging of just
>hci_conn_hold/hci_conn_drop.

Thank you for your feedback.
The reason we added the tracepoint is that bt_dev_dbg cannot print stack traces.
By enabling ftrace's stacktrace option, tracepoints can print the call stack of 
hci_conn_hold and hci_conn_drop. This enhancement aims to better reproduce and 
resolve the "WARNING in hci_conn_timeout" issue. 

The monthly penetration testing results for this issue from Google are available 
at the following link:
https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907

Actually, the purpose of this patch series is primarily to address the WARNING in 
hci_conn_timeout issue, while also initiating a discussion on the asymmetric i
ncrement/decrement operations of conn->refcnt exposed therein.

Qiu Yutan
