Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02834204F94
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709143; cv=none; b=pxtFC/aAksjRw/NEhAwJln8AQrdyO2duC7zyPy2xT5D0glyPDeg0Q3XWIggOaGJOqNktieXZTgxB8fpUv0Eef8bNt2VuNc0eIgT6iECpzpjww5h/vpdzXTslVNvZHGrfTXp23p9l9st1T/wmA6iCUiF3bU89umGBgvHXgieMbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709143; c=relaxed/simple;
	bh=4r0LVSwu9BY8KGOnjq4+mAc1zep4OFnKIfHl8Mo/3CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7PXEKXuQhNkjCwJ6tExYDl88Lt2avJFwFMsdX6hn88/d/jtVhFvHyFLZwhTpHHn+DqAtDgfEGro0JTEwtSxgYFHj6hSWuyiU7A3n1Q2VZxqqXmGldKtiC47gh2aa2f+K2DdBAp2kGA4ncoPV3C3sMTJ2vyv3v3pMx5V5d68l9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koV4rikN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koV4rikN"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-305d843d925so48728881fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 14:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738709139; x=1739313939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm3T01CnzRsyn6KqTko+i/bJvHalZXr2+ybdk4x7CNs=;
        b=koV4rikNwSlYSUZnVASpHEBjzV/8x2yazb8NKYY2ZQz9JsiE9LtVLv9R2zmPZdGdip
         ZWxbgZ98zeya4yvCoES5PgCWszku2ueryTkELRiM6lLL6SXZxPZ+rvaVufNM3WxsDinq
         J7VTaB2+XsMc9M9oo3aItbjRt/yNmCQ/KrKtSlLt+bNIofVl4i83Is17LJwfk0a/DP+G
         8Se6IQyJq8V8qdz/iDZ4cTCdFxFithnRFtUbhC7uDeaWzqv2rUtnT2++/JSxlw2s2kZk
         DdDdj6rdPYncd6XUnMgWLA1CbzdndmCmoJPIsgUmtSVRMfVN4tV0eCLFCaol1UXFyiTY
         OS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738709139; x=1739313939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jm3T01CnzRsyn6KqTko+i/bJvHalZXr2+ybdk4x7CNs=;
        b=QRBAQKbmGq2wWPMRFPbJcLPE5PevZu/h580asOX2YQ5+F8jazpNbAdPFhDhcwmpJWV
         jGpf2r4dG09/qITAgJfWdrd9dic+NsP25Er7V9cZFxyTImIgAEinTwa4zsXjgz8bSOQv
         YMQiNnOa4YQgUH+KNZFbVDiHj/WGg7M6+bBuQjpZmNBQbhF1cZnEfD2a80IGKeV00Y5V
         a9Tpz1eBRQIXCwswjGSJiPr4Et/wPVrTjT7JO9k+sxFENVo4l+PfpuXa1RcMry8PzvZS
         02U4XuxP5BptqlC0U5eJBrHl5L+IOMFuUUrt3oMIoNbsPwDtcE1/i2wG4du2WFf88W7G
         hxTQ==
X-Gm-Message-State: AOJu0YwMf5q0MujCEN7EGnTS0fRVA6ai4EaZUagcjGBp0J3l2R3iYaiV
	SJNt9tqCwzaRQjmYHk+L+LtpBBKFsBWnVc1BVO28fc6dfBj9b68AImXB6zPCoqfbft6ORMNf865
	j+l3tr+ZPTdsbF8e1rlFwmoD+ylx+Tidvj8twoQ==
X-Gm-Gg: ASbGncuF3+rv+oNcXrKRdDG/OvGtQdXxcRpWTRUmBcRUarP0CL8fu08Sp5mxdrrQ/pK
	e6t2JjZPQYkQUv6L8FF2X8Hhq3tIOHFpq4jUeH28y1UbqJkFypLvwP05UqBcrsL+AxsaiDoA=
X-Google-Smtp-Source: AGHT+IHTOm5HA3bRjFBOTEqmGQdby1Kih5gKrcgjhDrNjfbCsDx7nBOJASYW/RY+y/TctBlpZY3tEQI6CSrvc4UKous=
X-Received: by 2002:a2e:a988:0:b0:307:2aea:5594 with SMTP id
 38308e7fff4ca-307cf31451amr2143661fa.18.1738709138818; Tue, 04 Feb 2025
 14:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204064103.672327-2-sanchayan@asymptotic.io> <67a1c417.170a0220.22989d.7a4f@mx.google.com>
In-Reply-To: <67a1c417.170a0220.22989d.7a4f@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Feb 2025 17:45:26 -0500
X-Gm-Features: AWEUYZnaBvTBs0RYvE_WdsFV5uUe6KUVdZ9K5Tbu27xjRCL4qRpFw5WXnzMBJ60
Message-ID: <CABBYNZ+W0ueVA9_-j2qiTYjRtg665WF1NfKfaNRtnxKs-2zk9g@mail.gmail.com>
Subject: Re: shared/asha: Add support for other side update
To: linux-bluetooth@vger.kernel.org
Cc: sanchayan@asymptotic.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 4, 2025 at 2:39=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D930=
325
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PENDING   0.35 seconds
> GitLint                       PENDING   0.40 seconds
> BuildEll                      PASS      20.57 seconds
> BluezMake                     PASS      1532.14 seconds
> MakeCheck                     PASS      13.34 seconds
> MakeDistcheck                 PASS      161.98 seconds
> CheckValgrind                 PASS      217.89 seconds
> CheckSmatch                   PASS      273.81 seconds
> bluezmakeextell               PASS      100.40 seconds
> IncrementalBuild              PENDING   0.33 seconds
> ScanBuild                     PASS      880.84 seconds
>
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:

Looks like the CI is not able to run checkpatch for some reason,
anyway locally Ive got the following:

WARNING:AVOID_EXTERNS: externs should be avoided in .c files
#11: FILE: src/shared/asha.c:44:
+unsigned int bt_asha_status(struct bt_asha *asha, bool connected);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#107: FILE: src/shared/asha.c:140:
+            DBG("ASHA left side update: %d, ret: %d", other_connected, ret=
);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#112: FILE: src/shared/asha.c:145:
+            DBG("ASHA right side update: %d, ret: %d", other_connected, re=
t);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#146: FILE: src/shared/asha.c:229:
+    if (!bt_gatt_client_write_without_response(asha->client, asha->acp_han=
dle,

- total: 0 errors, 4 warnings, 238 lines checked


> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
>
> ##############################
> Test: IncrementalBuild - PENDING
> Desc: Incremental build with the patches in the series
> Output:
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
