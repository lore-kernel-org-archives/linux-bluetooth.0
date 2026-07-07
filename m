Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC636A36B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437162; cv=none; b=BxfD8EfJKGCCZ9z1qb2mVJSDzqOmZNPU6/iJq/FcmhUt2Ht8Tk5uT/+JQrAfWR2aBGhqNzE6OKHRl1M2CZAnHG2lF924rY0RTRFzy2zXoysAAmzTF1QeN2d1tzL3+o6retvn1sAEDppQ48Nf/DRLXnrzwlJo3AEwDZaf/eqNJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437162; c=relaxed/simple;
	bh=/4T69WdRTDJqJvgfv2sBdsWKX1bATlWci3J3ZLnIm0Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BVrfT5DCW/1sQ9Q9et/SPr4gD5qTTDD4W2vyi6VK4XD7Xo6t2HrTNzIkV50Lk1T3tDsKxTWgjhLTzf6p1i5qzC0I3pdntZwWqji8min+ntr9NGefIqIpeJpd8/E+9ulRvW9koJkz7egGst0nxXq1GLUUutCjf50NO/+rQHpdknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAJSVHRG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAJSVHRG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c1d487f2cso51802801cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437160; x=1784041960; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/4T69WdRTDJqJvgfv2sBdsWKX1bATlWci3J3ZLnIm0Q=;
        b=lAJSVHRGe0M+uMScmghkbidJh/7HIK6oEZFatE496xuVAVjC4NfkDYV/p0xWWAFazi
         K+zPsRPR09qXSsTsKyaGOzC/nrm4MV54sAanMI9N9zTE8Pwo6mGNw2fqvJhZHiuyqEMK
         Cz76XiNtuRSN4EXHVuX2CNnfTHJwVVfSC1SNyHJ5860T/7sOWcKkhRmbImb7fpFnMkgI
         Vm0onc//VMAxpm+qxf+bTL0RJYJR36uvpOm4InOsq1DWaZ6K6olaq6WbGkUhzH3POai5
         MbYpnFw6PtXQiQf5+3od0MEwYnvtltnWWSpFEL9LJEX76w36skNwDenCqLHE/XDJzXR4
         2DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437160; x=1784041960;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/4T69WdRTDJqJvgfv2sBdsWKX1bATlWci3J3ZLnIm0Q=;
        b=fp9eG++F8YrU+cgkEJ8X1JUupEfMwDcmJfoHtjgJft/SyNWI/sSyf90DrF70ofceoM
         QMPLvVdLusjKo1f0mLIUgGC8DN/NIehegbTL42VS5lsedtnKXyZ1yVfRcxqNg/cwnpJE
         GE0MbFwSEdkGsCRpK53GO755c5QNZw2nC8x7/ioVTU8uCGTYzvXDYX8qOYOFMbgnq/cP
         A2DTjQNNDPubR9yY4/+WXHuIyAp/iCmtQPkA66xntsivPY+L86sTUrwNOwFVCDyadoWY
         MkyQxFYUQzZnJ5/DJvEH+hXnTG31+RuWL/6tw0SQWLp+9p6zvggYr4MvFdYMILR2CMZh
         c8KA==
X-Gm-Message-State: AOJu0Yyj3qT5v0bsOKBxK6w7tXf5QXVE+/qB5eRCTfUKGjBLk+yc5zdO
	ep0wgJUa1TJ/TkcwaEi+E4EvaguEhvbZlPIJCF1CfLDM3ShwLeNR9fJjOaN9sg==
X-Gm-Gg: AfdE7cnHlD6XLV1LIuTSwaD09qzw8G2pLli1zvs4zeD+HQDCByvW+OxHO5+1UE0otWc
	NjpHXQvJLbFevhrwjJ/h/w4S/PvXuvLvIoaKvaii8NOa6BzAefy+BhC+IKJYfScbVxGD/LJz0n2
	TJ3q+yacHliXqtI3qj+yhaYjWYxcQd2Hx3XKDcRlWGEOgC0JjW4hkQZpEO50ACSyKJzEpm8LNnz
	1qEV1feeNWXZYgbmpmsDmJFv52RT4prgkSSQGERTQ31IwsF6vivx+X/ol0aiTa3VtFNxYENv6Ub
	W73Wg+SWhzgCQNMWvzBBl22oKS3L53ZK/KX6xE3VE0i7DrN4T+1RiXfrHdTdM5Un7uzmX+IHPAP
	FbuOEojbwLym5xOLIrZ9Zwz/1cXJtGrkImGuv+aZDew91Z7xFutOXoeBjE2EdRmrpFpFsSNcMdt
	10fkKbKPakbSwpRbNDQzs=
X-Received: by 2002:ac8:5dd1:0:b0:51c:11ba:c51e with SMTP id d75a77b69052e-51c748b56famr59058061cf.56.1783437159917;
        Tue, 07 Jul 2026 08:12:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.86.230])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b19a66sm112883061cf.7.2026.07.07.08.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:12:39 -0700 (PDT)
Message-ID: <6a4d1767.6dc7cac3.32974a.a464@mx.google.com>
Date: Tue, 07 Jul 2026 08:12:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5202035501049561212=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oneukum@suse.com
Subject: RE: Bluetooth: L2CAP: avoid deadlock with process_pending_rx
In-Reply-To: <20260707123656.76552-1-oneukum@suse.com>
References: <20260707123656.76552-1-oneukum@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5202035501049561212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:1772
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5202035501049561212==--
