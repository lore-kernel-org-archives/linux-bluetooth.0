Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180B190472
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631577; cv=none; b=C/EMQtfxxKLgEd9N5Nl1N/4b+p0AJbpf2s+SzZKKdubDBnSfpBHyj/wOIc8bplMseklFvYjndb+HbKzqAEIlntxag5qyJFQGvmyYx2xQTOI0dY7rGW8zsOiaxGElUDyz8vHcqlu3ITsN4O5thd/yRBKqDd4ZQNplHRzRnTqEygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631577; c=relaxed/simple;
	bh=mfWZtX5irhtloNQUYNNdPsPjNAHPN0VpqVDkSa0Dans=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NFnRDF9JzQ39EhAMufkipw7xdR0bisqPYuUC/CGnpk+cTco51IMvpIThoCDTTeG7XwdboUNScXbIMZkFVr2vQHcJHPGh74jFdcomfIwgfJneUCteL7tLtf43dF1chFV2slrMKrGhJR/4Pw/0yWcdEazTdGYpKGAuXPuicO6XLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU/0YkCI; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU/0YkCI"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b5e6eded83so257806d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720631575; x=1721236375; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mfWZtX5irhtloNQUYNNdPsPjNAHPN0VpqVDkSa0Dans=;
        b=dU/0YkCI0STImdLLC+mGdjGNTybOLxeqr+d5EM/i2Q9yOiFyqIbOwhuNCLEd06ow9d
         loWq+l9ZumV2pl0kASBDadvOxSWVzsQ/hBaHRyYJ3K5iKSKgpL6EX/iSqsXCPEEIayTX
         au5hJBmh0ikIcdH5R29Ua9kf9LvW7OUlcIKsxTB4ZjR8FhGfZlGWbPlWg9zT6pIqGqSM
         f2ihsGuioYrbSEmcN5P8VgRb2hh1JfFAj+SWeZ39awNzwuzvHII1TkaBpVxS+GX6rSXz
         rpLv/XmesPCJuJ9LSJQz8iQI7CqOhkTlCnUnTR0RTmmLRo/K2m7qQkejRPRtdG4P4fys
         m13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631575; x=1721236375;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfWZtX5irhtloNQUYNNdPsPjNAHPN0VpqVDkSa0Dans=;
        b=BoWEiqi8di3gd7VEiu4TfDV360uKzlMEJJjUbxq7IT5K9HTySrGEIhmzd1ROGeSxqM
         OgsgM5XFQQXvC2lK8l9o3W7kEA/vw6dGjhUU8t1VHU7lb7Tr00tEbX0KGADbPUAW98g9
         KN0Piieak0M3woni75b2AhdvFyVNPhO0sO9mS4k65OsBPekkwcufr7Brx+iIpFGR2oAc
         ihIJ8docbyX+E5RFylvPmiuDLNcHUlR5cw/NAEuGaq5/A3sUf0T+/k7yaQ0qcYSL8CXF
         UM3ElV+JGTYZ0ItVsbpOXQEkaJH0c+BGgIQIqzJKJf0H34csP2FxDgt91ub05J66L+pr
         OJQQ==
X-Gm-Message-State: AOJu0YyDg8mWsxjJqSCQbO/iCg5/OvwL+uO+wirUg3sL9kfOxZTDYQU3
	6pgkjsT49yfyMr56HdFg+1BAcnh66yLkJ1jpMFhJMIicfgeJvzNsZZ8NHw==
X-Google-Smtp-Source: AGHT+IHyUMv4v8Xdt6Bi/9+MpVnFsnL27cNIGuZmt7eJ8NjhZKKZjwmrSxyAi1cHezIxz+k1Qj9GNQ==
X-Received: by 2002:a05:6214:acf:b0:6b2:cf9e:866 with SMTP id 6a1803df08f44-6b61bc7e910mr76761706d6.4.1720631574717;
        Wed, 10 Jul 2024 10:12:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba06d79sm18412496d6.66.2024.07.10.10.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 10:12:54 -0700 (PDT)
Message-ID: <668ec116.050a0220.1a2014.8168@mx.google.com>
Date: Wed, 10 Jul 2024 10:12:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3737765133932626545=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rahul@sandhuservices.dev
Subject: RE: [BlueZ] tools/hex2hcd: fix musl compatibility
In-Reply-To: <20240710165459.26813-1-rahul@sandhuservices.dev>
References: <20240710165459.26813-1-rahul@sandhuservices.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3737765133932626545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: tools/hex2hcd.c:285
error: tools/hex2hcd.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3737765133932626545==--
