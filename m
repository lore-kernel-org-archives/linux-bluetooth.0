Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE22D46BB
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077537; cv=none; b=cg0r0pop9PwIW5R2jTyBVNZAXqsKAo3JxHI3lcmhPfI0k3g/AUXS3IhpGkXP+knI3/wUYvJ0GWLtxfsQswb32jPR3JVaQaXvlIbAa2xa3cGVoytmfmK0UND4vqYhXvVXn11TWmD3KH/eGPSk5nKSUaDNDvGJG/CNHnOMnJw1hzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077537; c=relaxed/simple;
	bh=yw4W0vhwVd33AuiJELZLP1qJdqtDyoiD3DJrLAyrczo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oEe1UtGVg+TYBqr1UQqmilxYl+4KVolfvP1fnCh0bVm8G8zUcw6nzkoI4VUdLiYBfW8dbdgifayfJT9LaAvl6NmcxsE1eZ7+iQ7xf1qROVW/x5q5k8uvrZFe3RQNXCutzkgj7jOjoW86Tq7K2PPZQQecrcif1NrTRwF0qMK7NF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE6B4co7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE6B4co7"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b08a0b63c6so72284711cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755077535; x=1755682335; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GCjvyQ014keOutAZJPyas4FI2wu2bc4B2OjqwSgGsag=;
        b=cE6B4co7jw9xFMK4fmxlzZCZcjHYiP5D/187TgIiCKUHA0eWRhWYksHWLd9MwYJkSP
         jwHlGgxC1eC4sR5tlJjDfu1EdRyvY6dlnmY6ChkfUM/J5ZBiY5ymwVQduwu1jvugfrd/
         FUarrbQTUiI3OPWHj1u37xsfm9orUBbk0Uxn9TDUm1f4kdy09gZjjyK72vYrXN0BHDt1
         oE6EB3aGtMdF4xxLxOmLzIxYokqTPL7Hg3NiG/E+IPq2ZyXL6ft+1oA3+A/qyRen6bz8
         0p6T4JzpzCMNz2ohUgAdi2fowEp9AITSw9Ey5KXsr8EBAl+cHq38yGwT8CjfIVYu5c+O
         A7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755077535; x=1755682335;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCjvyQ014keOutAZJPyas4FI2wu2bc4B2OjqwSgGsag=;
        b=rnEypR7hKn5qk0jZIjtaV53u1uGt1DTPDTcmo7V3LZ/zAPzPao75CS1bQUx9w9+siE
         B0FS7yfZc0HwzaZnajT1cHnbG/it3umfBfyd4ASZrcgVeTMS1ijL1MRqt4OE/n+DtyMw
         1/Y9MMsVcdRLAP3Gu5jlwuQC8V6WMChuYTkqJUqXmj+aFRPS/hlSQbwvZNxcS2uDcOmR
         /9R0zXFqeD83H53L8fTYRncQMdZASjilX+RkeXtMAPZRgK9EYN/dwl6OcL0Huyd6NSkr
         0tvd/kpsxDocDJT2WHgg6tdNAjLBfSb2W6IoKzqR5gjDn70mtP/7FnLnc/At97QCklB5
         QeMg==
X-Gm-Message-State: AOJu0YwPnxn6YgHUT7JfKYkpKBqbyjKFsGOcHogP44Fr6I1nibT+ffF+
	+eShEbBTMChxS6mRhn6yIsB5SBszJe5oCYMEPPOfP/Cykvq71yiDcDnuy0YAKg==
X-Gm-Gg: ASbGnctIk/ulpYzhJeXwqe6pAsENi0PBlBkN+e7BBkYb8T4IX1h8t0+h0hQWRy6Eum0
	FJ9r4oU4F6ShSQX+yPvj45fjXowKPJlb0TauDEmq0iT0OJUJo/1Y/oR0RRn3HPVcRe2ynNn1veV
	LmiqKBfUgwnx39SFTD20E2GQWghAgCrnMHL8QAp1z3A1ClSZmPy+TYmhS4UwVQYKY+txhzq0O7w
	O6iLQ9/cQf0wrtol91uWRSj5qEsqU5uuFA+tFK4FZPLicPsTxgZWNy011Ng2y1QjvfM8YkcVpis
	LICWypwPOyipfSFrI/yO9phaTqftj6AvqYgGsi6P3wmMWfEZM0oXn3BHkcLOfmZw8nBAHwZwQuL
	8zAa5Yi4PhJagkgRPT3H7vwiJzUF4
X-Google-Smtp-Source: AGHT+IENPuyATQIDYcJc2/+UqHo+xSmm8JVRpQls0E5TSIT/ZaYwXI7JnaI4vd8/mHzxANEkqRt/DQ==
X-Received: by 2002:a05:622a:4cc3:b0:4ab:65c3:37d9 with SMTP id d75a77b69052e-4b0fc7e000bmr34520171cf.33.1755077534613;
        Wed, 13 Aug 2025 02:32:14 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b09a2e6095sm98699401cf.33.2025.08.13.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 02:32:14 -0700 (PDT)
Message-ID: <689c5b9e.050a0220.c9d48.7330@mx.google.com>
Date: Wed, 13 Aug 2025 02:32:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1455136915369305981=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez,v2] device: Add SyncBroadcast method in device1 interface
In-Reply-To: <20250813-adapter-sync-bcast-v2-1-d73b183b4bf1@amlogic.com>
References: <20250813-adapter-sync-bcast-v2-1-d73b183b4bf1@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1455136915369305981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990883

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      2680.79 seconds
MakeCheck                     PASS      20.25 seconds
MakeDistcheck                 PASS      182.99 seconds
CheckValgrind                 PASS      237.14 seconds
CheckSmatch                   PASS      302.98 seconds
bluezmakeextell               PASS      127.68 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      905.09 seconds

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


--===============1455136915369305981==--
