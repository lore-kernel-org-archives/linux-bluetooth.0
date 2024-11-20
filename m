Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0116DC36
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102674; cv=none; b=iPMlKj2/0jxoljP4Kpr9v8mfOYCogRsmy2aPQglrqtoqJjioDRwk4GIE2htB0/4evtMMhnTCE8gwBLVchFQHlX0mOn2qpAMk5vQwLvFSc1sOIbkIUyLAT3GwZTW3UCw2XGOCdjHOutkytEwh1aQdt9H2uSUSKYA5A1G5aMrBNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102674; c=relaxed/simple;
	bh=cqIt66EpgONn8Ox3k6ACVSJWiX0R70axVxNszF+5+vU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QsmrKpaViWx+U4/YW6T0MHrTeiIYi0xDz49wQtYuNjNeHd5oRwwGbOohavzbzPLAiHzVIgpVwpjooI241jpC9dfm2tSrFj52k42Bqw5Fhqw2XThU/gNon7Ip9L9N1UjEkk0eWyCl6YTnTiqvqiWWw897VBTlXHAYChp4bSmihGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWzi9Jsa; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWzi9Jsa"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b152a23e9aso110847685a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 03:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732102671; x=1732707471; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GOu9d5MVCj+Yw3+jP6Qntd2AMrB0BpH6yxLNdK/mdDk=;
        b=cWzi9JsaJfLy8gPzNUHmpXFVHTyKEd5c7z48leBbllZcaCJa8F7QHMjkt7Bqojmjlk
         6IZUM7yx8NFbkFuPn51dIUzDGtBHFF8Ixb/Gzn7S0gu4Fm3YVksZp7AF4QWAchF0XPql
         qRzQt3UPunRr2/Y0JUIz8JEPF8zYXRAWRQMQUirnyhaPcEwOVj9iwb8uBxd+zcLuXkXj
         mz8GlRuumb8olX7Yxc5Ccz99tCDVslcE+ur8TgWleeepUE4sQ7nb4RVyeYd2PeDit9aF
         DcDHDVqcgR07RaP9FuzYHxsxrRviVjeEPKm33hvcbLnWd6ezVLKGuoU2fGC+qiRITAd2
         9UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732102671; x=1732707471;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOu9d5MVCj+Yw3+jP6Qntd2AMrB0BpH6yxLNdK/mdDk=;
        b=UigG3i7NUdIWhhBoU7V1KOuaL8KGtYo2forzI+D06hyuyLYM793Mp6vVJ/tLQvhs8n
         Gp6v3FbJC04f0UlsPB/EqrtVYxJW+aAsrPTWlLuku7A0nH6Io89axSBGyL2PhcaoZrE+
         CPI+PE4GNLPfDHOkwC8b1Sz332Ip25Am5xU22aLyDG+mCRrZcXvNJqJ66Yw97dxMGmLY
         JrvJpdSvsaHrtj2SHkZLwOw/UCCMEOYKxY4GKdw8JsoXG9P9HhwQu346OAuCTvlU8GCa
         KeFunJPLAEgQD2qs8+RuagKW7CmwUub9hWbZktb3YP0BhZdAQGlnjZx6UGpcZUd9hvzh
         YlIA==
X-Gm-Message-State: AOJu0YziPWv25a89MbsYVwkWT9kn60k2lduFotSDQnhl+tXd/o1WlDqw
	TzXwROaiKPsOaFTxcZOwTLOC+0yG8k5omhqqRzIsD0Gx8iEYdohAKQi/aQ==
X-Gm-Gg: ASbGncsLHI/FjpWD0vfuTpCi21jok6pGqmJmyS4fLUTmsbtZvLoXzczObRPzQeNxVg9
	wZ71c+pWnkZctD0U0ygybpocgtSVEr32djHesVogOoh2f86zBf8ZVy14go+g2IhIR3Azd7RlJ6w
	X35/0GCkASSfeZmoys4mTRDc4m3MWUnEDep+m/CzBrt2gE74ODbRs2750HncfqIaUtzvvhSiEdP
	kQ4jHcL7aKsYg0XgbmZ5b6wqG8cc6K+oF28yPWiq5B79x5T8GZT5urn
X-Google-Smtp-Source: AGHT+IFb0o7MYLdusISc1vCA3UpWEYjwvDqH+1e0ZDlz6YI0Y2Bys7kfRA/GzU2kk8oXrXrkEEuTQA==
X-Received: by 2002:a05:620a:1917:b0:7b1:1b47:213c with SMTP id af79cd13be357-7b42edb96c3mr372376085a.10.1732102671633;
        Wed, 20 Nov 2024 03:37:51 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.134])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b479d5f418sm84248285a.34.2024.11.20.03.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:37:51 -0800 (PST)
Message-ID: <673dca0f.050a0220.1c5d4e.1b83@mx.google.com>
Date: Wed, 20 Nov 2024 03:37:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6749216822110130677=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Rework Scan Delegator
In-Reply-To: <20241120102601.38415-2-iulia.tanasescu@nxp.com>
References: <20241120102601.38415-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6749216822110130677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911224

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      1548.85 seconds
MakeCheck                     PASS      13.40 seconds
MakeDistcheck                 PASS      158.35 seconds
CheckValgrind                 PASS      214.68 seconds
CheckSmatch                   WARNING   274.03 seconds
bluezmakeextell               PASS      101.23 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      858.25 seconds

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
src/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6749216822110130677==--
