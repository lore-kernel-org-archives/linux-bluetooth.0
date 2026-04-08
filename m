Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67C2153EA
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682614; cv=none; b=X8/UOv3A6u5BH4jdmEiyBP+o7KVwZ5fardgDH0WgUFWt7vo2MxHnKWfzTG+u2OCx+p0Y0Vn/9YPxSgYKvba5X+6u9efrpzcyAGQ7psQj95gnrCg/zqoLjLfvW1Bsh4NI1aZt/HTVywdYGXULe7CS1qFvDduIwWFhZQfTxFbh0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682614; c=relaxed/simple;
	bh=KBLVpvloNT53xB0nAR72cjWtTIzMluCwoRADMabHJIo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cNklE/2KJ4o3H0zv83jUXBsaf+5pGXvhE6I4fYuziZNw4U6gK49LQ5jImhwBz0a38pAfaDciGAjIWxL+bTbvq14KIuL1u5J1mldnjAugRDNnzbtZ5KLmjoOthB6EOSwvFSbKuheCgTOa+fOy77BD2WTDU/Xjv6QvjsYIFmnxDDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhXnk0tg; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhXnk0tg"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a5800772f3so1946816d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775682611; x=1776287411; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sQc/PnGQctiNXJkqOb2J6bb10y4p4DriIt0ViIMTPMg=;
        b=jhXnk0tgjsVFbO+wrQ+K2Zx3csmtJo+iucFg0OX8KXJDU2vQ3o8WGCx3ycqMtqKauY
         KMZ1wPdyXAWbXWUHdGkOIet4uMAwziI+Wxph8i+MgxO8oKrLrafGHJ5y8/0gelip8SWH
         eNuCFe6+vKB24VYQZcNPI1yacab1B6uY6OdfdO+0JEHsZQckfEPbWc3jFT9e7qA5nKPI
         ftbouO6OnehsTabu8hYauqsOOQrqx7uuHQaiPzt23QbFgudT+6OkYPTvd1iZtIaqN9Zi
         mr4N1qKJrs+iL70ID1THjx/agKb6cARIawmdq4UfSiEsjllSAlL9lAwojthWU++m49Ym
         Qt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775682611; x=1776287411;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQc/PnGQctiNXJkqOb2J6bb10y4p4DriIt0ViIMTPMg=;
        b=p274vbF+fDFaANk5OCrc9a8P7sOgrP5WbAzLCFcUkR0ehYWW/l0GTiL4yVYDY9X2X5
         CPsVMgi0ZE6s7czCARD0zxQPI+nxZDPQlNjYAm+GpM1jQimI0hjCliy0MIBBF2qPuy/T
         GZ/f6C3aZ4sHq3jJLbQyqVK5/Gv/xNfV9JQ+YFa93HQp6N2PUfOzQLW47CM4p/EPUAeM
         +BXaF2gpVhM3Fjizh4cblmAxa45NQ73RCoIpqU/cw66sNXZ8nURPwgXi+ar87ka4GXM+
         Q5c/X8bDbvLmwq/Sm60inr8Bep/juZUkc1optmTBj5jdUTTmd+4a9wBD7t48QgN39Atq
         Ygjg==
X-Gm-Message-State: AOJu0YzR7YSQ9BS/s36fYW64pmRuMN//oVmb7eJcy37mBMNiqO4zlvy+
	DCo0r0wN1CgFGDwITb4ac2wfTvoRFYFp8RcOWvavbJLoleitaWsislyPGEoStA==
X-Gm-Gg: AeBDieuea2LQJu2cyhNTFDiUxQUyITgZaXxu2Xd8zsWHmI34h6O9Vpvcqu5zwJvCdoc
	FpZ3wp7eQSmm8ziKVQXC0VuKYNVHeaL8mc5Ob4zPy/8ny30e27vinw9x7M1CGqTINtNsGX5MHfy
	QJefHbyuhiUpvWbYRNAbbnYXwuVuhm8b3XFzsmduZUizKhetKT9oXP60+eJR5GqNnhDEkURV50o
	ix6EYFMFR9mtd3ksonjKne9iApUJnShNWaC8u97KjTQ0mUuoF9TGxsq84kpsFvxAyx0xsiVZFNG
	b/LOOf1SMQ3RuWLgkzwHgTS5TEbF0tN7Z+kXutAmz/+UHQFlqSqOAZnYYrGaYaCC+FijDaUcaai
	4kqjqwurA2+T6b/OYQq15di6mVB2hgAr1rf4eXBk9wYMV6kgtzXxlAyXKAI2gXWoR4gz9qTws8l
	8JaTsKqYWGnAWv/qsJ7lWoIle4c3YLpTHZkZIqYxI=
X-Received: by 2002:a05:620a:3705:b0:8cd:b05a:a631 with SMTP id af79cd13be357-8d418cb1427mr3311777885a.16.1775682610871;
        Wed, 08 Apr 2026 14:10:10 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.53.80])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8c29f00sm1567469185a.45.2026.04.08.14.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 14:10:10 -0700 (PDT)
Message-ID: <69d6c432.050a0220.2d06e7.47d4@mx.google.com>
Date: Wed, 08 Apr 2026 14:10:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5613846411466871373=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] shared/gatt-server: Add bt_gatt_server_set_permissions
In-Reply-To: <20260408201415.488511-1-luiz.dentz@gmail.com>
References: <20260408201415.488511-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5613846411466871373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078904

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      19.80 seconds
BluezMake                     PASS      649.70 seconds
MakeCheck                     PASS      18.91 seconds
MakeDistcheck                 PASS      241.03 seconds
CheckValgrind                 PASS      288.56 seconds
CheckSmatch                   WARNING   344.91 seconds
bluezmakeextell               PASS      180.07 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      1002.94 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:279:25: warning: Variable length array is used.src/shared/gatt-server.c:622:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:279:25: warning: Variable length array is used.src/shared/gatt-server.c:622:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:279:25: warning: Variable length array is used.src/shared/gatt-server.c:622:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2026/checks

---
Regards,
Linux Bluetooth


--===============5613846411466871373==--
