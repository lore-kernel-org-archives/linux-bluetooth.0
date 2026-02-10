Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA5348866
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718164; cv=none; b=I6Fa9drLnnyZ5xhGdvNxlDO7I8Pqpsqy1Df2fslTTOicJXHOKzK4rz9SnaVmJBh2KbwgGIPwYaqpKsQgfwzeGIEyokSzMiYVp5TEuY8UBq4OI6+lNOZhsCFdHvLSdigKkiHFq6YzHJGn2XqSrLNfu3yOrpUlMtNlUWSGViyROuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718164; c=relaxed/simple;
	bh=n/LWQmIaDNE15ogeCKRe10+58+bltyU9snPMp6dekpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVlBLWuyFd2lYTp49BJ98YCD1WsgDRJP/w6rlWjMPG+kRKYTBvzrY+7zF8eyxHHB/j56ARa/Srwn5AOhs0Bhkm1bvYY/WVvGEU0lGwgkLpejcwMaT4c8MZBRsc/0/iKHvePgCMjTtxUdiQyrzGm8UDB20ZNC5tiNqz5JK+rfiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=FFhawP5z; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="FFhawP5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1770718160;
	bh=rRIrUhNpfeVkB86kErAQtkpy8NlmH1T/c8olBO2w7m8=;
	h=From:Subject:Date:Message-ID;
	b=FFhawP5zfY9OZV3uXOh9eJsvSNm1N13SkjLAyhxylU93mJPIG0GZDER4IQ0Boktzj
	 n4eguwG/MFtoMBXLP6xhyAgAZt+OunYdTXKJj52sqm69wCQWnG+0Zm+s16a5yBMBNO
	 dJx4K6KEmUYoG36tzipF17af6VE1JPlShMXLeBVU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.32) with ESMTP
	id 698B03C5000018D0; Tue, 10 Feb 2026 18:09:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 592674456656
X-SMAIL-UIID: F0991A04D51546A59FA1844DE68F0485-20260210-180911-1
From: Hillf Danton <hdanton@sina.com>
To: kawada <youjingxiaogao2@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com
Subject: Re: [PATCH] Bluetooth: fix use-after-free in hci_conn_drop
Date: Tue, 10 Feb 2026 18:08:59 +0800
Message-ID: <20260210100901.2769-1-hdanton@sina.com>
In-Reply-To: <CAKZCeSVJQAsYVSDBHOmUyBMbQqBA1D7ZP4KK-azWUjb+p-vpJg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ hm... top reply looks no good ]

On Tue, 10 Feb 2026 15:08:12 +0900 Masahiro Kawada wrote:
> > but the race still exists after this patch.
> 
> I agree that the TOCTOU issue remains. I looked into all the functions
> that can be called as entry->destroy in hci_cmd_sync_work where the
> second argument (data) is used as hci_conn*. I found five such
> functions across two files:
> 
> In hci_sync.c:
>   - create_le_conn_complete
>   - create_pa_complete
>   - create_big_complete
>   - le_read_features_complete
> 
> In hci_conn.c:
>   - create_big_complete (separate static function)
> 
> Of these, create_le_conn_complete and create_pa_complete already use
> hci_dev_lock, which effectively prevents this TOCTOU issue.
> 
> The remaining three are vulnerable:
>   - create_big_complete in hci_sync.c calls hci_conn_valid without
>     holding hci_dev_lock (TOCTOU)
>   - le_read_features_complete calls hci_conn_drop with no validity
>     check at all
>   - create_big_complete in hci_conn.c calls hci_connect_cfm and
>     hci_conn_del with no validity check at all
> 
> Given this, I believe the following set of patches would be
> appropriate:
> 
> 1. Reorder hci_cmd_sync_dequeue before hci_conn_cleanup in
>    hci_conn_del
> 2. Wrap all three vulnerable callbacks with hci_dev_lock and
>    hci_conn_valid, following the same pattern used by
>    create_le_conn_complete and create_pa_complete
> 
> If this approach sounds reasonable, I will prepare updated patches.
>
Better not before spotting the reason why conn->refcnt failed to make the
entry->destroy callback safe, given the complexity of the race.
