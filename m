Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA025202F70
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994378; cv=none; b=QeXJQSVf3Z7Ly8XRyr2o4zcLa2xA8tHD6EReQeUvVlU6BbNLWAeEbilXLNj9O9fjDFNhU1RCDL+3JVDYtX0KDzwK6j+lyBuCfilkccD3mJwWs1yhAl8ecQ5MRSaGEA5Jn2ZabIf8vfaKfJrrgCSudfivwRxEt2lMZ4rPeFHAFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994378; c=relaxed/simple;
	bh=AwMpIxf2AcbSUkyeSCpwg4xuvPl6yqP1MzlQ2V17FKI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kQnaFwY+EZ+MhN4k4XrUO9Eh0DKAhUechH/a1GPQ3CZMba8d8+BWoAKbJxcQ7qERhPLUON3cDW8HFcRnHu/ChQZxRgT/uBsP5BhI0x4SQv5tlCzYOKfjQnvQ84tIFWC9tJITLdji2fS5XDDWR5p89eJKBTwkEg+zdFMxm3DJm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKSX3lOe; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKSX3lOe"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fa980d05a8so50920596d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751994375; x=1752599175; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dMMkre+flPgnOSbTgqIZD/m5fi21pOVefxW9k0h4iNs=;
        b=NKSX3lOeWrMjO+MbDi/7bgkfjicjEgAjTCO4r4hA3IO76w19JyBLWOs8S+nto6M/E4
         EhYwGQeE4brKXkle8yqEHjSO8tDof7G+Mb9kH9al/VAOlOwQk4XwvM6QH7x+EVKByPKI
         QOSzqCMbD9u7u3WEy6PzC3zabuogaPxGIEHbkoDRscS0oER1MO3Gqi6z8L97w46DvWty
         n7aJcsr35pG2KvMVRr0E81Wf18+1Op5XkpdFQQ2bg6w268XnucZc6mnF6dztjx03uNN2
         mSSAOwFaH8Yg7GhT7NeXQn8nejOXEEVOp91V+RJ4DtS8jjDfIq629kqrP8Lj0I/uqOCg
         JNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751994375; x=1752599175;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMMkre+flPgnOSbTgqIZD/m5fi21pOVefxW9k0h4iNs=;
        b=Ddua1rypj+z8FcXXpQ2SAVYhBGapG4ztNKy+FRXWtiy5thl4Whk9eBrq0HBIt7xach
         zKOYtOY+pefDICrMMkmNdtWYUyaq3mX4hePnHGFTTpOtbv5wA6Gb7sV/nBRRzDGKeYet
         vjjWNwWTebN4oVFt6naBTkGMcHeZNd0Rb4AQm0wyew1+rU4jZcLR6c+8bi5zP1dzvLts
         y+QM+U49BZRm3Pp0+toCl02TC+EAVKDESX3gGQ6WqroOddOG1m7TblUM6vqVsA/miZjA
         4Gn52HOQad+noDSwtf1GS4vOZ/a8coVA6aIjCxgqBzRFElW7wiQhgij74JKd5len8Wgo
         OscQ==
X-Gm-Message-State: AOJu0YwsG21a2XwdVs3VHH6xedoTk62t7Zx/p7Cut0cvTjE1eM0f5H+9
	cIa/ErJhgjXZKntljWUZKJWGgTqA/N05EJwOGS1acQZ5xBvDvrKGnDXNpSfZng==
X-Gm-Gg: ASbGncsCkmO1PEHfKb83dtwQ8cOKT+yYmmrKmxJGz5iFRFR+ihT2w6wqFKVZaiMozJt
	YKV25GpHmCSjAWnNRM+PJ87ioTB4ADUniSIF2y60AY5n7qWgtRuoqsDvB81JZ0DYD4Au1E4BVx1
	zpukH/Os07doMLREcvChJdqR2x5ABwantT3ISDmLZ1LL9FXrwmESI2eDuI29/YxH6ijqJJ4BMZl
	APyfd5TBX9IQWlCMkbfZ2+YYVH5gT/GNjv70CaC9eyqbWcxYONgj3NzvmVxD947J4tAuNNNYvBL
	x6kEVHfEOl30FdBrqoZ/qE+YRW61OWacknIfNGLa0KbqQ2G7atOm9x08vasiEdU3Jj+9Mjk=
X-Google-Smtp-Source: AGHT+IFS8A2pr4PW9jERKpsESWX2LhSuIe5cDZ8DjqWDsZieUeKxbPrJthJjtrAfv1kOJGDf+DN9MA==
X-Received: by 2002:a05:6214:21c2:b0:702:d6e2:3894 with SMTP id 6a1803df08f44-7047d92c809mr56396516d6.9.1751994375264;
        Tue, 08 Jul 2025 10:06:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.159.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeb6813sm805790385a.108.2025.07.08.10.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:06:14 -0700 (PDT)
Message-ID: <686d5006.050a0220.288e65.f6e6@mx.google.com>
Date: Tue, 08 Jul 2025 10:06:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5873841061598106340=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: audio/avrcp: Fix crash with invalid UTF-8 item name
In-Reply-To: <20250708154308.238963-2-frederic.danis@collabora.com>
References: <20250708154308.238963-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5873841061598106340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980101

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      2694.75 seconds
MakeCheck                     PASS      19.84 seconds
MakeDistcheck                 PASS      186.45 seconds
CheckValgrind                 PASS      236.95 seconds
CheckSmatch                   PASS      306.32 seconds
bluezmakeextell               PASS      127.72 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      915.07 seconds

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


--===============5873841061598106340==--
