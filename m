Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672084;
	b=n9ATtkUpU4SkNfZrNJ7e1iN5B+yDoGd3nYAK4v2SOhfSeMPyTP2VEi8PKxZI6w/ch+jn
	 v+2nkawDpCTI8g+6NyCmYNBdmI8CyzssmG7G+OtThGy0NnRFX+X9IxuO4QhpVsjKuF4CZ
	 QrteZvi/6T7EzCJJMvBBnSayYqg7FTV8Z1GY9LV2iRBatAE7T0mh6+lOnYgSVbJ6CNgKD
	 NybL/vsTlIdmaU0SrEgKsle0i7Kvg9GYaGVnsoHU9zIm+x+LmHLq58oGq2heSCJfT8BUJ
	 yYy+wynCeQAax0+FUljfcXaCUv3susKwbD9YGWhatZmqBnQ4Jw5SQmZ7OEY3tucAtog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=nJ3Uxa/4/HMjtXda2ELvycjLeUFFHQw7Ltwn8DXZ0DE=;
	b=xFQrhis79qRzXHf55fokpkCQXoUF5sAfm+q4ZqyScS9rV9YY7O5yjvnn29yZCvWQ2guY
	 ifqOAEUJyMghGPeSEtUgz/lCKkbVw/4/IPHSXrlXcrcxuCEu3RZkalGzPENgdKny3kUb0
	 HUwoVWBZHleS1NNHSFZvtdfKzdhp8r8GzsGNw3S3trObvQIa1xvGn1sk+qXTUjn2V3x5q
	 b0CAOme+JOtOcpGWzkkB3WZSoTSQ7p7glFN+T6RTtI68RRKuo7gYqoxjkxf44YlyJxJRo
	 Zp3rMnnFKLktYK0XseUgkdShnrOFESzm1LQWygweKKZxhqr8MwyNWiGzgDsOHk01okg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLRS8vqP;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A29606A323
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 16:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73A29606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLRS8vqP
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-37986eb6fa2so1671940eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672083; x=1795276883; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJ3Uxa/4/HMjtXda2ELvycjLeUFFHQw7Ltwn8DXZ0DE=;
        b=RLRS8vqPsuTatMy5hr8Xt10fY5Vtl8QCFI3Unqv/E5ZA0H727WzFWAX0aia0KyZxk0
         aH4lJc+C64/luDI0JgvPfLOfZ7rGTZsmvkShxYqMFM7r0BcquNlV5OgzwOKIhr+XKkU1
         5TDTkGNGKSWv5fUcpfOtmIRtCHtE9VzAfvLGbtAyxhYBVyVmw/fNc2qJNa03qNBX2Hg8
         wU70wX3uZrreCqYihDA4DbbzBfU7qv43DQNeMZ+Xu+4x3iC9pM9cqDCSIgRWea18CnKf
         9BLYu528eI0uWpRCua8PikwFocQqs0CMHZG3wsiEpNNfoYMAS+4a1ZYIEFJRa8YvXfdV
         54qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672083; x=1795276883;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nJ3Uxa/4/HMjtXda2ELvycjLeUFFHQw7Ltwn8DXZ0DE=;
        b=TMHgex2DILv0kk5QxLsFGZzVj/Jn+bxLszknbkGrmfDh2+56PFnT2Gwt0GPvuqzDH+
         0JIsSG8wsJd/Iin2wMT2fCrK++YFAoN4CxxwstgS7CIu4Nt3RZL5QHskj7jJgWpl9jl3
         t4+M+ll39CpALWRn3lzuxVaOLXLzu/30ZNfKxTIUtpr77I8eMi8nPHsJyWJwigJElitP
         mSajx6YkFm3YEl7ph5T0HTmICyuPJTR3qdwomxXjrmeLiTA1GlPbj4rttLqFC6+PXkWI
         zSQqoBO2ovC90BqDEm+phDyWRA1WJoZLW8E4R4FJfq8wm9EUbUqZ0r5DMAsh5Id0v0aA
         RIWQ==
X-Gm-Message-State: APuU4Z/k5zcqypkuZ39VlIS+VpJ9gE09UnJXCe0fpfaIPBedjHoxlFnh
	Ah0eok8Qvh+uEcQtqcMLA2YpjM9rzCE07pS32NZbpxvlinw/laKaSkpWBodXsA==
X-Gm-Gg: AYBFou2dMn59feehJPhQIVCnLa72Zkv2kx3u52sy4CWkJNIvfU13JNd1/0u2r1TkKrD
	9FquvHFsudcN/NIPsQPJeDnbEkPktjIkIJ2QyjjNQSwcXnHbodnN5IaNdYytOlIyRI/v+m9nCXr
	GtARzyPi9VvBSan+fS3nPp6VXtLkHZi/elN6NEitps8PYGZbAWLdueBDBSclXpk//XKN5/kXJJx
	B1scPKZSbiIw4mqoXCB+4QlFuRcC253kG7g8M+mh4zhDOoNq3z+pVudEYwWeyHroVrjJA9YOC8D
	OIXZ3TQ2edCcqTer3e6XO1rDPc4s4f/8E9ZF1zkXwkZ776/czCK2CtiDIKXC9UkAwgGvEJaonpr
	n2eB4aJaIaI1z4MzG/Pz23ZH2DlCaZ4iNZ1PUSOx88v0h/+0ttfFkFnlUcwd0lT9ToG+JsrIEY8
	ijsOTMRx3+wSd+u4yJgil9CMME6DpcW+HM4HKlR+kzeWwElWp4h61mDN4zlbxOu4UlkG668UQVy
	lQVZo+F2BEOUAkg/H2pV5+sig5G/mmuC+eYfvqkiwunB60JUnPBLBjnOzMR+M7YUErAgT+QaGXH
	SfeXDw==
X-Received: by 2002:a05:7300:d102:b0:37a:a9db:6bd2 with SMTP id 5a478bee46e88-37aa9db713emr2836793eec.11.1794672083221;
        Sat, 14 Nov 2026 08:01:23 -0800 (PST)
Received: from [172.17.0.2] ([4.242.197.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm17600562eec.3.2026.11.14.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:01:22 -0800 (PST)
Message-ID: <6af885d2.a5690e37.6f62e.2293@mx.google.com>
Date: Sat, 14 Nov 2026 08:01:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7157009797602195930=="
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
To: linux-bluetooth@vger.kernel.org, jacob@teenage.engineering
Subject: RE: [BlueZ] audio/media: Fix build with --disable-hfp
In-Reply-To: <20261030090510.88867-1-jacob@teenage.engineering>
References: <20261030090510.88867-1-jacob@teenage.engineering>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7157009797602195930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] audio/media: Fix build with --disable-hfp
   Pull Request: https://github.com/bluez/bluez/pull/2736
   Created:      2026-10-30 14:36:12+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============7157009797602195930==--
