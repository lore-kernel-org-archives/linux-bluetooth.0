Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF334194A59
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674104; cv=pass; b=NbTaIGBXxiPAc68jCSSA+FH/IBlsu3C4Z3yoOBH/hA4Os6t4TcVwdeFnDrFoaWNzLWLMn3uOFjB3JCYAtJ9VvCo7vkC+i7jo5FQQZblHSjgpQqwjztWnT/rQ80PlUMwKsEjKz5RxR2ja6LWHxMS/6uxLj6zLxMVVNR0mVwWqM5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674104; c=relaxed/simple;
	bh=QITABnn7vkey7WTQFSlE1DTizBL6lOq+4IqZ1t1vC4Q=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=blkUtjRJ7BfdmL8lahbm4N4+GsRcMbfh/xdo2v9uc8hbiQeD11BNU7i02mjYnM/HmuxF+n596DD1d/cdy/Px5JUjlBCif/N+DlalOJNgrJM9Jk/F+rmGERXLdPkDQWbRJ2LOsbewULoVblX+cZB47FqPaFhrMkLvgkkq14qmABs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=GAXu1BPd; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="GAXu1BPd"
ARC-Seal: i=1; a=rsa-sha256; t=1758674101; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=Uw/dWri560u5sZV2mQPWOzVqi74s7Yta3Y0N16Wb2s5bx8gRPbH7H49iHKQDU4Hnm3dSMhJjfsjWVwr6IiBqls+Te3UOWpVcNqUqel44C6ITH0IsfUcwTX4NtQw/Ujlf+UpEr5Zg1krAQcyoUZQHEh1poh8TEHP/ZR9B1ynMhEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674101; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=QITABnn7vkey7WTQFSlE1DTizBL6lOq+4IqZ1t1vC4Q=; 
	b=ryzGKfwdP8W1c3Wi12bpXk7LF5xAK6LZoJnXTz2OgKk0M2YQ9DreZ1DFSby5XeYrlb6SAGpeBpHWQwVYBF+f3iho32b5hJNway52kgcdjO6B+MQfrB7/u/Gbb4odWzuS66gQTxiYdm9qLs4vq9xXzoM4O/wUQiZ8TLDFWap2Td8=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9ada6fd0-98d8-11f0-ace3-525400721611_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653599526.2888629548822;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=GAXu1BPdkzWa329PH7QQSfkwTrMVzwttAu9rzxRWCiXT5lxFwT+T2S8j9M/9gO1psrUh0uJY0eddjkMMo7IVpEFrnLE8KvGFG5Eb+7f0pENoSO8ebc1Vt7LoVVO+EklCDJ6ubOx8MWJqzCdfxydYETG+aL8V5qSgLIj9BLpEUkY=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=QITABnn7vkey7WTQFSlE1DTizBL6lOq+4IqZ1t1vC4Q=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-bluetooth@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9ada6fd0-98d8-11f0-ace3-525400721611.19978ffc74d@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9ada6fd0-98d8-11f0-ace3-525400721611.19978ffc74d
X-JID: 2d6f.1aedd99b146bc1ac.s1.9ada6fd0-98d8-11f0-ace3-525400721611.19978ffc74d
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9ada6fd0-98d8-11f0-ace3-525400721611.19978ffc74d
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9ada6fd0-98d8-11f0-ace3-525400721611.19978ffc74d
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9ada6fd0-98d8-11f0-ace3-525400721611.19978ffc74d@zeptomail.com>
X-ZohoMailClient: External

To: linux-bluetooth@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
