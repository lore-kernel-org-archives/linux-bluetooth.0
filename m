Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782344;
	b=RPnbZ6m6/JBoYb45GTqO4anR5oa224ZbP3UFEBwYPV48XnVb9tYOy4XHxMgHV3GZkIRQ
	 z+i9jYO+l2cbuBnEO9zMH4koZpGjjqH9vVHbVynRztDgFWnq/bjbHkSWavuB6S1h9KR4N
	 21aoxCmuI+xI9GSIXElZcVgsbFWzNzPaqqJZqVXdz11kBL3WsZ4CntqjvtLQpAxgly0Oi
	 Jt29ZguKNXcTIS6NlRe3pji1nao1MBj+e0kiNRQR4dtUH1P5Mv50AcvpU7bpDcYjEb2za
	 o7pDj6S0So/eyPWzJs5fE8Yl7yveQkLgtAE4g4t6YAkCdKuH6L8Cv2mBZPRtJYHMrNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=rAsD4bZDGb5OJXPPB02LdJl2ynjd4dYcgMNwYvGuOrw=;
	b=a88rw2xXSwaX0Emnt7PndP950NOH5VYysxGc3mjXRZT8qPO+iDxI8zDUqjjRR6RGZhJL
	 aoPVICWrn84qZgChzhRB3jlIkOZyQRjIPN1K84nTL7nbglypP+ulucMCeHU7x/3cVx8pb
	 O+HCsds6E4V9DiMkUcA0mwRI4AUorCWu0AyCITcJTa5kO5dCjSC3y2nYO14CPRvQY7+fl
	 zApRZh8+/1W2iMTkr64OddlCp9yiplh3igyyRFJAP7SbjorPB+TKCetlwUrHG8yh6Ua2B
	 IYwXc5dYSTFv5hesgUkxS+aznryKGu67CjMIAvwpX4HLFgBGBwSlKUzUv/5DR/hl8Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ro/hxQ9E";
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA76606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 19:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ro/hxQ9E
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-81ae6aefdceso1031943a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792782342; x=1793387142; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rAsD4bZDGb5OJXPPB02LdJl2ynjd4dYcgMNwYvGuOrw=;
        b=ro/hxQ9ErHUl4GaC0RAGp/qyMq+P/cKszVN8mKGwcOXab9lfyY6vhzm+/vzFXTEs+A
         XQMKrmgDlJbYSBRyS9G2GYbHpLT4IuZgQyuwqfY6FuVoFkSP3hBrRA10GGLle6oNChFp
         EbQXJ1kof+zdo3LVl5mFXhASZKdee9dQ3miOMOV59kvAEOlPiCltHNxHsRTurAf6Nh13
         rUXUuU5cvQTmVU9rACcq3J2g2zws/EieDLmgX5ogD+dNJQ+E0IqdpJXNVMQQrpmKBcyL
         f+kuU3s/dIrAkimadbwzV4s4hLlpL7dXRAUbkPGw0CaKJPSmtz7Z+GOE5wONNQbrV2uX
         yzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782342; x=1793387142;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rAsD4bZDGb5OJXPPB02LdJl2ynjd4dYcgMNwYvGuOrw=;
        b=xhhpsOFCpU1sf06e2IlO3V0KMRHEN0qAuZuN2wEL3cGeubBW5mwbc8JRLU2U5eaJU7
         r1EU5qvCdC2VVgCCPyvjHmyFBGE5q4EfepR6s3b67zXXb/rNhdEB6VVWQwshFzvuYZLL
         5i1zA5Jo2SzcP8x44BDt07gdugw8YE0VuxiiVOYrtt4QtTwAMWyhUuHF/M001yIGmTH3
         rOQUTUdpFS3AyoX1Gl7jcvKaF8vHmngvh+KDPQ6qWcmbullUVp4p1jpdTSya5RgWFPPi
         lvcIQCpy8pfV49EKhfJ86VB7NLYkF4X7ocCC1j2a04vfcRQP6Gr+HQ+9ZdfDzGy1GA8b
         BZfg==
X-Gm-Message-State: AFq9FYLp+4bXTaJ9FLwANKgrzA8TokQCy9MDZTErPnkBxebSUH4Cpbi9
	RBIXb/O5jC9MGDJn/6T3eT48kV5OgpVR2xmyUgN9QPNoC4+gG/a45GkKjGLqKA==
X-Gm-Gg: AYBFou3NBLFrfWj256FQ1l2Uh8IlXdLDpr5e/9R3L7A7ExDz0fvchG0v0f5iV1mfSc1
	HI535IpnzHafsvXsZb+3yJNfu3DvfLBb6ANGb8O6/4YjN5NN/Ctz1dH12ugqB7DNkzLy4CzT6Ck
	YEAhK+JwJIqZemYMB0l+HEEjh33NUyD5BRNy0DaCCW03rlHywVYYKgTvaa+6cV1UVbDW9rSmLP+
	q2xbVmWt2d9tKRbTRaCGn1MIZGPSNX+v4Lf60lW7MwP+Vc8kgDvMnPrl2WWWXqjoWEF4KrGIN8A
	6zlicQ4eF+b0alJ2zTujx7Jh6WSk4Sezdw6FzCHE6S1U6Dj0IQi5ltRqlqcBsrIl9Pzg1Dsg1PF
	duUZXk5WuKzIQEpMcEcGd3C7U1tepp/J4rG+kXX2DJeolcU0RR2n57EtiAtEyCb6laZJzE/Hp1S
	0Cwd4SxsTtFbXWsTLFndYBx3mMrSLaZibOQ0Kl1kyf992GV/JF/PCreQz9pko7xZRbjwdLXgspT
	ElZCkS2sEJKb/cFQOXOe5N8/ahLTqoylLWolln2XCXtVAq31Y0TtSv/11J8uDFhdKOHdIhVMCAZ
	jS82Zto2vJOy
X-Received: by 2002:a05:6830:6809:b0:822:ce5a:4ab with SMTP id 46e09a7af769-850ff57f429mr231580a34.26.1792782342573;
        Fri, 23 Oct 2026 12:05:42 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.215.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb64a8c4sm274102a34.15.2026.10.23.12.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:05:41 -0700 (PDT)
Message-ID: <6adbb005.39268df7.20c758.c9f5@mx.google.com>
Date: Fri, 23 Oct 2026 12:05:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7687306680524658470=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Add Role property to org.bluez.Device
In-Reply-To: <20261008133634.30362-2-kevin@simpleble.org>
References: <20261008133634.30362-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7687306680524658470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Add Role property to org.bluez.Device
   Pull Request: https://github.com/bluez/bluez/pull/2636
   Created:      2026-10-08 16:55:21+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============7687306680524658470==--
