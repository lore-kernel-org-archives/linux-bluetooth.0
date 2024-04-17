Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D69812
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713315733; cv=none; b=SAC1ij30wCVwaO6/V1LUzF4BXVEPjRHh1fPp+nY4DlV3zIPNNcGpa6V1T13CmqoLSYyd/ohe+nO4hdr9pj8P+0ay3cwz334jp2+fE9R0DmOCBQmM3ABrRCUOEDbSJj/Ey49AdKXstg0rpRvPLsAtwO39BkX6NCLdti0a2j01rCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713315733; c=relaxed/simple;
	bh=hsrJp75rqMwfxfSNB9+ZaeFe5u8m7CzACplgY0AYMes=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=onkdHeJRPR8lEKXQKYgMtkwtpwEjXKwjos4G5GpGh1I7q+tbqQo+jXkK57caJQsJo8OJZbr5ghGK5r8wQ/qJWEO0x/m4Dk6xi2XTW6D0J3AANpMyNMle2nCyBDRW8Z9WpVVLGY3l3WaY8cjiuENLYz4xD4UP3qF0FOfdIt6GHTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ4gqw+l; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ4gqw+l"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa2551d33dso3215762eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713315731; x=1713920531; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P/Gqz5bfH0pH5zXq104dS21tjF3iv2kMG85BQkZcLDo=;
        b=NZ4gqw+lY0YoPt/vD1jW0ugw8rtj5Ffm0j2on2tJfYdyYMHmenCWsbo7d65wgdLaQX
         lBE+1Mxm9PH8puk7Tj16bPPDMTlpuePgNrWomphN2pEFEkOv7VyU/p4rwjA2Wa48ELJB
         7O5Dt9F8TIldhtHufWvcCgreJvrtSppvfVuo0XboHr0dJZ2sd+5b3z2QstjK5Wb49WMj
         VOuZQhqeSAheE9G6Mko+exrvH0liaq1hcfAKmb4U3/50i1tdjNBefxYFrDEjoVN4zMaZ
         +28LD6sr5Q/dhvxT5vg9EIkIUkAd/ptIss0/lpVvmq50kz46pwb25Cv8Zo5lSXxUyF9G
         eTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713315731; x=1713920531;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/Gqz5bfH0pH5zXq104dS21tjF3iv2kMG85BQkZcLDo=;
        b=dAKHNHBOUOtyMkiuOGno67krwco7TPJE403vMd499eci4AJhbIF/XQplwk5jNtBQgx
         8Xcb92Xrn12t523dTKeCAg8dZevIuj58oWWy/c3/f2hP59JK38ffm+YJU8LGX0yTWDDS
         /ktTfhcFfYq0sxUAJ309W2hQ6XtOomC1JBNTlk1U3HkXGQwQrfciNXs4abN1DE+R4ryL
         nqyYGRV0/XecEYbcjVojxRwZGQd6cvHiCYzx1ztjZ7hyVSuk/Dy18Jb6WUFgtjf9VqQo
         CttmgTMwfV4jCsiqjzuM+7xMxwm6Egw57SVeHsMYH/r8jBbpqwDwwGPj5l5Ls9/Dylze
         aTHw==
X-Gm-Message-State: AOJu0YyCMz++Uvi+mNCa9w7vsvBVhQ0XxbCsCyRfZjN3mBuE2U54ppBt
	yXPJvOuljaSPQmPifUqqJMBWLwVLUzR4tbxEuREowBg9U4x2nrl+kdQj8g==
X-Google-Smtp-Source: AGHT+IH7YpUL3SzXRIfDSTsRMxNxo6iB+tRX43oJSJHqMYbVwH14jo8AV09UUnXY2FMUIZsOt3XhJw==
X-Received: by 2002:a05:6358:2884:b0:17c:308e:2154 with SMTP id n4-20020a056358288400b0017c308e2154mr10305412rwb.18.1713315731364;
        Tue, 16 Apr 2024 18:02:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.50.146])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a000d00b0078d54a6bb76sm7962049qki.117.2024.04.16.18.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 18:02:11 -0700 (PDT)
Message-ID: <661f1f93.050a0220.54454.6773@mx.google.com>
Date: Tue, 16 Apr 2024 18:02:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3332362318863743856=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@prestonhunt.com
Subject: RE: Fix spelling in monitor
In-Reply-To: <20240416231205.2116175-2-me@prestonhunt.com>
References: <20240416231205.2116175-2-me@prestonhunt.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3332362318863743856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845239

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      24.75 seconds
BluezMake                     PASS      1709.71 seconds
MakeCheck                     PASS      13.37 seconds
MakeDistcheck                 PASS      176.67 seconds
CheckValgrind                 PASS      246.91 seconds
CheckSmatch                   WARNING   349.49 seconds
bluezmakeextell               PASS      118.76 seconds
IncrementalBuild              PASS      1478.40 seconds
ScanBuild                     PASS      987.57 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1867:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3332362318863743856==--
