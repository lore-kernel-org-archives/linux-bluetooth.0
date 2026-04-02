Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0338F65B
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121909; cv=none; b=o6OAe6dQjUuuPAAXzjjriwFisCH3NpUBCS/h+yZ6adNc6+uEcZUDg/GpdUYBk0zgkY7Yy8M2q4w20JzSxf2UpYvzoWk5h1VaFzXq0SO6u8zaoL2m49Le2LzITkN/d5Q7Ls2sdqPsGfdaDczCSLBMmibMDtiFKQanCxDFC20yAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121909; c=relaxed/simple;
	bh=uESAGcWsdkO8jY4h4jFHHNq8HniR0QIQLnJLYe5iaos=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YxRjxn+qXHr+EXYEgW5ybPSvOzLm6dz56M95C42T0jq/TE71BgOGLoRKvzciLW5fTUkZLSQCuKKqgEgMrZkzps9I5KbncjgOAAZ0+r4fCivSsKzmwPr/8TfzWWUED2+e8vnX5bP71wXCdkYOqakHeRkcC1NiWT9HDgF5H5jVT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD3lz0Dr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD3lz0Dr"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50b392f1846so2200681cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775121901; x=1775726701; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8zKBy+4zv1UxYisEdz7yZk5/vCHe7ps+iNY80SpfME=;
        b=WD3lz0DrYJQx/Geeu/S5WNJr8dnflwsB0pO2mvXOcl2x1A2tx101DocfSgqdrp9a3d
         tC62BGh+m6BmRwSY0LryeKRtV3GDv5s3A7R3aD2a7O8mEyJ0+5gj7yIS0r6cAo9/5Kv0
         YrHW9Gg78AEDFGuP0U3BCTNYJiq+eXgN5IfhRrpvnF78Uha7bUAyh53KBKwd9SdXUei6
         +IAUtrwgtsDsdgBx+uGwraV8UZ1l8YuvowGQutob2NMlUtPfuP+3rFmdyB+x19oq23MS
         fEZeaQyj4AzKrPjBUv0lyHVE2vJ4EWT6Ld9U1fQlVHOkX2/n9+urnFyLaieTk1UU1sAg
         YwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121901; x=1775726701;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8zKBy+4zv1UxYisEdz7yZk5/vCHe7ps+iNY80SpfME=;
        b=cRZUJnQkEjQUP9eG3X0NkrYOUfSbITXnMuPbwlyouh6uTXi+qd+ZuP2H9PbsImsPby
         lGE5KTj6xQXy6td2l8ojdpWYpomiq4D6+wl/10blIO7KXavLPSutqqDqg3bm5jd1E5Ml
         O0vuFw3b0zu4EhO/SsxNpoIvHSvealA9W356lH3Nm6V8bxn5l5+ttAvUWj0H/A2lHxRP
         5AQtOr7BBKVmfOmkuxyNHH7Z0/yATAi3h9OthQsRqLRSKCfbK71eKyXIEZhuVHU2kSUV
         Ozt4oV6EjrnhcIUIjsMIxz4ID0Ko6+uJ0xAy5/oZo33Gqh5pGupd39B7naIY66tqJMp+
         B87A==
X-Gm-Message-State: AOJu0YyYBUPoVrJ3nzT1ZGiuhSFyoK9AQ2+kIhjK00z4LD0o9mSuxHLO
	iwBucEqn12Iird2AE+bosAu5RX0PjLo8piQlqyO3W7iyW2oyDBV9+x+e4xU8Zg==
X-Gm-Gg: ATEYQzyHum5OuE97r/vSfWK6k5SwGR6a2FA5i/HmtdCx8VTOwS9T0Jcu/W4Td51QDT9
	elJAnibatQk6/ZJzQ5uRWwC+ar+z5JEg+HF+2OJ+Fa2uFhJm48zPRtkZfx/tvV3Sv1I+9frU6XD
	+ouHz90BxePrxUR47SwjaZeaiwk3proDpv05RCFWrjw5Mio5/gN1czXyaRpb/2jn3LfWfMez6gQ
	zt30IVDRnTIZPx90tTwur2+sIUJAFsti44ZY8WDgQS4F7ELFwzIo2ueBQzyoXvG+swZK8axcyZj
	eyuWpPijHvVB+3o/xYz5GtzwV2FOqKxDV7+cvxatiQIjRR6M9jSjz19ibjnOuyQ/5iAgQe+XXFU
	ijGPK5XIte6ZdFbTNY5xB/yV2mx45PaN1I8LxUqz226dsXDAMQNWYxmqwmMZgL5JRPMH6gsMI61
	FkdVsOUdrbjHqk9AkduqTnvPwcUq3EQA==
X-Received: by 2002:ac8:5706:0:b0:509:68c:634d with SMTP id d75a77b69052e-50d3bb99067mr86731671cf.10.1775121901454;
        Thu, 02 Apr 2026 02:25:01 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.151.121])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b73ea66sm21923211cf.14.2026.04.02.02.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:25:01 -0700 (PDT)
Message-ID: <69ce35ed.c80a0220.276524.d031@mx.google.com>
Date: Thu, 02 Apr 2026 02:25:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4442326694519198845=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: [BlueZ,v1,1/1] avdtp: ignore Discover cmd when host sends before
In-Reply-To: <20260402075610.1724091-1-zhangchen200426@163.com>
References: <20260402075610.1724091-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4442326694519198845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076276

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      637.29 seconds
MakeCheck                     PASS      18.22 seconds
MakeDistcheck                 PASS      250.00 seconds
CheckValgrind                 PASS      296.97 seconds
CheckSmatch                   PASS      353.67 seconds
bluezmakeextell               PASS      182.43 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1039.20 seconds

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



https://github.com/bluez/bluez/pull/2004/checks

---
Regards,
Linux Bluetooth


--===============4442326694519198845==--
