Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E96FC3
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570262; cv=none; b=FfaudRZJs6Riaz9tBFDWiYSMhcBZCzKb5z6SRFWCxmLVjmIHM9PaLt86XwR3dvXvBmd9vxWVHUJoJKPXEXYmrC21N4bAts7h6ItvRx7F2mVYlmKIb6eV0t2lqo1ms9f8iHol0sdKZHmJ31qumLHvZ5b9JSIQWCDZrQpOAjLBVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570262; c=relaxed/simple;
	bh=euynC/osb2kOvJk6upvtK4otRpFx2IEW+j8VjPywmVw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KtF7CpqwY5fzVHAxdmsZzUDtQWUNKYCwzG4TKEPe84Fm5C84+mO7y78E3NtBkf8+7qGs3qh4eSn5sqZEbcMwcUvu9IB9PWuRVb4Hj7Xjkbrz5nBK2YRBCY9R6ZT0/hqCBFUEEkPK+Ep1RiLRF9gicrL7fsaH7aG/YewIrytmAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVntwhLb; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVntwhLb"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6a8691d736cso24480966d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716570260; x=1717175060; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SwYjbZhksSxdwV1t02BuqItMEW1QGGEf763XY14Y6PE=;
        b=kVntwhLbw6v8/eGoBIqm8sGzckCE9yLnnI1pftSgFldkHAubqzt3CezxEZ4WRyHPQ5
         mprkQR7ZLzCZtMiHJH1vWKQyKCNXuKEGbwG5arZGPdHlPU7qHfgMqpUoKp2PDsn7YFN7
         boEj/Xh0gWgqQgudhssKvl1lLB7AamsymOJ3Z1650A9KAF2g5HOLBCdqbyLGAf3uSnZA
         oHiw0mgDO+3E//laGmPE+Xggvg7joeF/bD38qDTu6Lrs44VSi/SQQcnd4MZ300+zoOFe
         hfB0qSaZ47NuUIkO8DrqC7hNyH9VjUm9QLUam6jgPRG7JrgPJD3PdFbmwPy4q83h4qeW
         1IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716570260; x=1717175060;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwYjbZhksSxdwV1t02BuqItMEW1QGGEf763XY14Y6PE=;
        b=lEOwI7rI6DlxZnkMjre/RktNKRHkowTGXZQ2lVapmwA5K98Z4yY+O/Wh7IOyG3MttT
         XOGpiUKh7OPcJPDo6jZdDFxiWh/JQN8viEvQssOS9VoIxf8mZcTBa96O7ctzo0cHRB/5
         aNOmJLZZdz6D8KxjDvJvaWx3sCxgFJqy+79Yzqe5jEpXVUYFBDvAgiSYC/0MAB13ChPY
         4itadyUddZBNzcMjiNfArr83Vne/zTaP2wVt3aBM2H4UoOLhDhAxgQe+qA7LOWS98baB
         Uss1KECOL95kZ92tnGC8ZKxh0y0IC+x6OXZUFjTl14TIodLKmMC8IF5fFx2c6rBy21b+
         C5Ww==
X-Gm-Message-State: AOJu0YyUcA3ndwk85cTy4VR/arEckt2i6JSnXdoX9T6exG9cbOD9tB8G
	ncPazqalEiiigYrI42oa0h9Qm9vZ6OgPlwWQo4TqH51Nyh5XIL4Zv8EZZw==
X-Google-Smtp-Source: AGHT+IHYvvO4e3/Il2kaSLEETJLYS9nSQHbH7D90DPQmBlQvhWPw+XUFjRuhfyizRdzqUr8k0dH6rw==
X-Received: by 2002:a05:6214:2b9c:b0:6ab:9a03:ff96 with SMTP id 6a1803df08f44-6ab9cfbe9d3mr47978076d6.7.1716570259626;
        Fri, 24 May 2024 10:04:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070e9f1dsm8914216d6.48.2024.05.24.10.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 10:04:19 -0700 (PDT)
Message-ID: <6650c893.050a0220.48d26.39ca@mx.google.com>
Date: Fri, 24 May 2024 10:04:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6811785698487789190=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/2] doc: Add initial L2CAP(7) documentation
In-Reply-To: <20240524144709.2274991-1-luiz.dentz@gmail.com>
References: <20240524144709.2274991-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6811785698487789190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855726

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      24.43 seconds
BluezMake                     PASS      1632.38 seconds
MakeCheck                     PASS      13.14 seconds
MakeDistcheck                 PASS      175.13 seconds
CheckValgrind                 PASS      247.40 seconds
CheckSmatch                   PASS      350.48 seconds
bluezmakeextell               PASS      118.44 seconds
IncrementalBuild              PASS      2937.96 seconds
ScanBuild                     PASS      982.44 seconds



---
Regards,
Linux Bluetooth


--===============6811785698487789190==--
