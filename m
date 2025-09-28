Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2581C1F05;
	Sun, 28 Sep 2025 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759060346; cv=none; b=Ya/0POEE12oHnHHdAivjyDPud/KYFTmc45ghCZGfcz58IcL8Vcer0kTM0XsET4bG1uGIelBOgxD1JnqO+0sEtfZd+jReQ+qZj407UCZmhjL16reYPbF/+3HurahreG6wY+TthozaaaQDtawemYXSvVcdAeqajo9wUq4j0Is2l4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759060346; c=relaxed/simple;
	bh=chDVZ6z20NUtuSfgvauVog4sxQ5p4MO3Z8xcyAyIZIM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=T4EIaVS0o62tKC7/KEvp4zIiVmFxE6DZ0zMuSW6Qi00zuvKQezQUSNzwfC0Hfut1kAU50UA+1KSk6KMpOSX1E4rBUUZGxHncntgDEYa7bb57odGeZ9OdrEH6vzKn0h78r6U4BEyQUSJLs435PLqO+DXHE3cB6vTG1D4xJ6La0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YmaCPm5Y; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YmaCPm5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759060340; x=1759665140; i=markus.elfring@web.de;
	bh=LcSa5w/TWCO/4i1eWD+TvvsoPfiGFDni23Qfu9Sahng=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YmaCPm5YipNa5vqxHLN8kTlfuR6ThfCEKPRRNJRc80o2DQ1LL0Lc1Mu9/8tRPxqg
	 7s3pjKRA3Gcpsi/SxHhl4ijEKxYuEqZmq92YFKmW5O2MvFsAb93bqqRMsqno01Yyg
	 JiE50eO+uWlJe2zGM3Pe3IZu5+7yXQeStkLdW4lHevQG5F4YYdAUn3mSCHca4sDxm
	 9/30b+cy6/92J3hRZv3hwudjoVAe0sXV6n23B6LW5oOWsQNfTydwzvYRQL12IaAyy
	 daCQx+k1oCggv/+h6r0q9Syes+NsTkDOBDy+EPL2Ms+MnrGLwl3GR0rgzIwHCIDnN
	 4l7FDT90I4R/GjNSDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.189]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzmv-1ul1sO3VOD-00LWeF; Sun, 28
 Sep 2025 13:39:05 +0200
Message-ID: <9b865b1f-fd7f-4378-a512-2c67dfff675f@web.de>
Date: Sun, 28 Sep 2025 13:39:03 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cen Zhang <zzzccc427@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: Cen Zhang <zzzccc427@163.com>, LKML <linux-kernel@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
References: <20250928110740.137220-1-zzzccc427@163.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix race in
 hci_cmd_sync_dequeue_once
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250928110740.137220-1-zzzccc427@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mO2+SMt+A+I04TxOZUZzlBuGwvh0iZKSXu6hjFu4uS7WvKJT6l+
 YiLWy3euN8A4qgkJUsOaz+z5nfL5mCb2N+AWXCTwsKWdd7+vkXwHUylec97lARkzqKdzSGy
 6Jf7mhigJ+PRbF0UyzvdsLi0kZ/mjWQI9m54H7PEEspWG2JD2ZdmKZltInxGi17Paxf8i8K
 EKEL7aYAxgCxTFnzSyOIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s3NT0KSxvB0=;ZBkQXHz/ZIYcSwkjCNaUQdegnd7
 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

> hci_cmd_sync_dequeue_once() does lookup and then cancel
> the entry under two separate lock sections. Meanwhile,
> hci_cmd_sync_work() can also delete the same entry,
> leading to double list_del() and "UAF".

You may occasionally put more than 55 characters into text lines
of such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc7#n658


> Fix this by holding cmd_sync_work_lock across both
> lookup and cancel, so that the entry cannot be removed
> concurrently.
=E2=80=A6
> +++ b/net/bluetooth/hci_sync.c
> @@ -862,12 +862,13 @@ bool hci_cmd_sync_dequeue_once(struct hci_dev *hde=
v,
=E2=80=A6

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?

* Under which circumstances would you become interested to apply a call
  like =E2=80=9Cscoped_guard(mutex, &hdev->cmd_sync_work_lock)=E2=80=9D?
  https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/mutex.h#=
L228


Regards,
Markus
