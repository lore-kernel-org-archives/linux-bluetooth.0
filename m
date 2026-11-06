Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002805;
	b=i6qH285mprZGBl79vetvsbaWU2i5KMbLyj3ZEpzcSvc721763eVe7LS2s9bayG++tGmR
	 sWvQZCL3HGkeBI/G17fpXkYO3in9HBjunqTQx90W+1JtLpDK7CeoXy46MSyRLbmykIWJw
	 mhMrHyGdOJM3VNjv0aZ6BdwitI+ZietzemFU8inWFJVjNinexiAXtPAhpPf2nW2f7/yAH
	 L970GCSJEuCQ7kn87hbrBZ5kVhY9i0U0WFRKI2WJ8eE9jfaqOhbwNbPyH3dzbRVkGccB5
	 GyRA2vK5+mPwQx4uiGHPrjmyIAaJvKmjba3fvKsBYAiP8cnb8N0OihFRkIPgERLq16A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=gNFyHidSBjOvEroUEgKRH+yt7vP+L3fyp8/3750pbdE=;
	b=Zv9pw1/Z1BdJbsh4WH3LUyISmhvU8U5Z1COuyMRF5nauiwXDbl24ejw3fL4FUsPiNber
	 zG9p6xnrMZktcSMvnzrcsoBOX4p17+Yk1XIxMqZM0AQ+JwJ07icoL9xxW84HC46/0JNff
	 gBZuz0L+jpVdDSHdT4DRYcSGp7stqVkRisRG6jaXC2HLsqGNl9o6jLBh1oyD2thwyrNQy
	 wLMSyn7SYBpQiUuiR/DzyQzceHv4yOySlpWafYqesFaTAIw4LI5GaAt4brwVpKGVXxnA1
	 xF+W4KN1EyC/dFk3U+2LHo+WXtvzUjQRnF9xcN0qBULhLCVL9GgCoSU0FZjY2cAHTHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W8Cgk+qq;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FED606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 22:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2FED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W8Cgk+qq
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso11806206d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 14:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794002804; x=1794607604; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gNFyHidSBjOvEroUEgKRH+yt7vP+L3fyp8/3750pbdE=;
        b=W8Cgk+qq9rd0LZGW5QkXXU7D3Qhn+VB32Snpc/bpGEom3uZoRyfwlWd7sumWwvIeKu
         fR3HycCbF63GCrr5FSi/dq0FZa3vo6NokJjD2Rwz9wI4OHNI5bwQ/JbNga7XRNzwstbP
         RM8KRpAamtcDzCCpMcSyNoKAs15C9LMUGhNPDcfGRrdQGqERWnT3kRJLCSTAEewCrfay
         Ja3oLZKye6ZgmtEmB+OaP+kLWgt+QT7ErabnqJH4JpJ6N/0P+BinojZj/2GQGNYnMom+
         MAgq0XkD9JKllNf59nFOqKlkbQorQ/jpIv6vvj8LScEyyPYtP5PWyx6flfBDUXgvNUdJ
         qbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794002804; x=1794607604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gNFyHidSBjOvEroUEgKRH+yt7vP+L3fyp8/3750pbdE=;
        b=AGyvXxa7dWS1rbjNFvI3hY0nIt0R5jInlEsAW4yrxSj2RDSRiafKCTgGetgX3xTX2z
         K7sVxvS7QEQv5D32OKy7uCownF8vnWvkf5sAsJm4gKX0aYmZ880POscaGWzy/Ig3IXpi
         gENV+Wk56mUFGQUNOGLwcew2yke+khLE/PP+bICU++IPmxfyL7dtW+LBM7z5T3F8TaQT
         1aibQrVxCKLSIo+X+q2cGGEBNfWVqzTTqnppba7HrvMd8RbW3avnQP97e8TGL5s3G0MG
         cvoVpuTaICoc8UBWP77iuj0rraUP3a1JalZEVGP9BStH5lia3Wutu21JLN/wSlKfi6ZF
         OWvA==
X-Gm-Message-State: APuU4Z/en+TmNpO0Q/NPmjSF9DEwzCeByP2qA91D0dG0ADIITh442Twp
	hKJEevwKFlXIZezgQUp3NympVMDD5I2TvwqE643rPL4snD9ZT6ra6pNDacskhA==
X-Gm-Gg: AYBFou1AcgNro/uGoqwM01LuBHdltzTO8XACbvRqt7iS9yjKwUL58X4QfQjQjjbbbXJ
	bEJw48UXXbCJofKjEc+EP+L4AOBOFRYHbbIrrS4ozAfacYBqref2Hau2Dspvj5Bk1zU+rYgfT2R
	PzuH4OM8F4jSJz/d+LOQlZSgtIXv1r1pfqy5KpDOLPk+mqzOuxvqRjOK0C7Q/wugCQlV3c9rnus
	fxjPhmPtDgod/PnNbUAZqsCxG1rXqEyHgIEB+cBeebWgZCu/1Q9NKVhSmeZ2Z+1aoOaInPttXM5
	gulltxYkRZKtROY7kqDHc0RWdrFGov6Mv/sPUa3djOTF7cGL6Y4jSMbSFQaU5XPtR7ioSVXKAUC
	0vbpvM9gE8VCrhEdbL4qwcKZpxP/xvorZN1m/Hj+Vo9kSpFY0Zfpqt1ykzgt7pCbKubkMpPDuz9
	oK4uZXiy1FXf4PKC0bDEfpUEhqevnHQwOvRmdtxxvQgkrW+bFCYf7kXDlltvOQflsiBrHGBXjLS
	Ku+Ab5YX5YTlXuSmlMK4BgIpj0zUMGTj2354T7lUIEvW9kL0XcpkfZkJENAUg==
X-Received: by 2002:a05:6214:5293:b0:91c:7f1f:2c9e with SMTP id 6a1803df08f44-91ea9888d8bmr55075526d6.55.1794002803944;
        Fri, 06 Nov 2026 14:06:43 -0800 (PST)
Received: from [172.17.0.2] ([20.119.95.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a86032sm29823516d6.31.2026.11.06.14.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:06:42 -0800 (PST)
Message-ID: <6aee4f72.2a17771f.7d6d2.5b42@mx.google.com>
Date: Fri, 06 Nov 2026 14:06:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8980928046657420858=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Run the testers under User Mode Linux with time travel
In-Reply-To: <20261022154701.3959500-2-luiz.dentz@gmail.com>
References: <20261022154701.3959500-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8980928046657420858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Run the testers under User Mode Linux with time travel
   Pull Request: https://github.com/bluez/bluez/pull/2701
   Created:      2026-10-22 18:51:57+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8980928046657420858==--
