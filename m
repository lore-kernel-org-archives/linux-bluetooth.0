Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0155765
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830285; cv=none; b=mDJoiZGqF9GowSkaV83+LlCSYnnNU+g1TtBXaD8GNFnBbmRhEKIjN4RYRXz9EddTSmfTtoBrncj7QezV/qF+4yxDp0bR9BymllwkkQG8JDv9ia9CL0uzu0GKLhMUnpa0k9ygEm2aNpQz8yyHRDiAn2m+/Om0WCmCX300W/T8obU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830285; c=relaxed/simple;
	bh=f4ZtsJdyZtwVUGtRwvAsSwzLfTnCk9B/N3jsnryBSZE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JKBWsHD7s8UgLZxs69pKiG5h6ngK8PRq7D+XRUYpQAeoiWRPj5WsSyWuDSGceOcvqeLJtIgdB99lrjO7HmpAskIo5wWx4BzKpijPD6RPbuR1hG+o5jNY6R6VMgu3d+6JDzQ5+LbvYQZHHs7btFFkDtJVCribSXerq/ImnKqlKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP+KQBYb; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP+KQBYb"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363cdbd584eso2708265ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707830283; x=1708435083; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4y9yh1zSTYjkbKX5wwRaiV8rWtJNLnVlelU/G5/HcSo=;
        b=SP+KQBYbbpwRvRxxX10Vxo//gTcD4lFfmlUyiXm5/jqwseKMCgcy5sy9MDskJRC5h3
         6UrXgjPMNZ6h60TQWu0r8OnPp5gzgrsBfktjVp0DaogGIskEUQMiDbP/KWipqAOtS1wE
         SKqU2ZCCQOIiQNloCYQnbmYWyfdyAqrOMpn0RwenA++J7A5SwgVR2q6hcbjHMyDEpXIv
         pvh41R5PHQ9iAhXm+jlJYfbcGcyG1EDhUk/EwzeNJYd1rcUpw3YEx2AAk+3U4bgeIh8V
         L9zRCPZxP/ZlMHgH5zBAqPfamgCqE5fjcwHG+TA1qTMkXxI33LgoHFMRMOe6dJduEzG4
         PvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830283; x=1708435083;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4y9yh1zSTYjkbKX5wwRaiV8rWtJNLnVlelU/G5/HcSo=;
        b=EnCHBy5gEBs0ykbG9JvD3UVjB5j8pvWEq8aEzksrCz2f47uFeE5BEgOR/Yx96gRVMA
         Q668GnCbPC13XUxmpsIrdeLHbbYwTLHBUHVoDNbu4dDt/y+UTYL40m/1Y+pSvY7Du1m9
         VKyJixKSwkYtalvp0sGu2qaDZ5b8fmERa9A9VY3R4H2THa4+mfNeSJpjUihcYadB9ozQ
         LyJtv4zz/CWHRE2sBK+Si/wBC1p8XL5LQ1lBBrS5QtiS+CS+vnHLUplyWkf7ovS7f0tq
         2L1Hids5cdKwI+5aEr7+F5xvyIO1B4JhgtoC+1Dhznuh/qBbuUoXSRa/7hdEUs8rvL2p
         B4XA==
X-Gm-Message-State: AOJu0Yyy+dXC4DWDWx/zHUwqyIol86zClOaopcuofelslgqiuG3Aa3fC
	6VXqZzmD+Ns33bAIM7V8qvHTyrEQo6xlwYnIrG8Nu5rgicyyaSY/27aJaLOM
X-Google-Smtp-Source: AGHT+IFLJvlw4qyhbxhF7hB9B+tTAzxreQrxGT4Vw/+0dTgVLkTFwmohu0VmQFqhtv0fnLEzdlr6pA==
X-Received: by 2002:a92:d20f:0:b0:364:216e:d1dc with SMTP id y15-20020a92d20f000000b00364216ed1dcmr709195ily.22.1707830283036;
        Tue, 13 Feb 2024 05:18:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlQmKExH8/Wva8YhaMRPmjP6W+dFztP+nMuYIn2y61RVhn21gM3Bv9Fm/ChdiG21dHbBiDgmj6kALpM3YJiSMg3Aj7t04a76DnSJPIeFI=
Received: from [172.17.0.2] ([13.91.68.149])
        by smtp.gmail.com with ESMTPSA id b19-20020a637153000000b005d8b2f04eb7sm2246593pgn.62.2024.02.13.05.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:18:02 -0800 (PST)
Message-ID: <65cb6c0a.630a0220.5ccb2.6c87@mx.google.com>
Date: Tue, 13 Feb 2024 05:18:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8949154585766160482=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shahid.bashir.vichhi@intel.com
Subject: RE: [BlueZ,v6] monitor/att: Enable the notification logging support for the CCP
In-Reply-To: <20240213045304.1558991-1-shahid.bashir.vichhi@intel.com>
References: <20240213045304.1558991-1-shahid.bashir.vichhi@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8949154585766160482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825587

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.15 seconds
BluezMake                     PASS      757.19 seconds
MakeCheck                     PASS      12.34 seconds
MakeDistcheck                 PASS      168.81 seconds
CheckValgrind                 PASS      231.27 seconds
CheckSmatch                   WARNING   330.83 seconds
bluezmakeextell               PASS      108.54 seconds
IncrementalBuild              PASS      700.02 seconds
ScanBuild                     PASS      954.44 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8949154585766160482==--
