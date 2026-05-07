Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491015B998
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778115530; cv=none; b=cAsZtdjHYrV1qzzV6zK4D+KSkE0Hd/Um/3zJQSNmTR4LysRl/4rbOt3sQnmDkpp0592GA4DTpNtWEl93yaHF9zxT8tBF+gmaIocG++KDuYjW9H09mD0xLQBUm+UCbTzF27Yb3/63gB/MORn5JQEjzeKIfDqrf9ARlyZr6ERNSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778115530; c=relaxed/simple;
	bh=QV4iqx5owyIJ5STcCgKyoKxSK/XvCEnHXUXJWRZqttU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EgGuzfaIlNEEkT5Q7ozOuvHC0H74VFAv94zZgvuxtGQWKpwCI/lo/+CXNboDvEpEgbBVlOBj59XJcukhj5IpoBw+4hRLWDG3n+a0JJP+HjzBDfsmZU0sTZudjvzysj0xjqDYoW/c8KZl3Nf/o0U/K5u1ZbAWJHgafi0jYI4PcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfdm4gpV; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfdm4gpV"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c156c4a9efso407571eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778115528; x=1778720328; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mfu4Bvz3R1a34N+AdgdHqXHGoSuiifRG53+SL2K8Pm0=;
        b=Rfdm4gpV0xUUuizMiiqzaZbuAn0kE0L38iPWzNSfDYPPJipCijL0UQqNpLmtogeqMb
         +6VoXSTEJpFsAxc8+oHE9e6JLp7aUoo2CBBH459RvuehS2ndHFv+oo1pzUSaCvUDPYqN
         6RGDrDOru03+Cf6fa7lWLI7LFkiNAtw2ci3XctU854HRkBBIbbr6JLX3z9Z0iUOGErVW
         qNi3fsbHI/IJV3FYVWbU8QoRHesla2IhF661/VhvlpgYmW5IKWjj52xOK+tJjuL0Gwp3
         liYm46X49T8qIe6qYAJf2MBeBobZcRJqBywrO5FyF2tQZ9EwBQnGXfPM8/TpjCnSa/T3
         Jp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778115528; x=1778720328;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfu4Bvz3R1a34N+AdgdHqXHGoSuiifRG53+SL2K8Pm0=;
        b=C+aLZOjOKM5dVFqORExx0pyARIQQ4q+qP5w/Yeox8HsJuryVIw1vQwf8prsB409gCc
         rpKLlW6WRYPnvgOT8ElKIOVHIQiJSYsg5iH2cX+Gu1TNMVBGNsSVbXWqD/XSRmWPqRl6
         lFCpmt7HdRqry6yy+xb4ADLv7zpBgxS/o1j72qAl8QSGYhZLC8JoCf6q8oQShEqiGLaf
         gVnLV94uhjikWU962AuNkx+caDgcm46ledZeww/gnWIMI8FIPbf+lt5nwBuA3raIu+d0
         nssvrdDByGUv0CMr7APWac4PFZvNxKNS2gdQ/B15SZbmzC4ys9FG3J4DcONscddGrF9S
         1V4w==
X-Gm-Message-State: AOJu0Yx4dw/nB9yFKIBb5108ngjdMIgFxRyQWSQHxY+ClTaGz9uUsCAi
	es+O1RHm6sIbGsEbUvXs6Z7+1bYslf4MJAzVJV84lSA+W2wUMtrir4C+AobLKA==
X-Gm-Gg: AeBDieuSsKGesQsDTdNqhf1pt37/hWSfVydQQvAxrvv2mbPFNJNFJgDfsxgzafz//2M
	V3KpmDB8bhJo3sx7ouzeMkpYL24pEuj6IAer4bRS8HWxxfBwASZGoHhOS7l7J+fK0Q3X2H5JWy0
	5ejaO5TtZHjH2fqDhrv6XahZ8ZFGG7AG0lz1MxEuUs7/BBQf2Viujsr0kJx+FCA3CXrtdUZpxWB
	9Fhqmv65rzfKwfJjhlYhAOogWkN32205e9VPhu0duxOEMvVjQ2wQLTg4g6YYHWpKVgINlnKAAGv
	1B/hQVMLzTZBzdeSwxsiLmRQGp4PfjksGf39pvbNrgL4ivREss8A1QQnbNMMKs2cGTmaw+WwULG
	pTwiQAleq8gvhUavoq0uEjgNGh2surWBYtuuAlQ/jwhVifb4roLrpV3CQLwWkzZzSqRnEq7W7wi
	rPCj7mFqflB2YPPrvfdduddFY69BXHrCoE+xgd/pkfLvM=
X-Received: by 2002:a05:7300:6ca8:b0:2e0:1f09:d924 with SMTP id 5a478bee46e88-2f54d696ab4mr3424938eec.5.1778115528263;
        Wed, 06 May 2026 17:58:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.174.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f88f548sm6714288eec.18.2026.05.06.17.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 17:58:47 -0700 (PDT)
Message-ID: <69fbe3c7.050a0220.595ef.0c78@mx.google.com>
Date: Wed, 06 May 2026 17:58:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4599468339104057084=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thomaskirschner85@yahoo.de
Subject: RE: [BlueZ] bap: Fix typo in QoS D-Bus dictionary entry names
In-Reply-To: <20260506230051.27436-1-thomaskirschner85@yahoo.de>
References: <20260506230051.27436-1-thomaskirschner85@yahoo.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4599468339104057084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090721

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      19.93 seconds
BluezMake                     PASS      664.48 seconds
MakeCheck                     PASS      3.73 seconds
MakeDistcheck                 PASS      242.46 seconds
CheckValgrind                 PASS      224.20 seconds
CheckSmatch                   PASS      345.16 seconds
bluezmakeextell               PASS      180.63 seconds
IncrementalBuild              PASS      652.49 seconds
ScanBuild                     PASS      1008.10 seconds



https://github.com/bluez/bluez/pull/2105

---
Regards,
Linux Bluetooth


--===============4599468339104057084==--
