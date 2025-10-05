Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E91C27
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Oct 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759655693; cv=none; b=ps4bug6SRbHBYmeNCBr/5stLu8yA1L/RejACGauqxl3Vn0cv+U4ETLlLcgvJSARV6wUzhZs42wloJEyGyHaBkWGzm4Jxtx0ekiEY+ParxWz6Xsn+hqZSTGE64F6jgBoJDR9sy5IvofRmJ3iE0cmuqXaW0CrDjOtm+GuWMAMiYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759655693; c=relaxed/simple;
	bh=xBW8dYOMHh0IDCNOaCOLrAlAEhmyXNTDh5o8IKnGL24=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eroYtsj1pbzyqC5/KwzzUT6ZY4tvdaNhoWQA1TVPXWYCB8gu1wQdRf9AAHNL5/aB3Ya2vCicbAemfjA1ROFi5rqjFMX7oIpyqizkL5DAIF5inIx5afnFDLoPFIfugyGG28jRCtbAbTOhWxbRdmA0c7kApaU82gkofqYZG6xJofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Akz5izTs; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Akz5izTs"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-9399ddb3ffeso286914139f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Oct 2025 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759655691; x=1760260491; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xBW8dYOMHh0IDCNOaCOLrAlAEhmyXNTDh5o8IKnGL24=;
        b=Akz5izTsU2XEoS7Zwt3iGzN6+JZPeMgyapjAJfah7BIADrU+BpchWY9IACZ0EPlh/o
         7kEPdjOEqu2/aPz++EdzDsBuVTw0dbTsWro0JJqmvhD828s0VFjGnJyQpRqaoKLqOUwZ
         hDEU7bPTXcH5smq93cuS/Sj/pkfOJWoznphRQeHTQzA3WJzMJEYRbYYUU5LHl/gUmBqd
         GkemXpWLKRABWjfLdj4tk+gXt0i2+jpcVFy5H+Tzyh/t2McZ3LMTQNfVvAx4vbvREwfS
         M9yKQxixXvGrqwRD2vuonavmA/ChyIVuQeKXzq8qTVq0R09C5+lnvqEuMKwe5pFOgvXJ
         AXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759655691; x=1760260491;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBW8dYOMHh0IDCNOaCOLrAlAEhmyXNTDh5o8IKnGL24=;
        b=ljSkF+AVRdL5CWrixyXccd9PkyNbZ9nXCxc4UvevEBTl9/9YtBVMvUZN45pZGUj+yM
         oo0escmG4SXxzu3sJoEFAlXyQLXtPiFiwr3O38/grsk6NpKWfPWfNW+epYWrYaTkWopZ
         zNM21A0QilasxIY4fRhSZgwOCqeBSBo49waO4D1WL7/RVyJxvD+gpwgA9I88KW7hbKtg
         /t3MEc6DIu8wwZV32AT5keHwUkZ4cnJBQrTtCTNCHVPnBFp7vkiZGmVEOcopDBEsB5Iv
         DcCknxWH6pA4ko/3mFH9PUO+TWJOrsnwBgV29N515wlwKPYs3KzZjsfc2JLJ9PuiwtKx
         zhBg==
X-Gm-Message-State: AOJu0YwiVZ0H3dDVP41Bks19G0gJRWcwlHc1ctXoPTbYMVwOBIZUmB0/
	z/8Iyimy+3doI/WmyKLglrrLBa2cG8N2ZMFmA7A3tAYGQWiUnpjOdECpv8/xog==
X-Gm-Gg: ASbGncuu6u+BBUYMG9YOPB4MUJUQSpqEWB39avPo9D7V5o6t22xWdw7DjeHGj7Yvh9y
	zLduUFF98ckJ6++ZeWjbp3jx/V+qcmJtS4HsvCgegTPRMjRd73yhlge4xmdbFeKPn3BZPXkn0hA
	DQLwF5KWHKdT7LUKpq1BCrZM0xYlLt8G9LFgbu3g6tXDvJoDmEtLA7lwt8IJbtMdXbv0WKlU0b7
	KQflIb0nyzMlHO9ju/Tg8LxSv8CokU3tXsPeLP0vSWvjwkFtciBEfZtzgzMpolbETYjxluDsNLO
	pC1Q5pS6NxC4ngm52k62tQNzMm6HY+EvD0UzXOjpqkhRdAJK7Psq3tdE4rqybxYHW7bD0GEmTrs
	Z35Z7SdTUmiDtO+ordmScACpr9yXKxy15wqMVtFkQ+/zLKSGqMQi+2dKWuxgIvq8Z
X-Google-Smtp-Source: AGHT+IHG9acDqXCqw4HPW9lN0swxjjbM4T2lKjJQCUJVLMLTBnY+IgV05Jaicw3wmkByGdRzXbUPHg==
X-Received: by 2002:a05:6602:608b:b0:92c:c80:dc61 with SMTP id ca18e2360f4ac-93b96915c3bmr1216187539f.1.1759655691007;
        Sun, 05 Oct 2025 02:14:51 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.201.52])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7d81c735sm357389739f.3.2025.10.05.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 02:14:50 -0700 (PDT)
Message-ID: <68e2370a.6b0a0220.17012a.5e36@mx.google.com>
Date: Sun, 05 Oct 2025 02:14:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6056712688543936553=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liqb365@163.com
Subject: RE: Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV
In-Reply-To: <aOIyJOnP55mmZUut@9950x-Ubunbu-24-04-dev>
References: <aOIyJOnP55mmZUut@9950x-Ubunbu-24-04-dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6056712688543936553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6056712688543936553==--
