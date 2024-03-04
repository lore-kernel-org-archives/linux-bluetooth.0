Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30145BFD
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566354; cv=none; b=BMVknF8KjJZBGggR75cskaIg9fRq7QrLFG2ptD4YSl092SGbX535ye73Sf79aNalaSOhOiY8CkPbOV4lTggJad2vcqvR3OcHwERkA7KCzSopJ9+iFUoRyUIPnNpFiiwwCyXkHTa3WqtZpsm03W+iM5GrhxkJWvEuFfNikXTJLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566354; c=relaxed/simple;
	bh=g4IzmiTzaRXtK4LCWwORjoNhp5x+mI0C/1J48Odtyc0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kUuj4mkbjGdrAAc8jOj83js6vq39lnbHakwGUhKOKn/y+iiMblXNAic8s64mlNDlm/VdueW9suIcsMTPU9XNAw0eRpLOrWzxunqiHU+kY/mWZDYIR4qWQlgBEczOoBEZ1VoRQ4I9j6BXSTGJOyyISbMSK9L9j7i2uOeW9ep0f3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQnVpHLe; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQnVpHLe"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42ee2012bf0so11155651cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 07:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709566352; x=1710171152; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ShI3eEzrNB/VlUT5a4AnSQnO239lyB2lWZqw3sOpxWc=;
        b=RQnVpHLedZg3xC+8IHeyzueOpn0iXIEnCPXrrkH2dLhwEBn0LWawY2jmYcYVldgm4l
         JTJ/TKEhB0sCmeBLL8CJYyGPg6vMI7Tf801EnX2AaKiXcFQ4F4mF4Cqbf6LngjWYMNRn
         3HnVAcrfeYP8Sx988p3TQPKjmdr7qYqfCEMvcrllLmdZ6uDJHVu8ZTt1OdeUpsfZZWEK
         OvP61qWuGt8c7ISV/ZbpoufsRdjZLiTwh0bmURZB6Lyx5YEeupbT12wFKHU9mglHiNUZ
         go7buvOn3r9Hfb615urOCa50apqmaAbnsWnk2tYBOF6E8PjfI0SDIsqQ0oGaTJpCCv7g
         xIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566352; x=1710171152;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShI3eEzrNB/VlUT5a4AnSQnO239lyB2lWZqw3sOpxWc=;
        b=RiGZbJKCf9e6hCzbkzRSMU9Q4XgMnX8exAAci5zUplDPYh3QLpWZ2jVR/QF7lDEFzb
         8eBDksEUF8miaHTttovjycEY94limA6nCD/cX6oCY9Qh5JA39+Dkkm2Rny8KnkGbs8CR
         jtMZs52cRX700egR6CmTT2aMXRf+fPttrOYxVOgecn6WJIQmSGqY+cYTKtCJ2SkvE1jZ
         9gOqDV82e/ZpieqJPZ04n4WRSgY3CfJOBo1MQwIPJ9ftgk11OkPlmkBnXJoyWz7G6VL6
         K9N+3iah5xSnq9MmkbjSjhVy5HlaksAUkFEFOS2qkxkPZCFFUA9Z6V97ifsIHfNmmABL
         jsFA==
X-Gm-Message-State: AOJu0YzdHX3Kw/10sF76Dc9vv6uME0SeRlHIxOPnc0W4bbGUkHx41nWc
	EJvbTNyMVcpS6z1PH0s3eOlIFu9tMuIXs0S/tBpPb2sDyoO85rV6Zze1k98P
X-Google-Smtp-Source: AGHT+IFzvnCOLAFBfmY8uW/vnjF/uKeLkV9Ep7b5N8pvJWaTkV29cF/omRwTYOtkw3e5k8vLU01nIA==
X-Received: by 2002:a05:622a:291:b0:42e:f759:df80 with SMTP id z17-20020a05622a029100b0042ef759df80mr2454491qtw.29.1709566352001;
        Mon, 04 Mar 2024 07:32:32 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.161])
        by smtp.gmail.com with ESMTPSA id g8-20020ac84dc8000000b0042eed783365sm1376791qtw.40.2024.03.04.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:32:31 -0800 (PST)
Message-ID: <65e5e98f.c80a0220.ece93.3f2b@mx.google.com>
Date: Mon, 04 Mar 2024 07:32:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3015693898021189940=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mg@max.gautier.name
Subject: RE: [BlueZ] Don't install conf and state dir on systemd
In-Reply-To: <20240304142200.69968-1-mg@max.gautier.name>
References: <20240304142200.69968-1-mg@max.gautier.name>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3015693898021189940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832119

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      25.01 seconds
BluezMake                     PASS      725.21 seconds
MakeCheck                     PASS      11.83 seconds
MakeDistcheck                 PASS      166.95 seconds
CheckValgrind                 PASS      229.44 seconds
CheckSmatch                   PASS      340.07 seconds
bluezmakeextell               PASS      109.26 seconds
IncrementalBuild              PASS      670.91 seconds
ScanBuild                     PASS      965.73 seconds



---
Regards,
Linux Bluetooth


--===============3015693898021189940==--
