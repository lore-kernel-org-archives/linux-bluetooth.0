Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665B2C853
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918115; cv=none; b=dktoz+D3ZY9cev8arM8HnfphplaPdX8Iu5wfgTX+dqvhc+dqPyUKzoP1XYoFu1UfchUmWcRbS/HIU5LnkN3FOGA+HW+2ZI0sHvMZZfZA/T9qphIwEwvWcceZlUSx1WZO6JVzgRfl/eKWAqK8RrGe7jRgPxnNvScZ8ug41MMvODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918115; c=relaxed/simple;
	bh=BOkLKYAgXkdTCMmGn/PSp3yUCBpvVH+KuMH3dpksnRU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BbL4JFlW5+yc/qLQjsx+8jcIH1a1vXZl7tPbUQ4aTyuB09T/S9ebAS0FZkMu8NQ5rCJ0h62v45vD+nllBHS2bjGTiCGOtSj0HkQvdOgqz7irsO7BnGh63/HzhMN3PNhaz0oIXs9MFxZQh8MtXHYFE1yJ3BotaztBWkoQtnkYx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK38iOHy; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK38iOHy"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df78b040314so1196317276.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716918113; x=1717522913; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zFir9rGcZD1HVjWXTF75MYB053YhqiliLREhBMP11S4=;
        b=hK38iOHy6BmlucKih1erkZYxtwFCe0pPemGeU3WzA2bVF9oRZeIroJlR/37vBRFeZ2
         AHsXLrfsEBLIOcJE6Z9fK8J2UbNaWkekoxUnNJIj+3vfv8AO5SlO8zrbonilmdMpUtUG
         kdrghsDJolmyZGO5bvR++TVMPxaG5xx5nn1UrUFk+TErF7U4YZv5Pn/iZqb7ltCJ8CoZ
         Riuc6tVUem1ZwSvptACPrCxBZeBKnql+lepI27utZCUBO1uz/nsBCVqasTedKTnZN/8z
         GfW8fwyumKecez3BclPQIEIa4tra/mVmlLrkKNtOIqyJdKBwkPuqntJOuiYZURIrJSj7
         CVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716918113; x=1717522913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFir9rGcZD1HVjWXTF75MYB053YhqiliLREhBMP11S4=;
        b=OqBZN+nES5PwNFMAbiWRlrX0Aov4M8t/mWDs8hbaz4CXJbwAYN7dj6jN5wACrzo69R
         nq5OtbQHK6FQ1ncIw3Wp7aKir2qrr2979aSgbnhHp7gw+sQyNWIBb068ipTrsMuu1VQf
         Sky0TZJU1mFa2GDdhjxezVYpU14XHxiWPd8yzRKpgtIhEvkKIimuoixg7ut+bu095tmJ
         i5Ndi04d0aGIzjn1C5f+TrZglj8ijnFYCOfXirqr7VOlnmPFFctsCtEct//mFBc6GhuW
         /AgEUhfZKs0ibSYGnybvXjulSvShrOg34zx7FLvQKOMyHsurmX2+YwX1TyRiEMJnHvTh
         qDCg==
X-Gm-Message-State: AOJu0YyRnFwa9J1w9Apdgyk3kCEmAof/640GnH6R+2ZdmEKA4eOLWLHR
	gT1ODdkc9Ho1yBthGQAsDYgUEUNndDM5nsJXyCfUk/nNKJGd2mUobJ04PA==
X-Google-Smtp-Source: AGHT+IGkC5cxRW8f+FAt9C+vQvnGrhyspEkMfxlcZin18K7mGBdHQBHY+VcMj4rx2gqgVHBc96OsnA==
X-Received: by 2002:a25:8303:0:b0:de6:141c:3430 with SMTP id 3f1490d57ef6-df7721a019amr10882440276.17.1716918112895;
        Tue, 28 May 2024 10:41:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.245.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd39f03sm398574685a.123.2024.05.28.10.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 10:41:52 -0700 (PDT)
Message-ID: <66561760.050a0220.79058.d829@mx.google.com>
Date: Tue, 28 May 2024 10:41:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8158099879479952526=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Transport: Update bcast sink transport state to pending
In-Reply-To: <20240528160320.103845-2-silviu.barbulescu@nxp.com>
References: <20240528160320.103845-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8158099879479952526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856629

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      25.04 seconds
BluezMake                     PASS      1640.24 seconds
MakeCheck                     PASS      13.57 seconds
MakeDistcheck                 PASS      177.89 seconds
CheckValgrind                 PASS      251.92 seconds
CheckSmatch                   PASS      354.42 seconds
bluezmakeextell               PASS      120.12 seconds
IncrementalBuild              PASS      1436.54 seconds
ScanBuild                     PASS      1025.86 seconds



---
Regards,
Linux Bluetooth


--===============8158099879479952526==--
