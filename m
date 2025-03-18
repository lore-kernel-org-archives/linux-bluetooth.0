Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE521146F
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328486; cv=none; b=SC1cRCSAsyvHV3RoV91q0mCtT39p+u8frohHmKQKFinsK4N+wnONGZbBRLG5iS4XX0ofTrJH+Z15jjvl9CstGlDtuX29m8vkqFYOTL+MlUvvN8VpYgCsRmMQcN1OtVMgQkFxzIu9RqY7hWHs2DeQ67+U33D3oOA+e2yBS8yvhu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328486; c=relaxed/simple;
	bh=/pq9rJ9YCPXvnffw24QfV3LP45RkLXQ5BBj+TlsOi8k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sTI8M0E1BVLk7iOqbg9rtDDT+M6/ovPlDctHjvHSMlc1cCFijJSwehVlY30/w6xbPmJyHYrTs2ARqhQybmhZkvroVhTatkqxSSF9AkH+398KKoSInjF3dQPaKuaL1co1K0ge2YPlPpEZmu8QWvZki7u3HuypaV9dCa8eJzN1+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okie74eH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okie74eH"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c58974ed57so312775885a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328483; x=1742933283; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uRk3zK2wYw1yjM9LkGUcEu4CTz/DjJsffADFtpkrOd4=;
        b=Okie74eHuQLDaSClcEmFY4S0AMtXnUHQxjwhtv8b7+F3AWQIsOz6FAxSYmb4cCQUkC
         nlfaZYGkbZy8N2z4U4bNyHunrfEb/8MVH0TvBEpGYEVAUWYwj0yaa8hk0I8TaP4Y8gam
         BA9UVyjyYWXCP3LD1CmgWh4gUk3cw4VN3M+fUEngGseRntNUwz/8Es2nc7ELkCxes1v8
         nLBYOmdI20BgYAnFBOWMtnQomrsWPOOYUP77xYxRqBPdPBzsXQm40B73295FmSbEES0H
         SYkad2abMV+KSgTH0R513Bu4MlRI7aZBaLq/s08VaaEv0Ddi0Rl8d3pNQF/eywPQp1ym
         m9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328483; x=1742933283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRk3zK2wYw1yjM9LkGUcEu4CTz/DjJsffADFtpkrOd4=;
        b=wo/0X+3G1uxud0VwQSIUlKtWEQLlW07iIxEW7INhKDF7kzXef8a1E429wNJNpKfHC5
         i74N6DbdqoQOZKoT5SPbyf5RJK2FLwggbFLVLfmdtjwlMuw0iLuXl9nc+YY3fzrC8pZE
         Zrcmp6nF5AUUm4c1dpV+6Zm34DWuPMZ1o+GyzbqGNLF2EyLU+ap7cNXPSwqVcbaEHbYC
         PBMekK+dWFHNrJaOYNn+uPtsCrNLofRFlTu9T1123E68LdZ1C1WrJlePFb9hwZdblTXA
         SqVfHKcb5vupRunNRFa5cZEE5chrxfugC7Y5Z/7WWewKIYTVnjq/DH6XvbrJrdbhqGWv
         H6HA==
X-Gm-Message-State: AOJu0YyHg6wqXLLi4iHLtsZ0PweN+UFioidU0mVIfI+PIceWRiGIFYfv
	tOeV/mVhHl75WI5DStQgk21wOkNFZ9DAX014Cic/JJlUshp2j7LvUEBmqQ==
X-Gm-Gg: ASbGncsr251gUnfVlJeYePX4p8dxpJU5O9kX5y81i+lJ1AtvLEE7VN+07gRwZb4258z
	ukRdfq9/sfsYZZdu3yJuN7m6rq52eisibbE4Kbe+xR4xlHTaeqg6lTg7NG+QZ0rZNh7e+pGFpgq
	m5xGROv3hXGExQqj70RVsOiHQV0zq8XDjc6YKf6m5L691C//F1XVvsHyJfLSnmvn7hDUHLAYElU
	h0GwZQQskQR/MkgQ4YHXWG00U5gSt1pxPSoGMJYu3p4Oto8312WVNtKcD8DD2MG/RyLRn53yiGZ
	pWK8ZdXvLKmf3c7LVcvFYLPYQIqwO0TMbE1CfN9j5aYLsSbp
X-Google-Smtp-Source: AGHT+IGq8VZG1w2KImjGAF81ry+699eGB9InQ5j4sVZWhAQaWD5TjMbTCQwBlJYJpEdtvDE5zxRusA==
X-Received: by 2002:a05:620a:2992:b0:7c5:5d9b:b617 with SMTP id af79cd13be357-7c57c7d6d60mr2676664885a.23.1742328483543;
        Tue, 18 Mar 2025 13:08:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.17.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9e0c7sm759461785a.58.2025.03.18.13.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:08:03 -0700 (PDT)
Message-ID: <67d9d2a3.050a0220.7bec4.c50a@mx.google.com>
Date: Tue, 18 Mar 2025 13:08:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2466710665707907657=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/3] tools/tester: test COMPLETION timestamps
In-Reply-To: <3d378acca803b578522100e8f9fd3d6adb1deb25.1742324646.git.pav@iki.fi>
References: <3d378acca803b578522100e8f9fd3d6adb1deb25.1742324646.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2466710665707907657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945297

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      1524.88 seconds
MakeCheck                     PASS      13.55 seconds
MakeDistcheck                 PASS      158.10 seconds
CheckValgrind                 PASS      213.59 seconds
CheckSmatch                   WARNING   287.66 seconds
bluezmakeextell               PASS      97.90 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      862.45 seconds

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
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structurestools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structurestools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2466710665707907657==--
