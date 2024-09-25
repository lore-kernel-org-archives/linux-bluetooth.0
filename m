Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0861304AB
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260624; cv=none; b=eF0crzEiROfZu1VYrxLCxtvyzuhepjjSagOXYkmEIgDXegJYS2O3tDld+B5VFrz1IUnvE0QCCc/a+3I8Eeq3hltqAMm9P1dk7nXmwVh1yOViBB5n6RnMLL5K1ebeGik161xXmA3bGpF7/YmSdrIBUa9kwn1KY9OLP8ztVoZiMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260624; c=relaxed/simple;
	bh=PABbjQJD4JIvJzpiAbgD3eUZ1GJlYKgmCErTzF69p88=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OkpyUK9Fh91zbRYD8sb+oenIPl8WVeE3V3mjI1X5/6Z+fsJ3O+aUUxVJh82l/722/bQN7NYGugUMy9+6sGt7t0YBGZSPziPnadM6IRQHJ9WuYjzteF+wTImJs7oihZ6qXUgQG3ZZcvDuzAxbIKh1HVPXHOocIRe2GMXLkndu2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3iTjWEu; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3iTjWEu"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c3603292abso60131666d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727260622; x=1727865422; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUBQHAwxGBNtcaNHgzJsPXfJ94Pc0bf3dV/k9qj6WoA=;
        b=V3iTjWEuX6hdbYI92GJ7X/x2K6qL5RzWVTt1oB1n78ouyZJJ8S3zrzSPLhY+FzHS5F
         CUUVfq04DjUfupgmq1gYCfvIUuojO3h4GjHkrF3xrX7XEn3EIlQ3XWNMzaSGurYWiwry
         Mbi9kBVYkFWZqdVISDgqjkTlMwNU7HhN6d5K5UdoTO5gpDZVwM9r+VyKoN3ddStBIcWg
         csPamSNlnha4czO1aVV+Q7bwyUhf2l28OfNAROoRDegjY6MN+NwCLpmgbPAnQnK4McvY
         DVKJowtH4724EnPhdzOtCS8VG8Ja4GsMN67B3IdStDpBMuIqkcorYAXo4Qdt3L3zPoLB
         Shdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727260622; x=1727865422;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUBQHAwxGBNtcaNHgzJsPXfJ94Pc0bf3dV/k9qj6WoA=;
        b=MCVpkLlIVZLj0vw4PZAp9/CAuEnmOak6lExJyy37cAL5lOJ8jjFwOj45TqwtYnhSOE
         MgKJrM+LPJQ90t5XBZ3kVo7wXJrcwTGsd+KW4e5GHCWz4AqaFJxveYI6b1Xacp3KYwpC
         WHj2vR0Pel3qRdeTic4B1CcAz95Cb6DdOaDROrRZg6HwzDDwHpzPtnESONL/38TQwrSr
         YS5UlIW9NMonVPAdv/oHDxVzpF+joYOhZOe24GVxAGN0lIxFH7nk1L7j/iMZrLF5nPQA
         CHUIy4N4TH1oPWdxaCsEAInOorcrMhnY/Y+3KRnwHiD5mSX+XkWb/wxXUSii6NhBCi4G
         PRPw==
X-Gm-Message-State: AOJu0YwmwDmSZADcMJCGMBYivAoDmsmgPlRiTvjizmJ6LrIjn3NFmZ2P
	JHYoXGSBJ+YilT6LnwvmuLe7qJTvTSk7wm4jHiS9x0EqQsaSZ8T/NxvtBQ==
X-Google-Smtp-Source: AGHT+IF2wn6RBsgU9IBYK4LEyTbRVB31z/879ihPQduqMETW+J00otlL+9ZZOM6lsAeBawclo0mYvw==
X-Received: by 2002:a05:6214:5a13:b0:6c5:1652:b954 with SMTP id 6a1803df08f44-6cb1de31fd3mr30424166d6.44.1727260622090;
        Wed, 25 Sep 2024 03:37:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a3d52sm15181896d6.12.2024.09.25.03.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:37:01 -0700 (PDT)
Message-ID: <66f3e7cd.050a0220.396561.6a3e@mx.google.com>
Date: Wed, 25 Sep 2024 03:37:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0779671648415181477=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v3] device: Remove device after all bearers are disconnected
In-Reply-To: <20240925090948.1540589-1-quic_chejiang@quicinc.com>
References: <20240925090948.1540589-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0779671648415181477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=892722

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      23.28 seconds
BluezMake                     PASS      1492.01 seconds
MakeCheck                     PASS      13.04 seconds
MakeDistcheck                 PASS      168.67 seconds
CheckValgrind                 PASS      239.28 seconds
CheckSmatch                   PASS      337.27 seconds
bluezmakeextell               PASS      112.97 seconds
IncrementalBuild              PASS      1361.05 seconds
ScanBuild                     PASS      960.64 seconds



---
Regards,
Linux Bluetooth


--===============0779671648415181477==--
