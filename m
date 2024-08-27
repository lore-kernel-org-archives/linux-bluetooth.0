Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382279DC
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724719493; cv=none; b=jH/eMCBvgY3NkpxdGG3l7UsAMwTsHeGJSbDUITYn3BlQn9cWFFzCXygrTFWpU81v8JuCiqv3hGvZA8J+oAJK/YMUEZiZohj7WTldHJI6PRkO2LkBE4C+oFBl1ZlPRItci81vuF+S5lwwjjiTkXUG/Lfux6lPjX1akxtmpe+XOfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724719493; c=relaxed/simple;
	bh=zvjkSQSupMbJbc/wNAzmbt4w2TpRhcDckWGYKxRnuVs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UQ/sSl68DokAs9NpRcwJ80crJmINOVikAR2GzFjk3NRIWiaAwn1Tkvs9mgXSQLRC+Pb5zZpEo8ieL7j51ixOJzEwVn4J43DGXoukhUKh/dLE6eyeFZcIE/eb+Yfz265jMhfmVKa/ZKWGhABM1TaIejfZ5vYGurLuAX63NsUEZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrisN0PJ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrisN0PJ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf784346b9so23389446d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 17:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724719490; x=1725324290; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/SVBXyMPvHol7DlNy6lzvlfXnqr18k/imux3nDagEKA=;
        b=ZrisN0PJJmZxnAX5gTN1tcrm0hBaRlyyvzheeU/rpBJZWbxZWicjPS2b0DhBuS9AqN
         IP98G1Qu6Uv5ssaCr8oQBSDqZzhCCtDxr9HHgdPF2J7Js3IojFNiFGUMq2oXNyRdXYxg
         HT/r5KcJJF6rt9vrlzuSowdNcNIPPoY5BixUGTwOFTj3DgdAVHgJciOq3cDy3iF3MPzc
         /VN4SKo+b23gfZa344cAmcbthjXRDIdXmDpnRuc9wBzudrxctauKB/JjyWzX2YcpH187
         o5uFvRHs8u7Hdro8GGERBFft1UN/yCYjf22CG2ubEJqKbn/tO5WazpET7u94wdNedxla
         2CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724719490; x=1725324290;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SVBXyMPvHol7DlNy6lzvlfXnqr18k/imux3nDagEKA=;
        b=YKOoGDqdDxVwRFr5/4RMX3d9gDbt1mihDm0YHr1WSDeYM2guO5QlLs4GVfuZmNhsyP
         zdJA6VjnJLUaW5U465Vp1Waq0T6KjQoKtoTmPDy0HB4OF4/5a9INVCugxDpdtEAqhgtI
         aii+UzaB9IOYljzeE5xoq5rVII+tmIjlMoserQgb32lSpUVw7DLfRHTCfpz2PIV4kdbz
         htFxWK0xMIj3di8ouWAx4RbXzMasc+/dUoxuJU0xdmrbOHSaw/OuhV3TU6c0KGYl3rsa
         +Xuly0UhJPF8booPC0fs+ntvtwpEL0N861lpyjEFanDSW7EirXuqWv672FppnTFPGQjB
         zYbw==
X-Gm-Message-State: AOJu0YzPviNM+YtNhbQRndnGSjIwGvOkCdoTw2RGvk5FT6BuFE0UtPJr
	zWQY9H+TvqwUbKAJMuSPgk67qrXOb69I0ybg1uBTXU7EoozUbXLDpxHTZA==
X-Google-Smtp-Source: AGHT+IEz16syYtWZ5QSvlagAMsxGn0WhbG7f1yd/eAOW/h1IfI4HQpXorJE5yn+sUyfgnE2fLWYpMg==
X-Received: by 2002:a05:6214:3c97:b0:6bf:8912:4213 with SMTP id 6a1803df08f44-6c32b7efd0dmr11809436d6.38.1724719490548;
        Mon, 26 Aug 2024 17:44:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d7723esm51285586d6.74.2024.08.26.17.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 17:44:50 -0700 (PDT)
Message-ID: <66cd2182.050a0220.13420e.2554@mx.google.com>
Date: Mon, 26 Aug 2024 17:44:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7615184434742745368=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raj.khem@gmail.com
Subject: RE: [v2,BlueZ] Provide GNU basename compatible implementation
In-Reply-To: <20240826225318.1333106-1-raj.khem@gmail.com>
References: <20240826225318.1333106-1-raj.khem@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7615184434742745368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=883563

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      25.04 seconds
BluezMake                     PASS      1760.52 seconds
MakeCheck                     PASS      13.63 seconds
MakeDistcheck                 PASS      186.54 seconds
CheckValgrind                 PASS      257.27 seconds
CheckSmatch                   WARNING   364.36 seconds
bluezmakeextell               PASS      124.70 seconds
IncrementalBuild              PASS      1549.13 seconds
ScanBuild                     PASS      1013.79 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:136:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============7615184434742745368==--
