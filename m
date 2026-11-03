Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746281;
	b=Gze6B57y7UH+7M3O7nViYnQXbO+S3YYiI76QmEoX2VQ8VBwzfpYAm9lZdQpX4DXDIEGm
	 dj9U1oTBeMP5bU6lJ6G/qPRGlx3K8kEgGsTxoKaB8mdarjPjLHa98oHMZqWipxsOUr7Z4
	 Dz4gJ5VOjlfSnH6HhtFHxRpw2s3bZEm7HwZYDVJI8XKHZohoFYIcW3n+TxWbBHK0Dkx59
	 4kf/3HH6z6D2Yte8XGOJ+9GaKMo+y9P/5CMlozU67rlFZFIsslovaOAp0arp/DW8p24ir
	 he8zk4ETYCV6+zKW2FU/X7Ln7GgLQXeGjtwK4Tl0PnxFBDgIiP7DWzHHvvI10lGD/0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=PBqSuoEql5TB+YeXp+3N+ZdPOa+sCLRO5eNUWAsTmmY=;
	b=Ll7J0jImDu7H6bC9QRWAVq1ZsgRRVc5l3DsflIK7YyqyRFTGFldYcqH6bhvoUqrVwc8n
	 SrSCsrlxmtNQIKcfvPBJIIlUgFsxwU/9J4QxEmQR1ayBihC+XYIXDDbBv78hyk2wMCVgj
	 eqm8LbqpIGvPmONMl8QLd1AAGpjpBP/Dv0PRxFhbWEWt/QuHVYkFTWOvztbla6KdJ1Sev
	 8wwvoKXG3Dcab49Hq2pDb31gc2hVtco9vE/gKE3o0uld9KaI9cqseKJGSTg/rTiYnTByb
	 eL+szpdv/mNGWhWPjXKqt09zOP47P9H1ENazw5XQLnz00KbwoJ4aBdBKNwNWU2r4Bqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOinEw8s;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB8606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22AB8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOinEw8s
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1adbf62dd31so195892c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746280; x=1794351080; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PBqSuoEql5TB+YeXp+3N+ZdPOa+sCLRO5eNUWAsTmmY=;
        b=JOinEw8sZQY/R1LMiOKZ5MgxF7hNiOf8i51SGoP9oVg2yuFJSyZOCgMOmcyBQ8SZTJ
         QZ0zRU+9iuxZgY+Pu0hTqwxxvrH9rN23sVbtSZQLFFP3k6UJKHd9b7cJZE41S+m0qy/j
         kVoba+DZPmFm0It3DniS19TbqVwBm+3ep8SY+BQ9n7GWqSV4vzlT/bOGJ0xxVjAYWxnd
         xYRg/B/EtwAC0t0N8g8YaDLB6jmI+eKG8XrGLlOrykA2idEcCWFKGwFQvBR2uV/AnD3a
         GqFRmUZsjDd6KWqd7jzlIUJd2P74WQs6UHBis+s3wKcz5xLRoUDj6qcBGuKSiX8cRuXf
         AUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746280; x=1794351080;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PBqSuoEql5TB+YeXp+3N+ZdPOa+sCLRO5eNUWAsTmmY=;
        b=P8q9GF+TIx6QNHL4raYwgou8DYkXct9xokK9YjWs6SGMhdIeBO9kfwIKHc6Y7v+ffJ
         hNyBDGna/uH/Et2eY/C65piFWj7DLatCTkUwaWQA7RKHeYptSZyfgD7yxLWDvxood6HA
         6+hC826z7hzEMD3ZJTC1bSpJTxwi4RflAGsre+my73VG8S3qhocV98xENiUP+xGGN7vF
         xurNVuz28bFO6EwelCZW3/HIQqwyfSx3Z5sGy/t4VFbxpiTTZ+YBTfVaH06DUIeFcL+G
         Lc+s+FuUHeiIXjfmp8CjdkvaekuCpFRU6T2LtX/+df+GmWgrtZC96a+nCg2ZgzpKqffk
         wfaQ==
X-Gm-Message-State: APuU4Z9pMvWjrPWZ8pxdDfphlDj9t3xMtR7GcHC82VqJiUDlywRbcTFx
	5b/KYHLI/p0Amyu091q3ef7Ifw9X5w4UK8xUE4lo7t3AhgyCipd9z1o63yVZpa+l
X-Gm-Gg: AYBFou2qS30N2iE2k+dhx0YwNRBsN1kzbi6y1ElUuzn3UnOyobzsBtGTxLean5phZUF
	blfGhVs6dMgbAob6zy07CF9Z1KD9i1bNR9LpiolVXSsikMSTFC5WGkzsJiTmAV88DO0hTTD0kBB
	2nbsRFIbQBh58d6ZWlr6BGJMcOYQZTrUr9iwqv5cmAUr9jhs9PX7MoIXU/jew/nWr6FqZkH7EVg
	L0rqQXr94Nq2BBh7iyjQactKIrgA6zUsfWyi3NrnOil2LsnR+ZyxFHy3SDVBSSIHjphF8wFeS7K
	6wX5VU1dwtin72pHngS3GQKuGVSmJa9LAk9Tdli03GVReqV/DyE6ryc5Zxm9dIYX6EFOChuRAt/
	yTlrE+xW+5BfDFpOgV2AwOME4RQxRV+w9TZHJYoXD64bhTwLrZY/p4Wfrxvp4lLP/jECy19+ibu
	QqTwHH8enEr0NDN+nDhNAW3SS7Au31/8m/1tvPwcHXdCyzUqjiAoBz7MVqg2gDUu5YEOsv/mvnD
	f9N1FYL/iDof2cTMzPdcpMn56wqWWECDzCSDVJmyQu+0PW2NfaNz0wPECL1YJyjvP84B/kseQOK
	8irN2D0dzg==
X-Received: by 2002:a05:7022:3b81:b0:1ae:59d6:91cd with SMTP id a92af1059eb24-1ae59d694e9mr19451738c88.38.1793746279913;
        Tue, 03 Nov 2026 14:51:19 -0800 (PST)
Received: from [172.17.0.2] ([52.160.138.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b86fbesm2086048c88.1.2026.11.03.14.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:51:18 -0800 (PST)
Message-ID: <6aea6566.54e42a5c.246e68.5497@mx.google.com>
Date: Tue, 03 Nov 2026 14:51:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8139901485093625921=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: BAP ASE state handling enhancements
In-Reply-To: <20261103203011.3904290-2-luiz.dentz@gmail.com>
References: <20261103203011.3904290-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8139901485093625921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1200848/

---Test result---

Test Summary:
CheckPatch                    PASS      2.89 seconds
GitLint                       PASS      1.67 seconds
BuildEll                      PASS      21.48 seconds
BluezMake                     PASS      313.38 seconds
MakeCheck                     PASS      21.60 seconds
MakeDistcheck                 PASS      154.84 seconds
CheckValgrind                 PASS      365.43 seconds
CheckSmatch                   WARNING   302.51 seconds
bluezmakeextell               PASS      99.97 seconds
TestFunctional                PASS      1236.54 seconds
IncrementalBuild              PASS      626.74 seconds
ScanBuild                     PASS      1200.75 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2754

---
Regards,
Linux Bluetooth


--===============8139901485093625921==--
