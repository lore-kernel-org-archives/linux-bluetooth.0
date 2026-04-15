Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554623385AC
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776294834; cv=none; b=tWPtDnnNNIYMRY/RwcpoZQacrgcXnCokVPyB1uYIqAgi34xRUX7VNY9D4l8rETm1nDpt26iHcRD5XRb0qNml12/hWL00auv3lvbMw/9xpJ2b+s8Ah/K5jQEFvN/4o42iUDT3DNSCQzyQaKA2RZObl3kDEJWrRitOCjNJBv51g60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776294834; c=relaxed/simple;
	bh=VOQzOFuGnUdgX1eZPkrt9SdhrArM3XzsrvD+EqQpxvI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iCLB3tIudQ6vhVZbV8D/+0+BxmGkfhZVqOZ66fKS7oW0OUxs7MTvezmPkM5PlnJkyKswXfrptDDhYI97ReY7B5xuGTmcX0kYDTHKnQbwSV77bM7rZpT2SZf6dr9+fiDDeUhWLGeC8VnZgGws0353n7r1GwzJYukLuk4ZexW7Hm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvWzbFO8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvWzbFO8"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d6249bb99so58562461cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776294832; x=1776899632; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VOQzOFuGnUdgX1eZPkrt9SdhrArM3XzsrvD+EqQpxvI=;
        b=kvWzbFO8tJtkJLHKdUgq06B3lsdohQJD+fO7t0uel5gbIVdncq+LNh85+350ejISHO
         D3PDoayTmKYH5KSSesd1FNQ5n+i+6vao5/p6hU9lkTbh6o+ajeEY8u8yzSSdDJf20ZAH
         xmIuKrA+YUIxKbUuJDn9kDaAxcf7v6JKGiYR5cnGLW5v6exaepJzy9i44RVHNea6dEzh
         2Jor0ounkPjhzIK1gicgPZ79ez+xRUtYH5tzaYUi9EZ/Pw9PTSgmK2QCEca9+kbzQxUw
         OLCMpnSI7z7PXap9UtvNSqjW94S+Sb1mAfQKeFQ3GEAHCACfIlGqd/luWWv20S8ERRXb
         qiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776294832; x=1776899632;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOQzOFuGnUdgX1eZPkrt9SdhrArM3XzsrvD+EqQpxvI=;
        b=cWZEmWIEFeU2izgYwgLo4ufdo0Lk5Jw2KlBU0w/OldrBrqorb1y5Fj98Jv6n0TCMK1
         1kqpb/G3HmK0xjVOj3YHWLqd/IeNAH/juOdVOpyl+SDQnsZDm7c/D7yZPScetqOAoDbA
         Fq3/OWJqMMAm3+3oJUkzF92IKChEzIfsnH6TLC+ukLoUB3Dhjm9xnlSd4lXROyrpzv+B
         YmN9H9OjHBV9nqet07rIRJ6cE6e9elrwvU96/tbhiOLvODSBWSCanKEITc4fKo5GIKIZ
         WWSdO7sNipHW8/NaDk++jpCxBjq9c8M6TEjwGbdwrXcdnhL5MgfsgPbmkfoiFYFgNfGq
         0WHA==
X-Gm-Message-State: AOJu0YyoJm8SW/rRiToKwFHFyCIGSGreMcYV5KxyNOUNh3JV6K3u3FOu
	C5uf9TM0PjlXQt4eay60iaPnriFKy4jswAhlyBaX53CKbpkt8lgDfp8tnbWp5Q==
X-Gm-Gg: AeBDievqz93rP3gKZp4HPjB1Al9SGjWj4TCjjvXvst11wm8QhkWzWnj92Dt+9SIOGXD
	kG304JGo9jaNy357vMWniP3yf3JAbxKN44JdFAbDULbeGB8Eo1R3GD+8vpaecyMLcLwuHxm4IiK
	s99cLMlctjTvexPeMClxVuyAq8Ui/tkUUUT9jQT3bdEGSAwjJZ42wOsK6pIiGmvRzxcLhFridzP
	NvQEbCg3h34qCK6pGIOAz3gft35RJLdPE9G2bQTQKt6uYeFkG6N0eopIo+jY/oJ6ioXCc3gXR1V
	QdkDVMOzLVtaTMJE+VrRPsPeYy2aGCH+h8OKAccC89QauLQ+4g6/nTY2lgso5cuixK3GVw4GwUV
	T3aqm+FFHgqxaIh4mqFDU2jYLV6Rgw10CMpnpZYDbarSLjf52xGRsZS6bnW69Uo8tmzfTYmav8A
	ZGS8gMi7O6UTXVK61ldG4nQmyTDuzL1J7DMEF3qtM=
X-Received: by 2002:a05:622a:6105:b0:509:34b8:a373 with SMTP id d75a77b69052e-50dd5bcf323mr328631461cf.32.1776294832035;
        Wed, 15 Apr 2026 16:13:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.7.48])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9e0bcsm23734241cf.15.2026.04.15.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:13:51 -0700 (PDT)
Message-ID: <69e01baf.050a0220.15d1d5.b726@mx.google.com>
Date: Wed, 15 Apr 2026 16:13:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2099133767015003480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: [v2] Bluetooth: btmtk: fix OOB read from short WMT event SKB
In-Reply-To: <20260415222506.1548403-1-tristmd@gmail.com>
References: <20260415222506.1548403-1-tristmd@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2099133767015003480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 28
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2099133767015003480==--
