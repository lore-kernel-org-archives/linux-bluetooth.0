Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27F2C3757
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295205; cv=none; b=r/2+4QSgGPGeoKj3VunkenlnpQMGpcz3G9uUm+X1PIn8Tn0GTYYl7V5lPZhmgjZG2LxBGPb8aC7E2To+ipOeEteRDP4SbW79UrShteA/6/dXmAC3N/HEcpsvFkpB+8mMFSc2iOzhiAoPVwmzQE8g/ZiUjzCiPahEb+nKRiMWDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295205; c=relaxed/simple;
	bh=C5zG+QJnWYmn+XlaQi8OYivxOimnqG9nXtchoCov5z0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Le5IdZZzuP8frLChIT1cNIE5sckh/DDkx6EtPa2yvfc66Q++ayaoeJ3ZlSAEVq/xuPZ9/sfq6hw3ZCm0qmAfEtZhEf1dTEFcvBT37EjAg+K7qYRtoQrQvcIbLjRoGWXtnftAl7r3sK8KAqXYYIercDvImGYdHeQERsyvNgiOq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5Emt+5y; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5Emt+5y"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so70225a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295204; x=1784900004; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M7PUbKq2htxpajWUE0vHjUzxmAv/0RJfu8hmUWAdsg0=;
        b=F5Emt+5ygQfUv64wbbhFA6XZVuwz5VVAd9Ap8XTml52g6BS9WV7p0Zu9bDrAIU1OKc
         8HtC+eDVWsa+Gm2nd5FL7MMjoJOo73xPzF7e8qKROvcVu9H/Be7ZfZKlyyKvMWYgS2HV
         LJOHqvtqoR+6K2QIx9hggOqVdtqku8r6ZsxF2WP1c3viE68+38Vgqo4jxvKRl/ljoj+R
         8532cwfKVUvdqoYjKNOUfiYbxg7+QUSyy0Sj4zquDFBLGN7zI7uSU0wJDumuethbh7su
         TlKsmB9HcuS1/AXiwgm4SF++ajAErclZOpG50WIvtAFvhNnKXTpL1l2DxA5lOxHha7YI
         gnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295204; x=1784900004;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M7PUbKq2htxpajWUE0vHjUzxmAv/0RJfu8hmUWAdsg0=;
        b=DwpvziSsdkW0A8fvYWZ8hcckIsXLpPzyaBOXl+eWDG8dmHFjdHWK0NRXj6VPm3ELZE
         OXLhNyIrR9iJ0tJBr478Mi8vlxkQT/cMrs1tB3n63pQ3FjAeSeivfFCUHa9tAfURr1RJ
         Alz2agP3iFI09rNl+cVA5AxDMoKCqiNtNkGV+TWh25ARtRtIg4TjdioACcByYKLzlEwG
         +EaGLaOsoZ4um1T7jmtimq5iazLyDo/0I9+wZ2iFdIhozAx7p+fWUUtnwT9xcN5vW4to
         SEagUQxBJZ4VUoTp/bTElMq2CceYgcpPFF5Gi1ixxS492pPfdUrsW/y8+YhWKVABofWV
         EHMA==
X-Gm-Message-State: AOJu0YxXVfOuTpiBDTtamyalqfWSMZQ+lrU0cN0HYjT5yLpNpyuWMCyF
	aQ3bny57NHZyXFlVYhE3nqce4StxdV8GNkB7mx/3Xu5hCdQpgmNfkSh7flbU5g==
X-Gm-Gg: AfdE7cmOkD0AaDM7i+D7gERSNraq6ORRCJtK6t2CHz9N4uofQylw+yVQ/gBKwz1uQMd
	+H6BEDAlEOACEe++IK/RXTC+bNiEqvdj44sHonjaj7SjWhNoGpUL8Fv9GjL0gwMe/oC9eVFfEV+
	TLqp9QNkDLqTensyuKNMSLXWuLmZF6DT0M7NMBsVDCgz6I0KmHC4facB3fjiNxBD+SzZGmj/L+f
	8YA86F6iFwubhfCLUj5f45QszMowfU7iH41Ch9GuVWiWL9h+8em5gm5OCkC6g3b3NZo7sr3bmBt
	yKR3QD9vhFdpjY0YhwGz8ihRdWm81zMhbQCeqMe2nN9vCcpNfgYJFqgasWlrQoNy0x6CSWrE2ol
	Pin1GQA+hxAz4dreX/+nvE6Dx8atTuyATdKgyiUM8tf9AnP4IYRTKy0HTTXMrRRg2A7cXewVGPU
	+KsbV09pM=
X-Received: by 2002:a17:90b:58e7:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-38e4b3cff53mr2798116a91.6.1784295203450;
        Fri, 17 Jul 2026 06:33:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.93.80])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cd6e6esm5740827c88.13.2026.07.17.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:33:22 -0700 (PDT)
Message-ID: <6a5a2f22.5a0412d2.3daf32.3f18@mx.google.com>
Date: Fri, 17 Jul 2026 06:33:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4169487359283116024=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: ranging: Reactive RAS UUID
In-Reply-To: <20260717124111.3296537-2-naga.akella@oss.qualcomm.com>
References: <20260717124111.3296537-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4169487359283116024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129585

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.48 seconds
BuildEll                      PASS      18.79 seconds
BluezMake                     PASS      586.07 seconds
MakeCheck                     PASS      0.92 seconds
MakeDistcheck                 PASS      145.94 seconds
CheckValgrind                 PASS      138.86 seconds
CheckSmatch                   PASS      249.89 seconds
bluezmakeextell               PASS      90.15 seconds
IncrementalBuild              PASS      675.63 seconds
ScanBuild                     PASS      812.25 seconds



https://github.com/bluez/bluez/pull/2328

---
Regards,
Linux Bluetooth


--===============4169487359283116024==--
