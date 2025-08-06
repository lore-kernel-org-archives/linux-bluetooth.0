Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341964431
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754454736; cv=none; b=XVhtdLIzIyfXDtydI8oaP8RmYNJxYRNo1/FaZw4P17os2DlI4t3++UpTfChn9yqXdrnesTbOW9tokgnvMe4pES6GI2stKK46qKlEid6BR1Jddq8M8DiXBzSWZJjHCioDzgma79qcqimIMy5XT8xdL7ThMb34LVNrjWxYlOxpBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754454736; c=relaxed/simple;
	bh=OIugjrTkKFl7d2KOlbbs7kie172UyxR2/uUUHRfpWic=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HtJWfl4LwLzMiGukg9N7tnKKp7iBzPPwpOIm3oApKDgZ3o0Ed7zz7lbeLtgqrYFaDAZ2Ac9OPEuaxBdPiOgkVr+mimSeG0C/yl2Zi14GrBi1PjXlnmbVstQl7Yc+CUOM7Rk1+6kZCF0EqYkHwejyf5GsjATyDJTE1Bhg6Ar9v2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev3Hdy4A; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev3Hdy4A"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4af123c6fc4so39385101cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Aug 2025 21:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754454733; x=1755059533; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5YWWw+mxGQnHo3Xl81zUYObv84jnNTLbR7eMkrOVJ4s=;
        b=ev3Hdy4A+xgdqUHiy/m77XfknTOLcLVRfGlPABVsM319y7WfK1hTmGrDMWKupOstzM
         dmzReMcJUZC6idFTDPpBfs9RnKcIfbeNzckS/f01QV2a78fhUQpCLvTl9t6DJXyqYlLM
         jOCkemk8lgknJeUJdyaMLKiVMzFZmcb4m/U65F9FKYNC69MstWO6HjaYCaMknxdKPjNE
         zy9SL24s02+nkFhTEOQTMmxZJH6qfmiF4Uyqk6jjPHQman+ywWoPwe4DU3nOWkq1C8jT
         nfBIBaaYIYceYXzW6PdZXmf0+WFZWVcqLqdhmJYY/nkOKzsEqmEvtr9C5ATdo2mR5/FL
         24vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754454733; x=1755059533;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YWWw+mxGQnHo3Xl81zUYObv84jnNTLbR7eMkrOVJ4s=;
        b=DyQ3Mm0cSTi/gP+wo+6AfwFVcaSx05JShwPnpmgz2+aCuWPVG4sxMa4GRE62v8WCVD
         UwAUYcPdSaLtvqyGzMl3nZc0LWRGdP56QkOQfoobUworYKje2mCH5x5g8Uf5de/UnWCJ
         8XaoXG9zPG7i5T0qv8kNQvNt6jV0m9Nyz4NgZwPsETd9ynng0VHztjVhzMdCcgVT56s3
         PIqcv9I/mKkxnCJzHvbxT6rEdHG61Pq58uE/cDKcgOg8zbEPc3Rm2D2Frn8NySLFzEDw
         dpGdxLQu0zhxjhQwTLOQnvuMJUIN9KzAuvZi+M+7VNWUDc0zRcsX6thS1F5sSbX4p0NQ
         RqAw==
X-Gm-Message-State: AOJu0YyPYMZ7GryZucNG82Xw1CzbaskVYE7v/vlHLFfqHG0fOT/expfK
	lDkeJtTMfHGESYS1rXMmZRm99qiAxkrvVSiVLI8+nO43N4HpO6fOOJnkg+r/Gg==
X-Gm-Gg: ASbGncufklT0MMOOyoWFjk3JokH54O+8vgnYcO9gLUZp5ubo6FLE0Soxlp0+CQ9Vf+W
	kXFpWVfglOX/zTgMUgAin50HQJsHngXerr/2pMtW/f51GwvKiUzDc5ioOzmwKAzOIMttnLySvco
	gwpc3GGj/Q1Rgm2pV8iv63eap1L09O6GDkqdXTEWqnUMJ3dzYDeym28vUhqWisG5uIJ+QYu7T6e
	zsZiHOOrOKintJFI2zfxSWS7+8I1DfeJv/sU2vKcgy6IUgwe7e4Jop3O9atpJIrn+XksGs00b+4
	9lnZgIYCrx4WS9xbanDBkUSZGdU+qU5qVqr5yCidKzfXXDj5n7xg0zjh/H/Iqb+9jag8N8eo6RA
	0rnRdS8BoEG7nTxNbi+tPO10TlKSV
X-Google-Smtp-Source: AGHT+IFWd44hJFJkTMrnKRnFXv2kpXVLYrmsfrD/0R1pnTJNosdfJB93Da470wmz7z59JxbDFW6bng==
X-Received: by 2002:ac8:5701:0:b0:4b0:6d53:a0fc with SMTP id d75a77b69052e-4b0912cb80amr26589631cf.7.1754454732817;
        Tue, 05 Aug 2025 21:32:12 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.244.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aef8026342sm69110401cf.58.2025.08.05.21.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 21:32:12 -0700 (PDT)
Message-ID: <6892dacc.050a0220.376330.d9e4@mx.google.com>
Date: Tue, 05 Aug 2025 21:32:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6175063459554950998=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, myrrhperiwinkle@qtmlabs.xyz
Subject: RE: audio: Don't initialize media transport volume from media player
In-Reply-To: <20250806-audio-no-reuse-media-player-volume-v4-1-a59d9a4848c1@qtmlabs.xyz>
References: <20250806-audio-no-reuse-media-player-volume-v4-1-a59d9a4848c1@qtmlabs.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6175063459554950998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=988599

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      2721.55 seconds
MakeCheck                     PASS      19.95 seconds
MakeDistcheck                 PASS      184.17 seconds
CheckValgrind                 PASS      233.69 seconds
CheckSmatch                   PASS      306.56 seconds
bluezmakeextell               PASS      127.79 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      919.18 seconds

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



---
Regards,
Linux Bluetooth


--===============6175063459554950998==--
