Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733E2798EA
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135437; cv=none; b=nha/FILfLykYTVsrcTXQLjC9y13JZaoyqUGGeHBXG9HaG7kO5Pm1062SrKO2g6wfhBhfWCjFQBH6tvcLkVOvfUnNdy0rW6ind7KcCnTz7CS6/kEkenNOEAHLgsPIE2tLM4fPH2j8anhDIDL4PhxkzXSxuDHizvA/30VA3Gx5XeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135437; c=relaxed/simple;
	bh=p2UyYRu7jxBwj8oVU03L81SpfJOeR4V3yfsxbvd0qxM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D7GboEh8759p+ai3CTBxJNBwx72LbZBFQ3IN+KTYFO+rkAcjZ3FAJdzrl+cxKfHmv+v8H0YpVzHkrqiPgoMaAAGjMDM5KUDj79qEyDHzhtRHY63uNycoeWhKO07TYEohBqAwLu9BJqCTkEwHj/ywMHz1koxycMbDiGY8KENUd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDbP8nar; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDbP8nar"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1172286a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787135436; x=1787740236; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5R55mdgFk6mLj/xjydzhVAG2PpqrZ9vBIqG9OZ8trcI=;
        b=EDbP8narieBgkGlmPv/6WCc1/EiYt4MJwbebeaTknF5cMteYGdOd08SggwQYEWnDlQ
         2iQRO0SefZLfDEajLISFBtqhzWPAQkHRda0iz0Nhq6+UajNBOUVkaYHGthrTjaYUuLnI
         jsj8XA0swor8skEDdkhLe7IYW+ThcS6KDo+CmykeqvP2YliKCrPG80eIwS7yUIVYnsaX
         BB4jcO8D1za8HQrrraXW26v/yDCJFC/KWSQ0uNSeDSRaApFwchYc9HZrtG29/L6jiTcM
         IMGRA9B2SljyxnwA/pWQlDZm549oPDpBWxbq3wE0Zi+26gS5v4V6CzZ32CnqHGqHEDzX
         +F5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787135436; x=1787740236;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5R55mdgFk6mLj/xjydzhVAG2PpqrZ9vBIqG9OZ8trcI=;
        b=deQREuxPXC52Fcn1c6AqXU3Ty1ErElZbb4h+CqXungDUqkitaqUIadDLHY+Fdfgf6j
         hzyCtHuLxmzxA79IRVH1Ac8WeFX5lqw0zae+hth2uQITsmnxx8RgETAS8xv+zIj0A4eh
         w0F18XDurRea7ml8wHfPL+hqH0XMtM4VTESmBFsDRv+vVcXaBp+wvDpkjsTrj9a3BqrE
         vo8m6JueaBjsi+Pp4EpOfZZ+BmbsJvmMY3w7UDUetqGkHx2FeTsgWQyJ3LPZZbSTX/+H
         8k/zHvlh3qlNNg26pCPgMUSjTLwOCgk1CTfbQr9KC5yKyG28aPBUs1Q4WIPeO4FU0V8P
         ohXg==
X-Gm-Message-State: AFuF++mIXs47d+6bkyX5gr93f3vNR8CwpVSVdOSLVKVtMGbH46JxFCLK
	f4yMRr/LPVZ7kFyzE7Y25WQylARQDv9cKwVfxPETPQNL7whVLc7hrnTSxSH7LA==
X-Gm-Gg: AR+sD12YynJcIwP4D+I0Ca2zGLUCYFX4r46uEeQmQNjxlLR2XpEZtJg5E/glvjKAHrQ
	IMtGYXNBCgZzNrsMpMjxzCGm4sPFknD5+Dzb5OqjL3GQ6f6aRwZtb/LCXOYW4xk9jkFCdXPAtfl
	FU+1cV63VwabGjxXX99EcUNNy1iAAVk9QDvK5NtIOmKIFHlXZX4m+EhSRL88IDQ+WyDKPcqyRgM
	FFViSNwLmroaHTGFGICaVudmeKWU9cdqZYLhH6oOkqcOJFKVOmO2W/lgZhyuXrE58RKCfRLkvzH
	wns2Q8d5tFeigq3NH80zpALJ/nx2qCD1X/IHQ87j0wmNztCxgigp3oVk5Ke8rUw33W1R60M5Zg+
	qYqkEJInQtRYms5sXEWNi4bHgvij22UWFapASCcS6vjWWsVABnQ/g7gWh6tmFLCxf+rgP6XJd72
	/1syQL8pqap6GavnL8QbAGNL7wwtcyrhm9VTnZRwKfT14gkYfbc7GT/nH2p04a/amKbY5gPw==
X-Received: by 2002:a17:90b:3fc4:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3958110c755mr6958847a91.12.1787135435716;
        Wed, 19 Aug 2026 03:30:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.209.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef6ec40sm6325338eec.7.2026.08.19.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:30:35 -0700 (PDT)
Message-ID: <6a8585cb.1e1ac41d.39475c.1e42@mx.google.com>
Date: Wed, 19 Aug 2026 03:30:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3601201597308472286=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] doc: Fix typo in test-runner.rst
In-Reply-To: <20260819091333.1203931-1-hadess@hadess.net>
References: <20260819091333.1203931-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3601201597308472286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148340

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      602.08 seconds
MakeCheck                     PASS      19.05 seconds
MakeDistcheck                 PASS      155.06 seconds
CheckValgrind                 PASS      225.69 seconds
CheckSmatch                   PASS      307.93 seconds
bluezmakeextell               PASS      100.78 seconds
IncrementalBuild              PASS      593.62 seconds
ScanBuild                     PASS      958.19 seconds



https://github.com/bluez/bluez/pull/2412

---
Regards,
Linux Bluetooth


--===============3601201597308472286==--
