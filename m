Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79E25487C
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435470; cv=none; b=i3926ApzbHB0fWxfc6NuIMJ06uXcg+EAO3Q9TciDzlfbeIF4jEmk6YDlbV0nfpr3hOipY8D2B5QBbhYok7Wmu7GVWNKq2rMf/TYMlJsxdig3Ms879XclTuvQMDZjqWzZ+14yOcElVYWR9bKINnNRGqs9Md3BtYvNNsnzKgIrJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435470; c=relaxed/simple;
	bh=AJEK7Crkm86y4w0BUe83wsURgxyNSvFqOcqJK9bQPao=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h1hfmzqRfYFwABhe43YRjCY9rK+9+TRp5Nv+1As0Mif93tAhbbul9AuEdR11kddik101H0Oed6ZXpC4JlPV7y/tOvS6EkZl1LNDba8NQRTm6S6twQoIkqNy/kCSojbJQxYwjLW4EiwWt8KEsgF+k5IKAy6vxj/EDjmSBWsIRC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP6xrT4j; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP6xrT4j"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so56974481cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 12:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766435467; x=1767040267; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BlfSewOn74V4aflBkSgxoijJ0r1yK78mRNANNaFSlww=;
        b=EP6xrT4jx1AX6v2clIn6lTzOhM3zjcfPcupcnZo0rjq3/Xyg+/9yXB1beyuz1fhxOk
         HkQsGS/tis7Dm42gyeV2+SsPsGWcCSgqIWonDhzxz4EPHKl8MfeIZh3aRvQOCtjk9mt0
         wsXXOOFvlFHeJEyajQA9ihj4sVchpIh80pWaIkxcNgwZ4ua5iapgXlMRVa3nUUdsyF3I
         yE+h0mUSzbi3SAJMKpwVLpvJH+vcdg9j9kBBHmzPg1QcK1HOqNIgHuM7XEvpMhStTgzz
         Vm6NNW4Z+8ukl6bRg5U1K2EOFVHfTXljlxJXD5VtSoi/CTfsGoSd/JztjdMVD2Er0LGH
         XFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766435467; x=1767040267;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlfSewOn74V4aflBkSgxoijJ0r1yK78mRNANNaFSlww=;
        b=w11OFgpiKmRDSU0089+t3Leu6mYRHM7X+OEKmVsmIIQwzsIGixlRdPgWsNE6vbDmF5
         dojyivlee0+E68pmjKYPrh+ibsVvPU9f0asAOXLCah7lg4IiQhMNJ20P6yElmdwW5JqG
         ceUiSbTj6XqfxzCmyUStFmLF5dJmlbqJT+LMb9W7/kdNHMxthxRb9WBiKqhZk6p77t7O
         kx5GJCj1trRyhwgL2d/q71svKkCBCHe+jUgQWs0yquYvx4idZsomCZVTJUoPg4hqES+c
         zUSkSr11SIUZlhZ7ehldL+Y/6dl1jzoHJKm/o6o6YV2CduweDjXQQTZExDTScJuu0akJ
         1xxg==
X-Gm-Message-State: AOJu0YyaybxmUI9nbfxQw548s214rhUxGBtx9nuUYaze4kcm9CE9LdR0
	PWNkOOTYNGdf6vwlUJz+a3Yul15TmY/n5DlETMYe/d5oZgtk50lUo0eol1m9o0lj
X-Gm-Gg: AY/fxX63zSdtzj/ZP+uNBqe1BVxFba1uCzC6FeBrLuuR/hfr5F6ikEmdjGGGvtE0KY5
	FE5MGJbbgj5oIsuSjlELsX3SpsE26wc7BySlYiRr8h4WvMe2cF/ls1pYDLn03mbvQf7M2WtmMug
	z16p3f34JnvJcZ0J1klqyYO3KFe8dkx5+JczLNvfjvLVCmtBCGP8tl+axKG4EZm8n6h6OoHbnES
	SqO/XkQHLtgke1yATorinedLOY9vhfSPTcD+r0dnze0r/M9pkPHGDqA+SMHtNAXn8bLP0+ig1ED
	fyuTrWBr0UOAoq1Vl6baPG7mwVaQoFmy2vPFumFHbCfOD8XpB3VA2FdCrz5m81GDN2VVjECojbr
	NB2u8RWyTzl2WLlEw/SRzyn6IusVbxYxruFk38D+QnTviHi0LavsOb2vRV+7eqTm/vImAjMwaB5
	l7gXt7yONqKLfkA6/Ycg==
X-Google-Smtp-Source: AGHT+IFXnJFXJtJqN1KnGkjfgwJfFB3Z6zN+mgl++fMIkoP4tNToL99b2MBK9+8H9WkgkJfJUyk8Yw==
X-Received: by 2002:a05:622a:108:b0:4ee:c1a:f11f with SMTP id d75a77b69052e-4f4abdd30demr178952271cf.84.1766435467201;
        Mon, 22 Dec 2025 12:31:07 -0800 (PST)
Received: from [172.17.0.2] ([172.172.87.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4d5b4c975sm15314181cf.1.2025.12.22.12.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 12:31:06 -0800 (PST)
Message-ID: <6949aa8a.050a0220.1b3c64.3c91@mx.google.com>
Date: Mon, 22 Dec 2025 12:31:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1058128725335284769=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] monitor: Fix parsing of BT_HCI_CMD_LE_SET_CIG_PARAMS
In-Reply-To: <20251222193504.650019-1-luiz.dentz@gmail.com>
References: <20251222193504.650019-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1058128725335284769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1035801

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      19.97 seconds
BluezMake                     PASS      627.66 seconds
MakeCheck                     PASS      22.09 seconds
MakeDistcheck                 PASS      239.58 seconds
CheckValgrind                 PASS      299.14 seconds
CheckSmatch                   WARNING   350.46 seconds
bluezmakeextell               PASS      182.47 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      1031.97 seconds

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
emulator/btdev.c:470:29: warning: Variable length array is used.emulator/bthost.c:700:28: warning: Variable length array is used.emulator/bthost.c:701:32: warning: Variable length array is used.emulator/bthost.c:918:28: warning: Variable length array is used.emulator/bthost.c:952:28: warning: Variable length array is used.emulator/bthost.c:953:32: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1933:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresemulator/btdev.c:470:29: warning: Variable length array is used.emulator/btdev.c:470:29: warning: Variable length array is used.emulator/bthost.c:700:28: warning: Variable length array is used.emulator/bthost.c:701:32: warning: Variable length array is used.emulator/bthost.c:918:28: warning: Variable length array is used.emulator/bthost.c:952:28: warning: Variable length array is used.emulator/bthost.c:953:32: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1933:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1058128725335284769==--
