Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46B19D090
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782281; cv=none; b=OYZujwc4NFOu5dTYrkHbNB+AJZ9ed5lNWeHCsf7ubitjovWpb9rPSiQvPOR3OLSmdIuQuILu/W4yTQJjUaA7O8srCnLU4wN71cY1LMebjD9ioFntQdgUcza90VaqnnG5Foq+iGAvzcO3cFfThnKlT3rJRATUBtljOTIfgxD7228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782281; c=relaxed/simple;
	bh=TYM/7oHHaTLkAtfQ0ZrAfLHlph/kxqjQkbtxYSW9s+E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SZfxGQ8Ar9JjBVxVqlM+kQSmG5xh66CL5V0s2OIucs2XKzom2bSsomQ2kpuSTbKwo+55vJtcFbyN8Dlmjddzp2RGkchRdRSa+udbQtD2PetpOILFFA0b16i1H3eAXbEsO0X2IXSBPadEhpKG8MusovzF57IiYzmOUDSYKvkEuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS550fiW; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS550fiW"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso20294066d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 14:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733782279; x=1734387079; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Id5kMbVYTCjW8nILEhkbgwYQE7rNG61iZgIgZrQBvU4=;
        b=cS550fiWUYCL5uS/05sV05RcIadWOYVACxubNPkIZwdfipTru1zYqfPKdN8klZvymO
         dS0+uPq/Hqu9cESu7+5vTToglNiOI+XWes2sIN4l5kZGha1ZuEDal5vVAHMYCDuiwuWC
         h8a7cdRJwQjdW7JVX56HfOvTeUrW3L9Hb4JS5gGwZXWiAaUT6vvltjmiWWukptVr9V7j
         FIPb4SyzoychWrRVFj6rW1JWwosgL6ujiW5FmZfsF1SLhjfpyqkIaMZmJbQPYUrx6sWG
         NMSBTrwGdAs2tHNbLP9kezgrFw2WV28H8B5ypw44leDhVml1tfsxl1IIT6SZ+yX5+bS/
         Ocmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733782279; x=1734387079;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Id5kMbVYTCjW8nILEhkbgwYQE7rNG61iZgIgZrQBvU4=;
        b=mJnjhjwrSou70JY+fTookV90uVttrWAMxNQAdVRDsffwmqNjgljHVuati5nzFp3++4
         w0oLWdO0eaJ+zYVP1xXaJfKIzJeSFhes3FyKz1oxSPY/uOVoP/BCYS0eNIu2yByWpInE
         9JRgB+OtxG4VI2Fo7GHYEk3smxxqC9rqdr5rxrwsyb3Fycf9YWWVDNbh4wpWg039Y7RH
         Jv5yfNBdlgqPjp91jzkkQnZZ08TBoB/2sKxDvAwvPGnhfkXbAlOXP85NElVNfsqVVws0
         RYQwB7t3s/4FnSb1KqrDUmfRBeB07wT9G0AE6T+ZpHPPN4lIXcIeuTfQ4e8yZuGP2Lzv
         nIRg==
X-Gm-Message-State: AOJu0YwckBHHyL47VzUoexnbW2Cn7NmNHmaMGqo3CTmoRTVbpDFqtZiM
	gPrvpKFzE6y9gRoOGOuphOEHJpNWw7P39OdLp/SxkgOJ/ZptarIhjdTTxQ==
X-Gm-Gg: ASbGnctmDGsSY69o/FFreBBXtD25bJZZctOT5W9yXr+SyhBZFFNOkj8lEX7H+C4dFSA
	2bzgebRMiiCYR3c05yEDzuRHba6l566eEi7BXOVKk8gsmfuRsOzlL+At4wXnkIuwkuuAjFqN79D
	SQTqQJ/2QBba+Zqy7VW7DOyjE3vfEPR6j7KbA6PzDy9pIExY9TWnbVetJvMGFAY5SGRUEFRQfAS
	aKT3e9ynClNONawJ/YR6/bK75B6SWlKR0dP1Q2fvKF99rKphkpCMaZkg6gtq6s=
X-Google-Smtp-Source: AGHT+IFG/lUiEN9eFKMsRh5uNTHyqFVCWVlJtxdf98uIYa4+26/qd6PnX944nxKpwdNEvp58/R06zQ==
X-Received: by 2002:a05:6214:d06:b0:6d8:7d6b:cb78 with SMTP id 6a1803df08f44-6d91e44684emr37133516d6.47.1733782278892;
        Mon, 09 Dec 2024 14:11:18 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8e69b7143sm44638306d6.61.2024.12.09.14.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 14:11:18 -0800 (PST)
Message-ID: <67576b06.050a0220.1b3e5c.ed92@mx.google.com>
Date: Mon, 09 Dec 2024 14:11:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6438826930925188276=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] shared/gatt-db: Fix possible crash on gatt_db_clone
In-Reply-To: <20241209205843.1394081-1-luiz.dentz@gmail.com>
References: <20241209205843.1394081-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6438826930925188276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=916123

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.58 seconds
BluezMake                     PASS      1622.58 seconds
MakeCheck                     PASS      13.49 seconds
MakeDistcheck                 PASS      158.61 seconds
CheckValgrind                 PASS      213.09 seconds
CheckSmatch                   WARNING   271.64 seconds
bluezmakeextell               PASS      98.67 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      841.73 seconds

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
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6438826930925188276==--
