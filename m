Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDCD2943F
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Sep 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726916194; cv=none; b=KtioRMkkaly67kYjQAGhlN6HkET4r/rgUz/2C+YlFomCsm7Mvzn1HfdKzODhCEiiXKcjikcZyszZtUb8Sscev+gz8DmlsVS/743MPENalqtgYt9SW0sT/aEc1trbhLymFNDBhVVzvKvVgL4ZSy1MjYEacHIgMNWsY8CWlyXygvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726916194; c=relaxed/simple;
	bh=lY10gHCE2vKZpqASK87/96yU0FlK5vzx1i3nULpMfcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6GNXgqhWFU8Arvrp7US260aZr9GaXjIMZiBKjKtMNfk1h/GsKHVfaeMCKMKdC65Nq/nDU2IPcOkRmsYnakzCVG5W7mI4+vteTVxBD9LQXdkbjrSyc72AxR+086DuGEV3TsxWEzuyl+wXQj0uIQ+wWVubUB3iCbhjB21gY5irco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.129])
	by sina.com (10.185.250.21) with ESMTP
	id 66EEA65300001E2C; Sat, 21 Sep 2024 18:56:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7002193408221
X-SMAIL-UIID: 58381902BBCE4792A08C8F8BBA931190-20240921-185623-1
From: Hillf Danton <hdanton@sina.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
Date: Sat, 21 Sep 2024 18:56:09 +0800
Message-Id: <20240921105609.1025-1-hdanton@sina.com>
In-Reply-To: <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Sep 10, 2024 at 4:56 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>
> Maybe something like the following would be a better approach:
>
> https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e

If your idea is not bad, boy, feel free to win Tested-by from syzbot with it.
