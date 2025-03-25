Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4519AA56
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927690; cv=none; b=qYfM153u4Ai/ELxM/wEsYoDEZwAGGDR+8bsY2dqL6YUxFrjxWx+hUErz1AdxsodpnWc1GZv8pX+H5qdhDiTLT1ToBCj2toXQd6SWMv+5shhCKPm0dTAW+73pnRAKbKTHd6TC6/frEo6tZYseERz+hQIlp4rUWQFpy/kNrmXQpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927690; c=relaxed/simple;
	bh=M1YaStAogQyTdv2OIRtYBZsMgguLW0Oh8sw4j8m4+vQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BYmmbq8yXG100vVbO8UsMoCqBZ6KhHjzt4VUWtgFpQ4OeK09yplCasnqjQ+l89qqODZBpThW3R+z+EpLnB8UU2+fwhmlsAmXrPq9uYZu6XzHIGjlONg8YesvycEO6zq0LnyJBZbERm0nSkkyVBhkm/hf8E1oYKXBDAX31YLqNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBOFS7SP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBOFS7SP"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4774d68c670so22804691cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742927687; x=1743532487; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=omKhWz/JWSzPkuoN5cJ0v/KyHct4w419R0htuEXQW0Y=;
        b=CBOFS7SPhYsLPw/77uLfYRsLsiYEcqB7b704DNe7G0ZAwAUfkrzXei/1pIw/azD3yU
         8JkmZMViIOZcqvsidfVJAE7PVmylF0M9fCXTpSHFee7as4+YhFMbQlWQyX0/+vMP/K7o
         gnp+Wvn5QpJzB1JqxJRTJrVOsg0cbe6ShLMnEEPwmrbfnq/+aCoV79TrF3FOVrK/CLTR
         tlLb8qZP8TDjzqxzaabsnPdwKk/GySYc+ns2RaXk5SnsTctTdXbnPl7d1hwEdZBGjlRE
         4rDOgLQFPC6pEc7KwogIQa5uSsEbxXS3pd/WiDwx9vQ3DaCHHEV5Eh4Hx1JN+mNW6f/3
         mJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927687; x=1743532487;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omKhWz/JWSzPkuoN5cJ0v/KyHct4w419R0htuEXQW0Y=;
        b=I+GGDBT/m99itzAOS+YxONTtXBsaN4QruBjBMS3H71p8fi8nHXyYTydYxMTweloyqE
         pXKJyypfvVg7EpKr1IIdbD7m3iSP/bkLvEuhUPtjcPQQb52A5ma5EcJJA4o6JTHtfGYb
         77IbUGZtGfnp3lgfxrfr9AF0Dnho8iyCRoS5G1jWo1XDbjGshd99Wot04fsJDxHfrbgm
         /i3cxA+FohJ4s/uFKE3Ss364lr/l8vrib5jNGSoT7eyMZcISjSbNZ1Y7P095rNq5QJCj
         t6n/y9Bv60gx6dhmU29jUjrDlUvZqVOvuT46hI7q4ncx1stT1hnM/mSUzK9T+XcdLBPL
         xvew==
X-Gm-Message-State: AOJu0Yyefs/7TWctWz0kSAe2Ku4JHtLAohELNsgqYR1lLukUdLQFdb1H
	VK3HOpijvt/9VYMoQBwdZurb6bisWVMGtX9i0Dy/G7DUpXVVKgfxHw4R6A==
X-Gm-Gg: ASbGncs4CrM6IaaKFzV7He671oKHDahSouly4gZXDIM9ypDKfXP5ebWYF0vVJg9P3NL
	/XDCCu6THXIXj1k7TAa4WiOeVJwNMWNYB2v6EQQeb9aHz7rxCvQQRxSfFywUziLlK6CsgV6c1wM
	oVyOvxKWimetNXI8u3fAUH4cmSmoe+39TinqlcC6o86cpOGCHhz4BpFMAEYmT9+Q6FAJoCvW8Ob
	5wS6gjhT8m2OtGYTUYuhFpyWLLHfYN8H3slyxPo4W7vyd12pvnpjO/STZ/ZM6UFMEEnZxFOl+0h
	8z+LQDXBdBQrLSpsgum+zTQMuLaqetUej5N6X1M6jxxm7OynYCf+XQ==
X-Google-Smtp-Source: AGHT+IEgS/Yo+yd3SYR69urEXCVj8xaLNBuDIPPs+iO/4ECWxCz8MFNnAp7OxXvoZF7vLsxA0ka/KA==
X-Received: by 2002:a05:622a:5814:b0:476:884e:52ee with SMTP id d75a77b69052e-4771dd60828mr306389221cf.11.1742927687242;
        Tue, 25 Mar 2025 11:34:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.174.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51fd76sm62224301cf.57.2025.03.25.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:34:46 -0700 (PDT)
Message-ID: <67e2f746.050a0220.2eeec3.af19@mx.google.com>
Date: Tue, 25 Mar 2025 11:34:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2247561705451954313=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ludovico.denittis@collabora.com
Subject: RE: Fix wake_allowed reported error and not being set after pairing
In-Reply-To: <20250325172846.139431-2-ludovico.denittis@collabora.com>
References: <20250325172846.139431-2-ludovico.denittis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2247561705451954313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=947245

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.76 seconds
BluezMake                     PASS      1503.05 seconds
MakeCheck                     PASS      13.63 seconds
MakeDistcheck                 PASS      171.29 seconds
CheckValgrind                 PASS      225.50 seconds
CheckSmatch                   PASS      307.78 seconds
bluezmakeextell               PASS      98.94 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      876.53 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2247561705451954313==--
