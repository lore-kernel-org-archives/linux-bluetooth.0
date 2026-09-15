Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078DF30146C
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467754; cv=none; b=dXq1e4ZSkAR1bgzbiwLtd/rJAx7WBc1hlO/F0zFSDLaJDMzbWL+WilRw7Pj07znj/toLVZSgqMhHcObBZ/X3vxakQvtYuWuM3gPbqnMZQ5V9u3HoVThPUPU2D63181pqREhGi/F38XqxqB+BE5LZkqxNu8IheQBWZRKOf3WqOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467754; c=relaxed/simple;
	bh=8yu1mMhku/oLyXZ+/X+gKSEWqsE0C2BTM7am7sxHXf0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dlTyDlLXfpu7k2IU6TULBTx6JSOTSrMRYlku68Ae2VEiVNlOKqgLnfEtCf/WwB+nCMrwiYcuyk8KWLV198gprDgWHjbZtBqGPDMUkg8CdOzuauWlcoboTTs5FUfS8tvzOPSYVDs0pCtw6aCijo33uy20qrN0GFsOCCqZBMRRlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euJNV9Cl; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euJNV9Cl"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a34908so2566523b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789467752; x=1790072552; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T3cFsJgbeR0h0vCKqp2iB07PS1Dpdxo3UulpKYAYFNs=;
        b=euJNV9ClZetEIDGq0lm6Bg9VbMqr7hgkHozvcEGerBNT6PQ/+8LBgW4daMQmio1YrP
         p4JojH6vRBVGtW0Ck99adDjlVFO92S1Ca+gShr0kMoU23ZknSzo1pkBFwJu77UryLVLM
         RWLZvPGl0vr7ar1DpDowBh5ajtA3rSz1QCMgQ8czIQgSTEgO6YA/BeQspiET7c2EX4oe
         w5Orh/2c45ET7sPQnEHuxQnka2QmfWa3rMAYwqL/2tLUP1ETCqm+xgPxsm0msE0CqGdu
         lnMBiqLA+z4wm5CJy2NtzecdxZrNJvSxGSl2FBpqV0lqxWK7ortfBrMdPZ0e5ahhJaP6
         YqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467752; x=1790072552;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T3cFsJgbeR0h0vCKqp2iB07PS1Dpdxo3UulpKYAYFNs=;
        b=nCoI4BJk4DQN0j/nUHQPyww4A+C9Fum09yDV5V4WkN01CkPxEysS+sQNyZLdsfiMwX
         6NhsIYlwGGL7hPvmWfOJl3j/LsIEbs549/DN5My2HFxYkaUzwPOjM9yek6jDEDudGrrf
         WPoEidr/7xgu96aPTXPCtV5HpIQHsUjTLv1m1urvhNLDqe79J7lcxm7hMs2kzyWpBVF6
         toNLs9UYtXpjsolTCVEHCiwwlwJTjlz6bive3c4iV4o0qMUSmBNv3fXCSaDXRow/MfkI
         UyooqG42kZVvGl3bhg1RjlKckakEWZovKDNSa7W8v80gSzrmUgJ4/ZFRhPxT032CnI7t
         TKkw==
X-Gm-Message-State: AFuF++k1etsa4f1TwII8H4tuBuebzxBte+P3FXAVwgNaPRpk+of2obE3
	YSR5dWisniR/zGGS5jG+0PPULdOId/1U/QNTOHLp6sFY2t7CucwNzwoT5Aqtog==
X-Gm-Gg: AYBFou1HfHKpIZGQdXIe7JMD0c5fucEVObrfCwwFFmz+acEM9lvNs2HgGYsiTfZ6n9i
	/MVtTB4AbtKzAtQla4gb9tPJ6QOrOPC2CqGjxqR+RRpAWi5CRls82OMGIuOJxf/gmFRxLudHdlh
	utZrHfaFGKMlGAWle6vaI6uXkb5bll9tcvw3mPDMIhJdJ43KeMLRrktb3KYUICGsStnh5TXliFt
	cwAuq8yJrjGtq4EFDxfFMrov9vxqPfbj8oiQq5CFS4q+3GzTVCCwcIjmVlc++NT33axrp5+9q/L
	Ye5WJnXLnSyMQbVhtzCW4xwbGtCAW1ngYwa9YUzyYUg+8Irbi6z+7h0GBRj6VQZH6SYRqHcKY0j
	XGzYmAXJ+It3MPW3GQrh1dboNwO8aEi2pHdhhu9OmII+evbKDcAreAb8i4RoEFKvBMalRTbBS3a
	bwPAnv7y0XTEKqKI5+Mbnn6QklIhzYdAgBqpCHPgdkbIdhJ6qGGYWwQ6Csw/O9jRcTC+6YvULP1
	EBppNwZulLQY2k=
X-Received: by 2002:aa7:8888:0:b0:852:131f:b9d2 with SMTP id d2e1a72fcca58-86f8314a45emr12410334b3a.2.1789467752030;
        Tue, 15 Sep 2026 03:22:32 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.29.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29ebc712sm5919731b3a.49.2026.09.15.03.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:22:31 -0700 (PDT)
Message-ID: <6aa91c67.5156efeb.10526c.5bb5@mx.google.com>
Date: Tue, 15 Sep 2026 03:22:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1741968453784850155=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: Add MCS fast seek and track position write
In-Reply-To: <20260831061144.7767-2-raghavendra.rao@collabora.com>
References: <20260831061144.7767-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1741968453784850155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Add MCS fast seek and track position write
   Pull Request: https://github.com/bluez/bluez/pull/2460
   Created:      2026-08-31 07:12:15+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1741968453784850155==--
