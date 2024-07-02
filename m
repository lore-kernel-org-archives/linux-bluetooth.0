Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793D12FB16
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719904486; cv=none; b=nhR0iWz7RLAJwk/0jzZEC+An9PAIWI3hzMpT1HaSlJv/hQCjRTV7MfYM0LSm4NTcbKP9KZIgVjYvF6LxgeOYLSMQPwWPLwPUxCAx3/8Tv7QTr3+VhxdeDIsDKTSr88Wp1X1z7oguo5gJJ32nGbqFn6S8hneYLQZ46fROo0Mqp00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719904486; c=relaxed/simple;
	bh=72aZpUXAEFeF61fOHBk99xAI3iKkujAmYuf+ivf5VXE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IES/3A1TS+O8NWlGh9sw2qqS7dSn+rG28FvDKxiAGE5VRwG+O0oVknnY6G6ifijQwu070LlAEPx4+JjkU94EljIBLyhLWA64Ts5c+rPBIwnO/PcNPZj2BCSm13HIgQfQB+Bwu3KE7Db7IGnbOodz5HJv2Y2+joYLE2F5MHNk9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKbQz0TZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKbQz0TZ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70abb539f41so1708763b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719904484; x=1720509284; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=72aZpUXAEFeF61fOHBk99xAI3iKkujAmYuf+ivf5VXE=;
        b=BKbQz0TZ2pYfL7xkllWwgv6I9BDyEzo2BN6ehEKqxemYPQ6jptWaMEijmx5d9l7/6+
         zFvdvauBDKtrX9U558JKkeegVKZ1IkHFbv8mKtmChCc9ACp74GiWGXtZuf16fHZR3qol
         YgvBG7rDyLJqLDqcB4BL2wkY4EbR+gVM0EWIYm9ti14vFYAf8lxdgQS8lHXiNPAJZJdS
         FVcLOlCyCkPyhbF8J+SS7/v0/2inDg6O7hhOeON0LqZQPk6mFzglpGyExl58C6t3QP1b
         nFHYsTe6PTKj8iwK99lShcRda3Q3fMvk0cvfhVOlwc/ZUiSPHfWuaZYwYlOOau+UIlZ8
         hyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719904484; x=1720509284;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72aZpUXAEFeF61fOHBk99xAI3iKkujAmYuf+ivf5VXE=;
        b=KC4DbWTqIKTb/uR178GUpN9k7Q8A6qCubemgUtOQpzh11Ycoxy21UahRzY184+fPOq
         3Idu7TwxdNNMPWd2/uY6nKh+k253wPVqxWZEwzMgtyo8nGK2LBoKJxkHBuySanwS4suE
         CN6F+ucyR/ptUl657W52nW80++y+M1mFvJX3mtMqTU0zirne0nVswlVuawTs9Gvo5hHB
         fhhvvQ+Qapp0BvUNPfEIb+0YiK3pR97ENLPnaQxa/AGGB/EmR5tmYex7gVLfA1BoChWr
         1geeyIC4yUSDHeC3Jo9CUO/IhchZsO9uj2BhvPpCnFqtJ8Q6OdokyKmyK8FBEV5RJ4/d
         7IYA==
X-Gm-Message-State: AOJu0Yx1APq2hvn1EaJITGdHoC4kCgkfIhibq5bKFbUjzVoZMzcytArH
	4pJOHxLPxMGsG4N72htgoEBFEarte/HBnC/7Mo1gYA2F7WNf79s36r/6LQ==
X-Google-Smtp-Source: AGHT+IFhbnxVGb3HaldXQyCWNj+MPaKVheP5jWcmTflX17TObsy4NebDvdFV8H+Y8JfW7E1KVYcaUg==
X-Received: by 2002:a05:6a20:3cab:b0:1b6:d9fa:8be with SMTP id adf61e73a8af0-1bef621461fmr10916166637.40.1719904484411;
        Tue, 02 Jul 2024 00:14:44 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.36.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d153bsm76364665ad.40.2024.07.02.00.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:14:44 -0700 (PDT)
Message-ID: <6683a8e4.170a0220.99c2.9132@mx.google.com>
Date: Tue, 02 Jul 2024 00:14:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3351346785224710997=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v3] Bluetooth: No need to update the mas plugin
In-Reply-To: <20240702071103.24986-1-quic_amisjain@quicinc.com>
References: <20240702071103.24986-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3351346785224710997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: obexd/plugins/ftp.c: does not exist in index
error: obexd/plugins/opp.c: does not exist in index
error: obexd/src/obex.c: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3351346785224710997==--
