Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741931282C
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934080; cv=none; b=rPp31+Gfroz+c1qb+MOS3aKl1c++CbRG1KaG76TFZUANa9zLI1SWr4XdyxWtFVnH1VLI5D+pD2MSEN11H+gfz0ft2jvndtvu05EedFgzZVYLSfgsw44QdG85iOR61N/XhxOJaT8dDZHHKQvKEXnIX05vtg57ihM+jrHXCfyTINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934080; c=relaxed/simple;
	bh=unZ2wD2n1Z+0k3Ev7pvzc5GI6U5c10yiKs9ndSac7oo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=du8W606biwDV12hIvDvIFT2i4R48kANH50TP+1lvbSXga+E3H2TkWy5QW2jV0FKH1MIdLKJsQSDUvsR/4r5W8i9nfdfEZLBSd7sT9H4l+MxB6M3dfrhhrFEITFVsnMo2qN92AGYQJXUaIRnFgTeVK8S2Hyrf9eNFBG+5xx2P5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItaHQAXz; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItaHQAXz"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso64779206d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780934078; x=1781538878; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G1Su5HpiWBFFSFWIVkZE9/7eYV7QK7qkO7IAJ8+mRBg=;
        b=ItaHQAXzABFg5ubRZYeTr6k1MaZPXpmv8VOE3ewEEW1zaVbcOgtZACvLazItqYTH1b
         Jhjg1/zTu4fyrkTx0qZd24kFee2jr9d+S6ULPSUMqDUQi4i1uDs6PPpQ863j62czE74M
         lyiVPvZyV/2ej2KMicxlkGdv97DDDJtfSw4ylayHobWbVZjtDpUFLYodO3JxHfkuu23q
         ZVkyXaGJW9bNTasSXHWvJBV4jKkl4aKy0sGuvkVwUbB56cIBWsI6m7eLCPXVkzhFoMbl
         KWmSkmiACQpab/3UA+3yBnfET8+AEGcJFVuca4jQQV68aBvgDc8JfOfzKOIBat6uZixp
         cohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934078; x=1781538878;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1Su5HpiWBFFSFWIVkZE9/7eYV7QK7qkO7IAJ8+mRBg=;
        b=Goq2YebPg2O3AFuyiLZj+f0duLyMG1fclW0hShBtCknSMH5ABEE7jkJCMPeoFpOxwT
         4/rjleYXuDANMo84xCz5H6+k9HBsJ7YP9dsXd3rVj2OzLrbfJKTEnnnENUuRm+fzBI+j
         9443WbkEAjOolZnkYwFW1ZuZJ80c6DFq/+bZpmI9yYl6AFd32mLJT2MgfCvU6DTNkvMd
         9RhTzoRboWwCYdPe2DIUJIBvsx/DVri14XmQAZarUWBbBCgct9xV/K5k3w7DeiXZcnnS
         t4n/voABpnqS6OD0fcH0liVjGvVzd2Tj597bFR2Z9mE+ShquOZ3z3fQhxaCx4XWi/Cnj
         hmrA==
X-Gm-Message-State: AOJu0YyxYnY8ZDxc1bBUSMWpG2JWL4JwjtlSk8amC9VoDongLnxSODwR
	33UWHRbnrpoN2mGiKLpPc1046xM3RK5yOKPKlGYNxPzarhY5Z2d+aUDW1GQ2Gg==
X-Gm-Gg: Acq92OEZHcxRdl2+YaJhFG/3ZyJdJVuHotVCzpHIDn1o/u3rEKt/QOsUf8B74RpxICH
	M9j1XDy4X09Bivuxe2qeDBhKw+ASC7Xi1mgiDMP4OE1DUOykYQA1vxz/GK29GXJC98hYJIJcpVt
	G2lFj6YssNyAkIPRWco9/Yx2lP4T9+rjGfrBPabBqBUHf6qv/L0EkM87N4Ui5IdVLok0NswlNML
	9va1kOTQBVlLpxxccVbMzEv7+A8cO9omw9NkN3PAPKzbYMtQMHJ3nDDj149uj9UbdOGchkfpaGf
	VpdG37Eggd1zhzBqAPz4qUoJvSEM57QLusHEIHg0cbb0HO8k1qWKYrpueVvpPx/YN2yvJLVVOSo
	huxTDGbGuVZrOPxlKy34mBHe5xnB4wtJ0GM4/VZSXkbjQyFbCs6YdtKwJYIN2kt2GxEaVsCwsSO
	vTOiEM7czT1WTeHFPJHdd8riYmRXH8O5N6dmzBIeNBLuyFfLKhtw==
X-Received: by 2002:a05:6214:10ec:b0:8cc:d165:7ee0 with SMTP id 6a1803df08f44-8cee5fb6e29mr215699606d6.11.1780934077626;
        Mon, 08 Jun 2026 08:54:37 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.79.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd051d61sm168745406d6.29.2026.06.08.08.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:54:37 -0700 (PDT)
Message-ID: <6a26e5bd.9338f4ca.20ce1.ad21@mx.google.com>
Date: Mon, 08 Jun 2026 08:54:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1111034712562333007=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,1/2] avdtp: Add GetConfiguration DBus function
In-Reply-To: <20260608121226.3727101-1-simon.mikuda@streamunlimited.com>
References: <20260608121226.3727101-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1111034712562333007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107804

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      21.01 seconds
BluezMake                     PASS      661.73 seconds
MakeCheck                     PASS      18.56 seconds
MakeDistcheck                 PASS      246.15 seconds
CheckValgrind                 PASS      291.39 seconds
CheckSmatch                   PASS      357.14 seconds
bluezmakeextell               PASS      182.97 seconds
IncrementalBuild              PASS      661.73 seconds
ScanBuild                     PASS      1030.26 seconds



https://github.com/bluez/bluez/pull/2193

---
Regards,
Linux Bluetooth


--===============1111034712562333007==--
