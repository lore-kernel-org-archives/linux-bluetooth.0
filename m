Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462D47A6A
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Aug 2024 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724625747; cv=none; b=AsOa6ZnY5n6KuPUShagwia5f6yasmjnHAVGqIL/xyAm6PvFEXOlRh93lFu4BIEmeM0MJmnzyZJwJMjyoeJhzRHuz/YAujq9I4XdPl7i7FkHO4gb2Zy7wktUriZlCqeL7hldUXATSLwfNc6cxNlgXvUQxRMM4nbGPutRqpLBehb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724625747; c=relaxed/simple;
	bh=4JxIXRJI/6n5sfS32/TW31dyRg+Bna2I1ABdAtp2vXI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mQb66UN7BqomfG2ZmA23VDntrZhKJ+7vRCT6guV693j6nNUwdK0xbi55tC3AHveZ2bopNtIW/fMCo8Z6qWN9IGjny7GSOgsS6Qy5LPp+tLGuLvf1Kw787d733VVrVFCeu3WsO9YAhmQdLBAEB1O3rl7aNEUpLAFx2lKyd2hLC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce21Uapb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce21Uapb"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-454b3d89a18so20870101cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Aug 2024 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724625745; x=1725230545; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=52OK6vPU5eJM7yNzj0UMQXLYl62Mxmz86+sm4ovwpcU=;
        b=Ce21Uapbmn7+RoOiBShIWn7LjgCWq44hLOhn7HgRJUw+Bkxjc/l85s/7SpCMQinmrk
         BXjNQRrIAFlz5aZS9sPqNBXLPwJ+z2dka8eayRkqOEaRRBhZgV5Eu/TOJrIxld1EiXAw
         zyKUJaVZ28x8fhAVfgq2SnMJOHeW+P/3vRKoZlyYNq0cRojKShtH9PO7fWpfCCOsH6GW
         9MLZlxpeuQUBRk3lvEWIixFriHpo4452iZpCWi5C4Uh+ihcG+ayPthcfU8RvwcXJmvAt
         n0EsbMlME87QJlo0dTP4ILm8Qq8LEG3RIJqNdko6fdbfGSbSCIYOANItOPTlleYKrfbd
         mXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724625745; x=1725230545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52OK6vPU5eJM7yNzj0UMQXLYl62Mxmz86+sm4ovwpcU=;
        b=FFe/fCWL4EvfZfjsXjKIu2zHoE5FX+HK3pCzj4ePqX0B56s5uQKdjfwwDxEOt5PgDS
         OgxUFqx96FNQTPtx1um/leVdzirBM2XNQ4ZAV07EWfieltJiTbBYk8Fj2bdZKi6++3hG
         Ue6ue+WlHMjaienKIwnLPyt1tXapGE/KZuTj9AS+pNH42VtkJpusaTQCA7EgouUIHKjY
         BYI1f3Vyie+n867Syp8NmT/5nTraTVP/X6EXg0MefzMnjS3M4z/qkNSwmfawiGBhAAEt
         zRmkyR7ADV7HyXvQ20eOdkQDWOYv9NVJkF/VmVVYpfa+edOmZi5suwnCrDa83MtiL5Lr
         quqQ==
X-Gm-Message-State: AOJu0Yw7LXOFYRAPqVPnMDT7WQMohBUJUJFr+oKfScZN9seFSlXM+kgo
	OlZjQhotMRwZEm3oydB/PCE916/hZjLv4lRaC04tpOXeQEpph8hU9PLQVQ==
X-Google-Smtp-Source: AGHT+IFXzALio1b6VueT8vO809FkhENgWEC86Izxn2Zu+GPpzIE+5BI760FZATsthU8yqYlhFuFFAg==
X-Received: by 2002:a05:622a:5c97:b0:450:4536:16ad with SMTP id d75a77b69052e-455096fb5f8mr106156031cf.35.1724625744925;
        Sun, 25 Aug 2024 15:42:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.118.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fdfc9cbesm38123471cf.14.2024.08.25.15.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 15:42:24 -0700 (PDT)
Message-ID: <66cbb350.c80a0220.257424.c150@mx.google.com>
Date: Sun, 25 Aug 2024 15:42:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4083201615969333300=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, uhrmar@gmail.com
Subject: RE: [v2] Add pattern matching for service UUIDs
In-Reply-To: <20240825205817.70066-1-uhrmar@gmail.com>
References: <20240825205817.70066-1-uhrmar@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4083201615969333300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=883075

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.72 seconds
BluezMake                     PASS      1703.42 seconds
MakeCheck                     PASS      12.88 seconds
MakeDistcheck                 PASS      181.22 seconds
CheckValgrind                 PASS      254.17 seconds
CheckSmatch                   PASS      358.38 seconds
bluezmakeextell               PASS      121.75 seconds
IncrementalBuild              PASS      1588.75 seconds
ScanBuild                     PASS      1048.78 seconds



---
Regards,
Linux Bluetooth


--===============4083201615969333300==--
