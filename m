Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374103;
	b=oDa9Xy//d6050p0GsVNd6BqFUNFkFrp8JW4FBvuaUiPfzlchIlH3/HmUZiOqL1Xs3s2J
	 kcfMcD6RZQ1eZhJ5PqGbfvGzfmMpRIoftxVU23mr1J5rbhpD8nhSSzEG/7xy4gyyF5gpy
	 P9gKDaWoIoCdgq67xTtNmh+xQZ4K4FhWvc88zy5QUahEPLoWGRfWjq65WJMlSmrWkIhxj
	 KFAskuGesAzkrzhwvO+r8jf0slzt9yedFR2RM8L2OM0LZ6+1HTzaAqvabLSOY3vAJlS0v
	 YgEeUYqzqipaDq5S8Og5KM+LYqq+EcWEm2Ato13iOMf5/Kx0YNu+pijIMgzgcHqW+ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=gpffwjSiEyHToWNigVj9ksxioIGBV7p/tQ8L4S6qxxs=;
	b=462rvC1PfcVucVHk+nr8R8oLCBHbqRf5VfSBYqnEJd6eOwj+r7klNrd0PxFvuOiUkFoU
	 Hyz8A7eNTxbFa3AiQ0CeR/E7ULsJmFnHKQdWpS/xNulhR5kuMGypBBcnSN5ihBXs/xxkV
	 XrlVSPC0zlYl9vAwN1pCa9Z+HGlVdRA0HKBUO644Tv36dy/NCRx5TDqPPVcnTA6e7Vl4E
	 6n2zAq0BcvGGFpqcGTOkHzTlGffTUZW6+uvajkMhHW0T1Tbi7gR45Sy/RPwMLQB5Ve1N5
	 6gwNhIZa8heQ5emJ0XoByprWpP0rENaBWAgbLzqbv1bxUpSiVqlo/c57nr5JcGCO45w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AbiuCu4W;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F6606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 19:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D2F6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AbiuCu4W
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53644ab1f7bso24582161cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795374102; x=1795978902; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gpffwjSiEyHToWNigVj9ksxioIGBV7p/tQ8L4S6qxxs=;
        b=AbiuCu4WA8hViYrm0/C74CAo3T8J9X/9+/agi1FtYAVXHuPTl04sp9ndBlzL5Nl5Yp
         W5pNJgfMbxqCd/Fbq0w0hqmRzjW2yATpmPmzpXkiXvdq7HqqznWxDG/v/zgZL+a0wArM
         1iCj9DVI2eLRcEHGlhWhtNS9ByfUCewBKDvXQ9i+3iYD1Ov9X8ydRrYGVi13AsNGTsug
         +bCg52uOh0gV1Emn7QndEsTnX4QymXGGlsfM/33edTxs1kbOavVWScnCuZXq0Smx4pPf
         M9MXQhU/g65/IvoqsFHPX2uZnw961u3m5R+mAdazcs4CMUwzCtcoHEsP+xnWZgsu/duJ
         YP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374102; x=1795978902;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gpffwjSiEyHToWNigVj9ksxioIGBV7p/tQ8L4S6qxxs=;
        b=D0tNjUhwlXjDCKGn4cw20vUWD986b+mm38oWNZifv1KxDKcrvnOmgY4/uhrno7VI+q
         Hmb96/spo99biIHb1er0RURnl39kKhI2aSal8X6W59m+HJpLJRUnsNxm9/u2+ZSx1Lpq
         vs3M+Yix9VbtCX43/4cJnGhWw6YSrAt5s0yMjJjZ2vYJCSdV6oBDpezZ+4va2vu7JCHr
         G35/xXo9PITlkIvkgmcMqKIiHtQqR/oRgxY3RvpoNX5HyHke04e3ZaP1y+L9E9IoHmln
         pYQbFb2XIwUjacUk78NHQ+65uWlE27OSDulQ/gBi3ucA/wP+Hh4xis0HKF5pvejX9dsL
         QcRQ==
X-Gm-Message-State: APuU4Z/9a5WIx7TpKWRxFZckk171j1+I+36sSc+/H4q35YsUKjpG9jge
	HF0UxK9z97gS4SZAJBSPNcyuJpRetmjH9LLcaQ885bjV8O8RQkuSso5ENhxJjr+v
X-Gm-Gg: AZFdTZe7XR8xcw6waJ7jstR8W8nr7PCDdEMooG+hcNX2E+9lcfo0VV+WA2MuMcVG9sr
	cWVZ6YGjcu1AJPDtf0emyMnFMWIR+cKJckeruAM8o0WzDcdwtG7yqv9oPyr22hfl6p+qKz0k5VY
	JvaGYVfRlgG9D0U5unLlZOdHAV9Gdhjkew6K1K4+4rtGxFlBdIESdSHKww26vzcirXKz/a10oTd
	TazgvmKfXv4Jb5GtCPUF8m8tFuZRs/BNeEapBiITHn1sbONLKM2ydAjGElxvklg7Gq5WposBvDc
	HWZeFDWbWaVmNCSSGz6ezDc40w0jUJN12jq4DNLcs0qZ4tEtC8qWbvpuKu83sTXMlN3Yl0BXQIo
	cG06O3rcyBWuJzV6p7+qf1liU9CJWEQrExoirbmQNFMyX27+VUIn65suFBN2wb78rqpr+f8Aap/
	04msHaf4SP3F+MxO3J3B/HUyabn/92p4QmiIH2yrY+FSLAXlAZA9gtZbKhvJqYk12jNBzPhOX6F
	pIupCAKfLSmwyfTgRsTTHJhaCO4093d4wJoL0avfJGZnYS93AZGlykJHZMTGWhsZ6/AxXjX1zjc
	nGgrY1N7TSE=
X-Received: by 2002:a05:622a:613:b0:55d:3254:6253 with SMTP id d75a77b69052e-55d76a518bamr172495961cf.42.1795374102432;
        Sun, 22 Nov 2026 11:01:42 -0800 (PST)
Received: from [172.17.0.2] ([172.174.199.232])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b0b10sm85617246d6.10.2026.11.22.11.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:01:42 -0800 (PST)
Message-ID: <6b033c16.eb52b69a.c502d.78db@mx.google.com>
Date: Sun, 22 Nov 2026 11:01:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7796180484859121993=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
In-Reply-To: <20261122115045.1077168-1-simon.mikuda@streamunlimited.com>
References: <20261122115045.1077168-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7796180484859121993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218594/

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
GitLint                       FAIL      1.40 seconds
BuildEll                      PASS      21.50 seconds
BluezMake                     PASS      321.48 seconds
MakeCheck                     PASS      14.99 seconds
MakeDistcheck                 PASS      154.29 seconds
CheckValgrind                 PASS      361.07 seconds
CheckSmatch                   WARNING   352.83 seconds
bluezmakeextell               PASS      102.40 seconds
TestFunctional                FAIL      1306.56 seconds
IncrementalBuild              PASS      354.59 seconds
ScanBuild                     PASS      1252.88 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,4/4] bap: Close a pending PA or BIG sync when a broadcast sink session ends

1: T1 Title exceeds max length (82>80): "[BlueZ,4/4] bap: Close a pending PA or BIG sync when a broadcast sink session ends"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2875

---
Regards,
Linux Bluetooth


--===============7796180484859121993==--
