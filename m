Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3044E4315
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740196; cv=none; b=jUyBGN6qBQP8reirPEU0eFPUf7qgdKcjf1gtkoOVjLolZPZcbRZyRPkw24+4MTE7kM1WhEJ3DRkbxmCZzXcAWU+Db49DUJtAhSmHGHCbdq0enV6EhdlRTLq5qe0KgxmAer6HeJnnDXHKeqKdTkeXkbx4InqqMUhHo2DgHuRfSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740196; c=relaxed/simple;
	bh=l0N6Qgv2gat2foYWibBPlZTCNKQ+Tl4/RJ0RXwy/G3U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GD9drhqADS5Ncpbe1CgpBW3E98las1GlAympil/c1KGYXSOaj0Co2NPWVkWCMSiLTpxlbH0REpKbPDeokCi/w6fXxHULNkbmSQQGBZb8q+SFH73zvMEBKEDxvhjIAkoFWzTO+akQ0VyRUnukcH14ACTA5oVs1HnPiqNaBL5xEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFbioI0y; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFbioI0y"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-785686d2764so178120137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789740193; x=1790344993; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qr/8MNrpCY9J8SztHTKvvGVs7tYqMv7dKrPL7l1PQw0=;
        b=RFbioI0yKiOauq6ijSOHXDpFuXrq8qQfYddHE+yuYAVCM17VLp6MdAfYSj82qbNC1U
         ZskS5QT65jD/3bRTXUaJMAI+RQbFvWgqEg/3SlGXC2xrx9UvHYQYoX8kG8KcfEaVQL5m
         wWCk817CGGQ5zyD7tFb8HFLejQxWSCCmqw2T7Ocyt6pkE/DiKY4whHuvSHVUSqBvrToe
         3CLdYisQR4fL/lZp/oT3uBlp431gRJboGy+zrq4DLd/jVRg7fvbDDJ2bpLyPEoYGnWhV
         VZfO05eNhd3QKWCno17W1J4TG10GBPwKnyCn0RxHoO/nwgeuF5/K3dIXTnhSftFra3Q6
         9Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740193; x=1790344993;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qr/8MNrpCY9J8SztHTKvvGVs7tYqMv7dKrPL7l1PQw0=;
        b=Fq8L09nOVMHpEelQ9RjT7t27bpSQn3vO3ZKXIw7lLm9g/+6Qeej10XPBrdi30TSGHU
         bhWt/OBbLMCYgMgtj190XBcHCmcq5IZX6aFEP7x+tnOqzZFhBYKJ4M0e1jv8xalRz3JT
         UEvM7ox4ZRMcMzXOf9ppJYQ0UPcMvtYCCaaIFpsA9tABTi4bt4BASnQ2bFHNfU5R32PV
         IwwRSCOKTEROoXp3HXN1weaYDuTUuP/1bwrVjGndGEI/wlxSryRt2fmeZm1LCf0J0BWi
         yxOREWyQ/pM+9JUsH1kwpWpVFrAQ0ktSSi8FfHDnR1sSbg88oQ3Q4AISLJNMdEz5Hl+6
         no2Q==
X-Gm-Message-State: AFuF++nOGr0YoQER/BSsRqV4TmKrbyvrK4pNu5bOvs9pD0UaFn4BE97i
	tp01fEBoY4dkbshxrNpfVgURZjiTTma3DyozrYZ7OvuY7oTqalnxW9gv36qb/w==
X-Gm-Gg: AYBFou0WCZq2fi1ZGlByB8xw5bbkyZgImqBeqYNBr8LFcPt5XpuHpEu8U4K5/R9Cwu2
	2TlSA4isrmSB1aXMzSeMs6B54JizYbiOilHLC0vscbp1brEIpxgK9SJlrvm4qC4gvyaukjBUcu2
	mTsNIPN1b8tuc3ICujv6CRk2iQLhXEcmsmE9cVfb+ta4cQ/gEBH1btuWGk0RD309ftrOfTCcE3E
	Mkc1yled88ONEQcDwWfWFKUD3BofYWZ2nESA75Sw/TX/y/wmMN+5tfIr7u7YyhefBJP9JjNnksG
	PM8+djxdfAitDuoLBrVxbsuYfJrBX9fYaK7yCMuJCDsf8xGytvIyRRlv0mKlOYJb/koYKCPkeQf
	99jE5I27xC8VlzdmFA9BeynZqCt2RBZKucjW0Ik6cQjtiMJzi2hCz1CRLliyNwT4lyiXn98frPZ
	oioXcnkf/6R5gXyQXJZspBexUSzTC2PnqC8sAoqNPmvTX02SlAZ/wR6xFgGUSruYTm9jVAEu2et
	dXqgA==
X-Received: by 2002:a05:6102:91d:b0:78d:31e7:e02 with SMTP id ada2fe7eead31-7a55a227271mr882232137.4.1789740192583;
        Fri, 18 Sep 2026 07:03:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.247.38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125802d79bsm13005426d6.24.2026.09.18.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:03:12 -0700 (PDT)
Message-ID: <6aad44a0.a4ae4f1a.160cfe.848b@mx.google.com>
Date: Fri, 18 Sep 2026 07:03:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6667785001786123687=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] doc/qualification: Add ASCS PICS file
In-Reply-To: <20260903072948.719744-1-frederic.danis@collabora.com>
References: <20260903072948.719744-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6667785001786123687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,1/2] doc/qualification: Add ASCS PICS file
   Pull Request: https://github.com/bluez/bluez/pull/2476
   Created:      2026-09-03 11:12:53+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6667785001786123687==--
