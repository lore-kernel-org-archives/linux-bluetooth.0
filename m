Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5BF31ED88
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993602; cv=none; b=nwUACYb0/EmrQmehmfVhvX0vzf6WbuX7EzsjRpGsajU8DTIfrb8/6bAFOM0sEAK2+PokODUuIdKHNfSl7AhM9tWx9OiAGCwkyZpa8/GXq5alJMRa24B9+SwZHnqSq+1MKkFRDi5r6Slix9ec8mFx0VrrT9fIfWaz1lNaymC5LPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993602; c=relaxed/simple;
	bh=Keh8/wLkPjuIFsQpRgZCfp4ZJyx7wqjtW0Jo9H9Wq/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dcynYI/eLM5r6iA1Wshj+hlROGIdWVWZ0nhD0Q6sxtlWs5k1IZY36ghEhrAVlgvfL3tNAVLHdVFsuwmeLR0h+FWKakmGoy/nc/fBys76b+FrHMuPh4AK8cpMyOoRotuGBAQ6aKg8sxUiU5m1Rns+a8BESs54zB+nwE9Jr3n805E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt0ELQxc; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt0ELQxc"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5597330a34fso3466593e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jan 2026 13:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767993600; x=1768598400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHTvqu+YkutNQHzeS1Yr8MBlQu521tKvbncrgZNFtME=;
        b=gt0ELQxczY99lSnLJzE6z0RPgXojdioG3214w6U+DbbPbm9G1FGv935LVbv9gkNZlN
         zxVP2ry/6V/wKzw6PRvIzudASHSOTec9VswmNPDgJwaU+gZJBnZBqMKiPXSIKIalznJ6
         1ZSpQZD7v6VHY1n/M/aIhh6JeLq591WWMWu9LQkBs/di1QQjYhpvcYQYmem1uPxxhKWz
         q3r4auCprCCUfO4J/GepWHhLa+AiXY0xDN5QKlJR+m4YTVZUTJbtW6zFJwNzqxwfRyyr
         5Ae1to2NCVJ4tiRdylFNEzIFJMo1vVYcmthYKgoBUy3zqHuz0MLvsHNCeQCOaGXSYFrR
         ZNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767993600; x=1768598400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHTvqu+YkutNQHzeS1Yr8MBlQu521tKvbncrgZNFtME=;
        b=ZwN3El5dKl41Lz8isef3GfLwwq11ikS9inBEkYaSGOKsUAO0D2xFDxCLyb/fNWpiv0
         ip1/Mk4hcNCzD6OLMdDp4jEG77IZBy5xbXErBPI7IQIynIJkU8gj30Ync6B4BI5MQO3I
         0FQ52aM/fdN5bLZKtxQju4gv7K/itce+x6xIsUHH/GuEqexiazLYY73DTTlvwaw8JnDS
         5dgT+0186QFUi65sFBPZcnEVD68iXkNPZ8GMvMxNQvYhz2YJsptXINuYyNSshrqwRmtp
         7imiraSi5VDJbR5E1iq8seVo+/rppOfSkzm/rK0A4rEuip50s1LoAGaLsTwG8PcjDQKq
         RGfQ==
X-Gm-Message-State: AOJu0YzWkUqRmK1oHdOAj0VpbY0/rGXRkoNDFsjj1eUf0i6s+rA6LU01
	DmzMSllylXqV1R3i75RQg/05Lv5nIh70NZfQxbOonyMeQRzVs+pFsunF
X-Gm-Gg: AY/fxX7PnpbAXXXAxo2nyOvF/dK56uz0lJwtKVnebmbpcQ/nV2JoRKLyjl5N00esnC6
	wGJe4tid9tnkfFXvuFTsLtoT9kLywGkdvDOjEtp0krBn2Cy4YtMrzFwr9hats9B9w5H5peq7jnR
	+4GP/wEuv7Xfnrrxt7piahRsvNdnlrCaGZbLjfRhufXvkLMgK6ypCRrIUzIuEweM82+mMlIioBx
	VIij0AW1Udigl1Ji+RZ0uaAe652y5QgUh3/oPsClAm13Egjg7wWGEIBi5H1s78sB2/YLst+uuoe
	cXatOyUrhRherhw1x9iTKRPZPeQx11hCduONVAkC/PXvYHyBVD0pYM3yxgT5q70IHzysbhrYyLa
	jb4iaEq8rYMb5H34aLLoCPUbS3YQytk/s6iE1mMpNdX5zh8hs2u0K0YhLz9/Nv4d/T8+8jL28Jn
	ct7RFysbEFQMzLXc84WYU+IkhZEJhwW1vhD15ao+ounaxnYJH7cD0KC2XpnaK1f2iL2gtH+eKmv
	8k7lw==
X-Google-Smtp-Source: AGHT+IEvBK7U7IYllotOCwtJvH/1foan5XHxTgks2D780rhblSmxmqd7ZL0bY7xhJskhy2TuvTjkDQ==
X-Received: by 2002:a05:6122:322b:b0:55b:305b:4e41 with SMTP id 71dfb90a1353d-5634800fd9dmr4637269e0c.18.1767993599713;
        Fri, 09 Jan 2026 13:19:59 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a20a183sm10259956e0c.9.2026.01.09.13.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:19:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-01-09
Date: Fri,  9 Jan 2026 16:19:49 -0500
Message-ID: <20260109211949.236218-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 872ac785e7680dac9ec7f8c5ccd4f667f49d6997:

  ipv4: ip_tunnel: spread netdev_lockdep_set_classes() (2026-01-08 18:02:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-01-09

for you to fetch changes up to ab749bfe6a1fc233213f2d00facea5233139d509:

  Bluetooth: hci_sync: enable PA Sync Lost event (2026-01-09 16:03:57 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: enable PA Sync Lost event

----------------------------------------------------------------
Yang Li (1):
      Bluetooth: hci_sync: enable PA Sync Lost event

 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)
