Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD41474C0
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149183; cv=none; b=JF6W8CQ61xe0I50zlxwrgXp8RnIPNGWYU5ADZvv47EhsvtTbqAnKBo7IbPDPIAoyxbuV8ds56kWLDnYjpCMXXCXoyfrSRnX8upZQVY9l2arEUioi7jqhSZazINcvQ3K0VfLa213VF2txyw9tXxd5aGPbbWY1SDZrSQyJFqvq9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149183; c=relaxed/simple;
	bh=v+e9YhQsXWbCYoXOfFFQJJdyUnWymC5gUWBx2KTybxE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fFamLMAnMvbxnzpu8IHDBDuUrAWlAQmykxViLx0NyT6N5+7ZddYaMOHXg6mwwxUTRNWCsELGpirzzoxGUgmYJAVyWaydOyF28KMLbON+i458Oln4jhjpJyuyeXNLy5PSI1MdPYcxbB3xst6fLdtm591Y3M6YMtker2AbKpWUvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dppJyTSC; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dppJyTSC"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6992d93c146so503636d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149181; x=1712753981; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UVBJKZqtjP/eXfkiUmGMoXz1Eool2gTHOFHUAa3bBJ8=;
        b=dppJyTSC0Q29+rmRF9TOGRXS+I7FE+rPDsu4qFLSp4vAYCiLLxmhkq1ov62oq5EE9R
         o7Jkf2sOcp3iKZwqnFQcSet2x0Y72cfhUxVk27f5XXwJtVyDt+3ur0kHH5SNUmQQy5oQ
         Usaj98HH+v0j9MszfvOeNUUHAXQiVvdQQZafoMCXtR6WdiQVQ6HdXwvMZhffPb8AJYfv
         y+edZwlp1ajOrVDOPajtbXUHs08ULrUcjD9EaffSOojK3xO47oPOpLZYNbzHCsooPGEz
         R7WF8a4fB2JN6HrY9rlsAAoRY2Z4znP5vPpS4QWGCN/vN6fiCis8uGnjcE4AbXCFX3Ui
         y3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149181; x=1712753981;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVBJKZqtjP/eXfkiUmGMoXz1Eool2gTHOFHUAa3bBJ8=;
        b=a2NlMxvCoy+2l9tgMcmSGhyx6eNyQhd6/nt/6W66nFou7MKx98S0qEa+cj0SQtLuRq
         PMp9qc6JFMjsqf8Ys+6SAsTA3GSHyp8tltHGlxZhci8eJSuX/ri5aSSurqKJqfNp3i85
         V4gS1E9KUE5A7n38x9Q4gd/yNYDsdYJBbiy6Ge5VgkS+nzH9Jj4jjVUynWsizsj4rMts
         Jyho2QGjQJAYKFkJXvSsPDibqlhzWbu+O76wvqc3G20dRPur3Hc9/DC2n+b5/7n1/15C
         7yfi/rOYalPyxV/KBz+6ZsGNRMweyvlkEzKJA2EfZNjjVdlaYxTtoqzVc42pvfDnMODU
         tm3g==
X-Gm-Message-State: AOJu0YwC20Q4nj3b66pvoBnNMFu+SvuOFRdo3qyVW0XFSRLxzr+OYRum
	MJeX3vJ2f5PJTuKXAnBuK4AlLKkhAMfNnK6nTe1uEk1QgB+Z6obWiBJxwZYA
X-Google-Smtp-Source: AGHT+IET3O7zg0rdTRfJm3DyVzuqt48Ialc/Zry5ezzHIGwZ2aK47zz7qf/UjyZ5RU0hfPw28588+Q==
X-Received: by 2002:a0c:f791:0:b0:691:abc:ade5 with SMTP id s17-20020a0cf791000000b006910abcade5mr4070148qvn.27.1712149180671;
        Wed, 03 Apr 2024 05:59:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.179])
        by smtp.gmail.com with ESMTPSA id p1-20020a05621421e100b00696b282f582sm6455309qvj.97.2024.04.03.05.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:59:40 -0700 (PDT)
Message-ID: <660d52bc.050a0220.ceaf5.058e@mx.google.com>
Date: Wed, 03 Apr 2024 05:59:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0626326089686805787=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: Fix descriptor display issue in btmon
In-Reply-To: <20240403190511.Bluez.1.I0e799d0a6494565e232db4c86a8979cf898b1840@changeid>
References: <20240403190511.Bluez.1.I0e799d0a6494565e232db4c86a8979cf898b1840@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0626326089686805787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841052

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
GitLint                       PASS      0.77 seconds
BuildEll                      PASS      24.08 seconds
BluezMake                     PASS      1626.86 seconds
MakeCheck                     PASS      12.97 seconds
MakeDistcheck                 PASS      174.35 seconds
CheckValgrind                 PASS      244.01 seconds
CheckSmatch                   WARNING   346.65 seconds
bluezmakeextell               PASS      117.47 seconds
IncrementalBuild              PASS      2928.57 seconds
ScanBuild                     PASS      965.46 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============0626326089686805787==--
