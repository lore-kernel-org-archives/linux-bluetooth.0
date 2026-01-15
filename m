Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C135503E
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491450; cv=none; b=Ud2uKrH84LygidFuwMvG+67VQH8KkU8o0XCThTVPhv7ZLZ/ZvfLEX7JaKZZto20diN2fElmi6yecSAjNoNp6CdPpFctJ8IcqIIX/Ltt5edtI1PeotDyYXdK60eSBsMkgPZmpuBu1Nv1ECRaOqDsCrm8YYBDvwGQtxrGOv6Ex4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491450; c=relaxed/simple;
	bh=AyCrZF3OBS8W2iTqSOLXiVS9FigXGHYyQvNNLw8BHLw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZCsyrBNL7a9gykoqPzOCi9YzAel5meQ9OYuOurtgLrGta3ik/U4d6LOD937FwPuAzZusZtEawe1YiA2WllZ0fSa4O9rbKZsIP/jecwX6QEu4fQnLr5x9K0LbuzkmF7/EoXpNtuW9rOMOTiU7Poo0NpGaBrnX4RERPxvweYmd724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqXVWzPW; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqXVWzPW"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-11f3a10dcbbso1000520c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 07:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768491447; x=1769096247; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5AWJKKPRFmCNmP8U3f/RZ7BPjtRmJgYYHdmdWrgnLp4=;
        b=hqXVWzPWi/+7sIZ3/8nVpZa2soxUVURjbwtB4WF2AXRYknNT9r2QP4FNu3i4mDMdxl
         /x9CXLSlHvCn8fmCE+FLTA/Difk6WTwn6+PymQJPU9MkLhzGE5yNHyCXv/+1rbc4nBuL
         JdmbynFSeZB4TfQ+v3qYzLgYXACb0YG1hH+cyHiBhKJOuw+rttlu9gGGxCHkMG4uY+ue
         PGlshu8tVAp6dts1xMRklgnYk76K3AefJeyRUq1K3tubVbrCU3H8OWQCc2g70fyjaqWZ
         wPvQMMPu7OzVc6yDplWq5JHPboLCQBVtFqAEhll7FGAoM42K0Y3AQ/E/qEeXeUH7gbPE
         sddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768491447; x=1769096247;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AWJKKPRFmCNmP8U3f/RZ7BPjtRmJgYYHdmdWrgnLp4=;
        b=r7cM+mUzW15e1Sz5lQY5Xv5iU8tzfF6/znV3QJpNaAjRREamZfH6WxVs4jfQEUx4Ws
         9TayWUer+e1zjuRW2AEd9ZH+1ctJZZNcnBTpGyb7JLjzYK0ASFfNCdtewD2TGUVQ/yy/
         +ux7znH8rMiP/rsDJqE2U+/XoZlD7jkq28QwXG081GXGDu//ndBmnGzAkGsZ9tTgrFYF
         GY0qZBxbeHE5WCAe7Hlku3ZKfRDMYCWwGO8LZ5czJqSwqVLSHGVGZZWsaNwXIsOEg6aV
         zV9mtiXsejS3nbwYxyK0HUbgMXK9yH0FjDDq9isC41rYzfFOAzaEd5xcJ8RuDPSezz3Y
         d0nQ==
X-Gm-Message-State: AOJu0Yw1hadIAN+visvtiR8NlDmB7FVS058DhIHPxJm8Dra1M5UbBTqD
	13QVysCMwh2Sp0PlJ9Yfa+GAR9A833VytOmyNK6YFRzaFqxm00QG+LbxgJlNl2ta
X-Gm-Gg: AY/fxX4zWWD0kRfMyXAm1GykF1U1HKPPZu0tyFUqcCkVer/hJqVsJi+Y+bPwaZM1uCC
	bQ++PgiyE0cX5ygFBhZPQP67qTzwkKwl3W/4X8KnIVokyk/6vLcWzE09GcW7abNe/hgxIYMIeFX
	OiXtIxW0Po5eG5u2QhyZl3eWxS+P2jGnHsGFbkBlHnr1lyNzyNdgRjP6ogwQNmkXFX7nH1C7H3Q
	OX71s8+76XkUNnza534TSuDdomQazzPHw9nV+h151cyrAGHydFTTVKU6mN6oQOfkWaOMm4Q1KZh
	zquzElEyErGSc/KGGyWumi+tER4y1RbYKe0fhb/0l6a+tonScNSGfcwWjMRu+NYecVjwzBdteOs
	iZeBqZ2dtUysk3FrDtgsEnWp/XMeF4blRPkQtP8nC19UdSiUYY1P3qRZYzBVD04Sx+IDZLN8wyB
	NZt5kgRWSqBa+k+tjP
X-Received: by 2002:a05:7022:221b:b0:123:3488:899f with SMTP id a92af1059eb24-1244a745e93mr15735c88.32.1768491446664;
        Thu, 15 Jan 2026 07:37:26 -0800 (PST)
Received: from [172.17.0.2] ([68.220.61.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12331d95110sm5887505c88.8.2026.01.15.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:37:25 -0800 (PST)
Message-ID: <696909b5.050a0220.1ebb4.0748@mx.google.com>
Date: Thu, 15 Jan 2026 07:37:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4310619123100958448=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] shared/btp: Fix typo
In-Reply-To: <20260115143859.12834-1-frederic.danis@collabora.com>
References: <20260115143859.12834-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4310619123100958448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1042857

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      19.98 seconds
BluezMake                     PASS      626.82 seconds
MakeCheck                     PASS      18.40 seconds
MakeDistcheck                 PASS      239.82 seconds
CheckValgrind                 PASS      292.39 seconds
CheckSmatch                   PASS      347.35 seconds
bluezmakeextell               PASS      179.84 seconds
IncrementalBuild              PENDING   0.43 seconds
ScanBuild                     PASS      1017.37 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4310619123100958448==--
