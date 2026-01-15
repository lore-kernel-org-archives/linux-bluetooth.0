Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C742049
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491479; cv=none; b=p6mQ/eSQiRNK9iYJ3mkxqL8JW+lOV47/owY5YSRzYtJdDeLEwnq3X3JF3e0lXTzna98i45XGUz9r1LRfsxCt0V+QdaCwJq2cForrFvQJ5fjBADa/FygQHFfoUgQFu6L1RIOiQiVtaBehrp3NoN5D/z+RLIE0cz/ELEBDdu7ftac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491479; c=relaxed/simple;
	bh=86lzLY9rATdxKRaob4RfKVppAyKfO07ECYbDCulYmrk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BNC+gG7VmGoF4XONygotFXhpSK67ZgvJRc00z/MGMh5glgPL1+q9nuwKWhcNvWmPweQo1qzJ6/tr5HucKiT4IsOV0mq3L4Ek7rh4b5g6Tmn+xeuPltVW4vNc7K0zb8/4dPtzr4WVXwhMwIqDH1PrkCr7O3ytiu5iIZpO5TKW97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV+ES/Bt; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV+ES/Bt"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1220154725fso739824c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 07:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768491477; x=1769096277; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MfxJBy6FGbjNxWeDexdGSHmF6js/3a7/iauSHPk5ews=;
        b=EV+ES/BtOZumI8Zvujz3Sakb6GUPAV+CPRyjnWq2/0K4CFQPVW2r8SVqrZn0QStsLY
         dBf6zZZzRNIhqHYtBTjscYA9NGTXg1Co/628tQv5gRIiXRl+R0HJzknk4smyOjlBJMRU
         kj2FmOUJAKriYjYG0MaIPkKp4Uqn/1KsZNKjLqoVPemXxw59GcZSXSZ6x9FCuQdyK7ii
         C3eLNGOTMYPIMBORZJAH79O31bJEsNwnZbb0GEGPlDjxXK5wlP3tXZ3pJwVwB6WdC7Iv
         DibNJfR8CQocV7HP4a220aknqR+L2bb8ugvi+Rvl6dRNC02ZSM3nVTbr9wb0CAkPTSfN
         sD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768491477; x=1769096277;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfxJBy6FGbjNxWeDexdGSHmF6js/3a7/iauSHPk5ews=;
        b=EbxZuUk77QX8TagRh+ngRZ127bj3w/2/BNgK93nceURO8G5R1WKJSdGKHMA5Ad4Eqx
         FJCwxGxkVlftOMV48LlR7yL2DtngNmjwlrOs1TF52Qx1ht1imneWXRCgUyp+mNLyDM5q
         Gu0O4KE0r7VHZatvsxOqKyfFvv7tgsOt5nbLoQ0+mxWEYweQpQ6Y6jWy8qeqSMZtQPFs
         UIeyw/iP1UmUDRy0+iJO7kzrBSx5GkdvP66aQRZN44cwytMxHRDBnmQx8qiAVrSCx6o/
         0liAe56FRoRoyDhvADIfZg7K1reO1AGLZfaSrLYhTmMkjDpEgQ1+fLlavYKoM+jIx4WA
         bJKg==
X-Gm-Message-State: AOJu0YxErjMFGb8BZ/cx3uhb0gn8433MbFY22yDbirYlVQ7ytG/RxpKB
	YeFLR5vVjj/LdQ3nbqIbB/2T4oFrxfLeoVDpNEci3o1O85fErVjxBFqS1VsKsrje
X-Gm-Gg: AY/fxX5Z6qeaj/GbdpIY0Sio2LIt8s2d/2Sr1Aoiayoor38v4Moi/xPAe42wFdaoU9S
	oD0FUK4xrt0N2Vg8cnpklMYv2XTxuDuThT0f4oIkT2k/nlSKuOkKqUbqApDkunj60tNqfAvhgo4
	PxTT3mwVsMNhrlENHOkW+BKcALUti7eMvCGLlKZZcnXS5dx/Qb6zoFnmrRfEBKty94/2wtNQnzU
	9Vi07soqgX/QBSpn1qFtPs69yOV4/QumaiudZBaBD+qdTEh2IWPZJd07kSHf2wO13lp37S+ddRH
	4q/WtJQ5/jWV34KhYSzKDFdKW+B01JY5zOFttEtLZqA8dwt1j+zl5oxLjUNWh3FB4oD6v7bmLk5
	dsoVOeow/ojuNS4lwNus0iZaX1ueg2YHpJxrnqJYiw7+Dnla5xg2JnehI9hcEj4UWkYNAZ/MvQx
	4GcldQXH+aITUr0WJHAlw=
X-Received: by 2002:a05:7022:f9e:b0:11e:3e9:3e92 with SMTP id a92af1059eb24-1233d11123dmr4283883c88.23.1768491477270;
        Thu, 15 Jan 2026 07:37:57 -0800 (PST)
Received: from [172.17.0.2] ([172.184.220.213])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1233b8d9613sm2889405c88.1.2026.01.15.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:37:56 -0800 (PST)
Message-ID: <696909d4.050a0220.daeb6.27b7@mx.google.com>
Date: Thu, 15 Jan 2026 07:37:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0274596274479965034=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] tools/btpclient: Fix discovery filter setup
In-Reply-To: <20260115143609.12559-1-frederic.danis@collabora.com>
References: <20260115143609.12559-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0274596274479965034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1042851

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.55 seconds
BuildEll                      PASS      21.58 seconds
BluezMake                     PASS      648.04 seconds
MakeCheck                     PASS      18.90 seconds
MakeDistcheck                 PASS      246.27 seconds
CheckValgrind                 PASS      294.17 seconds
CheckSmatch                   PASS      349.47 seconds
bluezmakeextell               PASS      181.64 seconds
IncrementalBuild              PENDING   0.45 seconds
ScanBuild                     PASS      1020.91 seconds

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


--===============0274596274479965034==--
