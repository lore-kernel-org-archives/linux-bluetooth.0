Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE64FDA77
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781232; cv=none; b=maQoz4AACRt5AregiVqZftColGU3nOy3IICzg7dmuDbRwncGuulDkfwnsHbOQT+N0A8e8eFuYiJJjYy9tSfwdq7C9kZDJeBIbiQ4/QLiV9W7wpTlhQYIhaEVUrI4gfTFqeZDAzjZMxVbthqvdp/R6pSFWU3R8mSu+EJ6rC2IDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781232; c=relaxed/simple;
	bh=uuXsARlorU/Izbh6Awy/UpZVj+wbytlWX+fHljQyFHc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qC48d0qO2WMmlUE8v5TdRuhsAsajM5UDg6/3pEQQrGgzgJKXyP46/BVTt6I4eHofr0nzvpKyE5gaue0I4To8MdzBYL2d3byuCaqOSXQHL3KxQYRHgxUJ0r0PvOakUYKDP55F/6yXmbv7FTqBbvFRl1CmgttZyttsFwaBIZNvpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQdEWZUY; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQdEWZUY"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309a20a55bso53402471cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790781215; x=1791386015; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RucbYJqdZIvvsrM3aOwT8fXtxAYQZP+NzcjE4zCdRsA=;
        b=fQdEWZUYUgylDwXSpdMDiArvtlGeAWNOkNUk6fP7+zZsOxR/pkkb6ZIsnFZ0Kugdzs
         hVOYzGQkwdQeE/0ENK9RRBxSdnOsmayBoM5ULEXp1MeqWwWdaM51Mc9wuj3jJuGqYjrW
         wFtsXYg+sXK2Gvn4RW9tSVREaUgjy19VDV3+S6/QAn95qQsgUEf50UowCfuf8Fqah5bm
         +UaJqUin04KJjBa2F2zqWgbDPikCUy8imSetD7JEONkkO7UKXS0vH9P8auhfU5mbEl97
         nC5TFXkJ6ERvGsN7fsUB00qxYL525BzhZgMPBkeDriJS614cjE5AdVX/2/ow03PRkLau
         8mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781215; x=1791386015;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RucbYJqdZIvvsrM3aOwT8fXtxAYQZP+NzcjE4zCdRsA=;
        b=gQn7We/S/nc3KEBsXJrugqTZmjaPGm37BWnavkQqSahdDzUah5Rq9mdwkI2FqPApVV
         HDPm38TNlLIM0lksYYzJcVyk3nEDXEpZVWScNhGgaq8BOPGw3UQDRKduUoGG6+8x2Ukd
         h5MmL7esoNvjpS3B0uynNY/UmpPSNZw1KlhbQDOhWvoYbTgtugSWrD95v7b7rPsWbCYX
         XRUys0RcLWwsYYHLRMzaF1Fm8SJgXgpQUWNlnTJKzcEuDQ6LJHJz63mslQf+BtvAUmeN
         1CCgrx4bp39D21sRE/6L5GMHFqXF5VD8AWslnG2SJp9MObQR25YGFO7aPqLVhLhQB2wo
         5+TQ==
X-Gm-Message-State: AFuF++krA7V+YBdTFEQlXfHfn8wsG7P8ayxfPGo6wX8RZnuuHjFOy7ZC
	AdKLFQlj5IIMYPrFDAphbNpcliHdX5b52GptmwcbDeUWOV9bGbqiJQhZ2vMCPg==
X-Gm-Gg: AYBFou3YBOgWQAbaN1xRewi7QWhL93/LVPBk0mW/FfdzRnDO067HSKrE/3Fv7RnZar5
	ceieXxv82BLrFnmJvpudLnsTJK1NHBa2F4IcnzO0RybmfBdYQzbvQ/lIuIQs6sgVqHxW+A9j4Vg
	l+W1WiCRpxc/eYRuRMrfpXZbHbxuCpTW1qPAzqTzsO42EFEZElHUQHRIfq0xfIGIdc8OqYzhmB4
	NFXCMPP5Wt7/MPwQA2RBzhiXhPAR7iJ216Nv4fIWvqz2nGzgoYzfDl+oZkyzX448lMitKx2RUkk
	tlN4BXAPispqxucUIskHx/414eYxouIXQi05Yk/Q0NLCnYIM3pQxZO83LE7cyGsLoHweSRFQU+b
	FZoNFwlMpTxTX2HDJCn4EPzKykMSf6DK6lcESHHCcGyvN2NN6YxYjReXxSM1s8NZxfCVLEXZuzU
	nIfuNnVl35WGsi7flAjc1LQNk5yiZ+9M4PzaQXpkrsDYiuuak0kPZifxuMY+u0g/gw+uIM5Cu5b
	kDBRA==
X-Received: by 2002:ac8:588e:0:b0:532:ca19:afc4 with SMTP id d75a77b69052e-533742a4646mr31842761cf.26.1790781215429;
        Wed, 30 Sep 2026 08:13:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5338242e49esm1382821cf.7.2026.09.30.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:13:34 -0700 (PDT)
Message-ID: <6abd271e.a9f977cc.dd909.e3f9@mx.google.com>
Date: Wed, 30 Sep 2026 08:13:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1745095197516651048=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, altomanigianluca@gmail.com
Subject: RE: Fix use-after-free in GATT client discovery
In-Reply-To: <20260930093928.360745-2-altomanigianluca@gmail.com>
References: <20260930093928.360745-2-altomanigianluca@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1745095197516651048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176731/

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      19.53 seconds
BluezMake                     PASS      392.19 seconds
MakeCheck                     PASS      1.11 seconds
MakeDistcheck                 PASS      139.36 seconds
CheckValgrind                 PASS      149.86 seconds
CheckSmatch                   PASS      289.11 seconds
bluezmakeextell               PASS      93.56 seconds
TestFunctional                PASS      1118.26 seconds
IncrementalBuild              PASS      394.02 seconds
ScanBuild                     PASS      1115.32 seconds



https://github.com/bluez/bluez/pull/2613

---
Regards,
Linux Bluetooth


--===============1745095197516651048==--
