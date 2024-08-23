Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B818C929
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432847; cv=none; b=mBrUuvc5Fj8QHXC9YRk+q0ICzczQQV/CJewp+p9H1ByjhIsXgRVBx3/lAx6lD4f2yOZsUPMQiOGTgC1B2SDqi3GFxIj+Mqg4x4NYQhxwvaa60vyW5InZNyMTtNkpkcFwHTuAl53rKSgdY3bPmewAyiM6nNNkvRoMnmL9lfuXtWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432847; c=relaxed/simple;
	bh=Y0SQVG1yb4PIziQH5JxdnfAAUzPKsp/8CaT/Ve/W1zc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AIgNKkTEd3b+AjhUVol/PDN1fLyv0ndkrDcW03X8QsnHL/vqqp51YOQepAZYNyIssUQwqOUOu8tA892zROmgrB1ULZPSkxVxXE5GgXweNX2D9zL4/WMQzUeH3/wTv6iGPbvDAXynh3l8XrTJ6/OiKii27ZQD8Q3/y93Q1qlmUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDMydx92; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDMydx92"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a20b8fa6dcso139244985a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724432845; x=1725037645; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xl3N6sY3QQXEL+4PK6BSWnvnm4ayfM42j3kBhFCQWvM=;
        b=lDMydx9221ZsNOcZkmwSkw3DxhWccMCNnbK1+FNNpaZBQIj+ezFNxDA1zH9jbfiFRd
         +PYYkgi+VvKuA76Boyv6aTnV7bfMGOBEst9BFe6JK/FEG8FoaAMJ3YZOT4+wRozD+Uek
         Ntc6j/y2oo4cFThxNWGhjmPCQilZl6vheXp7ijHtMkz4Mnewk5xKQS0wWjZ7sKqDZref
         2KV+M7c6A5N8zpJu0m8ynAYLa+400ffHOeu7zpa1OTJ5+cPS198YGqIVVaZSzz5+WdMG
         /x7HEPtrzz+6KwJ4GtrScFfQf+Pwzx9ny7KpkH+jkA43CCgXoflzvBV4LfnhHf6T0emo
         g7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432845; x=1725037645;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xl3N6sY3QQXEL+4PK6BSWnvnm4ayfM42j3kBhFCQWvM=;
        b=SdgXRSI/cRYQvdTPLg59tVWVMmpJ+FYU0OgeuEuudZ8wwFo0tnueOx+Fp5TwB+RQ/S
         d95Hryxzapg5a3mfNfP/MiS0KeJnKthWYp7v8vE9ZxlV2VfJHpaL5uc3YdNYY417f+Yp
         J+AnL0+JX/9iwjpje6f0oHv16Q+zzSw1/ntoUQLTW7chJs2TVESolZjo9UKPQHu/2Kxa
         c6GkN4C0LUvvujy+irhfVw3GEppi1Aifbpe99xfPVMkCbUqCyLDQ4VQAFrzPKaRAIar9
         ZX43g4pCCxJKHl4vOwbWSHE+cmgTT5/MgpyblIDT36bIadJ4CXvZDBD6TT3J35sXMjVD
         5IxA==
X-Gm-Message-State: AOJu0YyyH7D1eoUEKkClZo9A0BxlvEZKZCGtEk742aqsYGFUOyQwxy91
	PMs+2Q0BOxvJ7Kjr8HESmGyFwBdnKgEaM2Gm20BktOzJQ2VwEWSsr+xKcQ==
X-Google-Smtp-Source: AGHT+IF2RZNrW6FcMMjd82CjrHnLwZID457WD18UWrqx3cSnnPmEexSmf7rY/fRiDxSt73NcklxOrQ==
X-Received: by 2002:a05:620a:2547:b0:7a2:c2a:c9f8 with SMTP id af79cd13be357-7a6896e3b1fmr306143285a.1.1724432844959;
        Fri, 23 Aug 2024 10:07:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.207.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f329826sm196734285a.26.2024.08.23.10.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:07:24 -0700 (PDT)
Message-ID: <66c8c1cc.e90a0220.275cb6.723e@mx.google.com>
Date: Fri, 23 Aug 2024 10:07:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3252223446397664461=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] test-uhid: Fix attempting to run when bt_uhid is NULL
In-Reply-To: <20240823152006.698937-1-luiz.dentz@gmail.com>
References: <20240823152006.698937-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3252223446397664461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=882708

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      25.18 seconds
BluezMake                     PASS      1727.35 seconds
MakeCheck                     PASS      13.79 seconds
MakeDistcheck                 PASS      182.82 seconds
CheckValgrind                 PASS      256.54 seconds
CheckSmatch                   PASS      357.55 seconds
bluezmakeextell               PASS      120.85 seconds
IncrementalBuild              PASS      1491.88 seconds
ScanBuild                     PASS      1051.32 seconds



---
Regards,
Linux Bluetooth


--===============3252223446397664461==--
