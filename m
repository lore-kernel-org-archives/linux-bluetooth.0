Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB012EEE8A
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250651; cv=none; b=Y/jmQCTvukL2QWwchZOjkpHdyiLBktMGVkYPDu0eyVytUlKnDOqoG6qFxqXvmJbzsT1aIQO2AgEQH8p4fcSqstDlAHTwCaPn5VQ6Mh+DuYVpjQwWCKC/vo6swcKZBKrO32uwryYBn4meyiIp8THueIMJLXQCtUsTM3t8FIeoSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250651; c=relaxed/simple;
	bh=KHaH0kHsjKinA0zCVjb7jqPiGa9M4jVZtSJXxXsPnJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=forCFhgx3jEbnfR1ExKgrUTH/yVBLSB3DAsYFBCr6/yqEyQnAhHwBZvHbi1b9iKXZWMwNBWOtQcxtZg6Bla4R50HPpyLVH3jRTrCHVhX/0uKCWpy6htSjPeDmJ6JMWdL025rx7q5R/Rs1tJjKttFN0avCgghO3cAdavRdhUlqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS0Mq7Et; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS0Mq7Et"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c30d9adfa7so127944e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250649; x=1787855449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FsjnegW8pCHKoWIzCBi9+Zg6ERcvi6SY8la3RRHpoqs=;
        b=iS0Mq7Etov+KYTf1LNvMJofBaM8uuCmAwzAsk1BX8564pw5jlfS4O0gJ2XVl+vgE7q
         pwLWxY/IG/tsdQqoEn/fLsmWXzJyP/2oa4CA7vB0brBjd5k4ISoVRwOMJq/Qlm32fWGB
         DbDsoziA8hVw5c8YReb6heT5w1xFaPtD3GQW4bJvDEAsE/kzl4WWU0MOiwfmf2oXvBNh
         sjwyDLdiVFCIzU8Pqp/MOz4gwdslLT4K0YESSSd51Ue05v1lIWgv20DXJIukcyG1rO+B
         6G2qq/DTDTu18amNfxVuIdGnM0XUubkHCbrMFgF/isC9LKuXF8FnnyNs8GcQKYz5YlaV
         lhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250649; x=1787855449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FsjnegW8pCHKoWIzCBi9+Zg6ERcvi6SY8la3RRHpoqs=;
        b=ZrUOeQVFDuSxQxZCE9v4cYuep8rwUUKRNYktx582ngeehBGG9wooE7lt3dkSkwTwCQ
         MO90LAt46rtjVSOluv1tD7PRjowWqwOv93DHfOS73wjIDe1leAAu4uy0nVDTuyTwaTgJ
         W93eb2ly5b2+ch8y5DfKZ82OfOny0Z5sxDYjjjbsnXYQG+xV+11G9Ojls6UoFNoilJC6
         4L7CM+73msVjR6g9AfRC3iXbiczYGW2DVnUvfUBAfJ1T8thjv9R7MlleW4olczfHJlW2
         voP6jp38aND4NhY+q07epvdWEk5hX42BEHqNNEwx3Tv0Zo8cFIXV7CwcAJm3qaekdeF9
         kbUg==
X-Gm-Message-State: AFuF++kZhf3/fPG3mhHfbk2sEwz0dk8j75q/DcIGiYf1PPmTBuKvuoci
	O5CG31b6KKennMvJWXl0luGFEESp3TKFrgAOVoZKnFkrn7/nAcpv3RXJqa2hqY57
X-Gm-Gg: AR+sD10uN3+CRSUBVfKTHZAJi3DNUFQ11+rFFNkvxvw6uSkfHFa6qVo3pCrSQ+4kEXv
	zkN+nKQ7tOo++dNRfPn03qNW9TDtg1uLkQ1hWmILWrw0LxPv3D0rQt7AaDfBdMcSFtm3mbdI7uu
	9IXA7xEchSFye01h2C/Y6BPX9EdyoRbqoawVKC7DW072/R23xiwLtk5hJJgB3zAjGHESxIvDHrU
	SRvXH570NkLiLnCJOaJA3Y2dNIk++dUtiN4PATcUl+avqJKAywL71ry9Abk9XJyKvvhtthcBtYa
	q6DJpzuvdLu+V62NGJUCpN3ye3gb75Y3Q6W+HVADbLdXgF+1X/lW19Wrt45TfeLAfN1/1w4Lk4U
	GBSyYUlzRxJ2UcIIVomw82IWO1gJd9vxee8uQBJlCfqH3pN37jUhAkiovUjAs0OdcMIytVO+F/w
	uGpBpiNNQC5Q3MGiAYE9P35yHWFkHWRW0bLQO5OTwzOrmarrXE6IWLxoeDSBDoHvl62G/PxKreP
	XkYgrBfWIRVYb1h+kV+qjwVIybw5Q6gWzNiqA6uy2hFOA6vnsg9Sg8=
X-Received: by 2002:a05:6122:1827:b0:5bf:4522:fca7 with SMTP id 71dfb90a1353d-5c5ff779725mr373656e0c.4.1787250648713;
        Thu, 20 Aug 2026 11:30:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.30.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:30:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 01/10] eir: Fix stack buffer overflow when parsing the remote name
Date: Thu, 20 Aug 2026 14:30:28 -0400
Message-ID: <20260820183037.2713973-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820183037.2713973-1-luiz.dentz@gmail.com>
References: <20260820183037.2713973-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

name2utf8() copies len bytes into a HCI_MAX_NAME_LENGTH + 2, so 250,
byte stack buffer without clamping len first.

eir_parse() only rejects a field once it runs past the end of the EIR
data, and that data is up to 255 bytes, so field_len can be 254 and the
data_len passed to name2utf8() can reach 253. strncpy() then writes 253
bytes into the 250 byte buffer and leaves it unterminated, so the
following g_strstrip() and g_strdup() also read past the end.

The EIR data comes from a remote device, either in an extended inquiry
response or in an advertising report, so the length is attacker
controlled.

Clamp len to HCI_MAX_NAME_LENGTH, which is what the local name is
limited to anyway, and what ad_replace_name() already clamps to.

Fixes: https://github.com/bluez/bluez/security/advisories/GHSA-68h6-5qgp-3975
Assisted-by: Claude:claude-opus-5
---
 src/eir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index 89c15995a546..4421b1662d65 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -137,6 +137,8 @@ static char *name2utf8(const uint8_t *name, uint8_t len)
 {
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
 
+	len = MIN(len, HCI_MAX_NAME_LENGTH);
+
 	memset(utf8_name, 0, sizeof(utf8_name));
 	strncpy(utf8_name, (char *) name, len);
 	strtoutf8(utf8_name, len);
-- 
2.54.0

