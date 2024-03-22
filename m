Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778425674C
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125656; cv=none; b=MY9TSSAybMBTzcqDOk8Nd4qGTJ+6HTiCR2qs/goexHqZ8DGs+Aq1qDler+4qhpYiiaJgBBjdouNzUpCSZsANwd98SaKI8Rhs8bkyrMybF4Nh97cy768yAFeX+DpCmZPdA5G5hklZtELAztCA9jEFJD4nbEIq0y5LoDKuLSBTH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125656; c=relaxed/simple;
	bh=iDGw6y67XOQ1Yl5EEXrcPsnRo4hH70IYTs2DtQwt19c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lKJrwS0oTqfcuw7snHZ4kq+DlZ4S7fnk9yhtxxfqZLEUOz/bdPr3sMTjvbGYxD9hviPy57WhHYhVECd71TY6qe2R4sYMeRTxKDd8hXMq+RmIRSTQb6IZMTio4X9nvVpqXUF2k2i/r+KxTT6f6+BYr9CjPUyUqrPU68+laCdb4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnQVrovR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnQVrovR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78a13117a3dso207159685a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711125654; x=1711730454; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A203k2xbTsBRBrrfzkZniuOXNcZbu3uvIQ0YCbWZJvQ=;
        b=mnQVrovRwbvUTWfdB9A/PnyiaUy+HMaFv/tVZHJQ3Y/8Jr6g44lTsJ0Z4RmMNGWBjm
         7v48URoV4WYhzQ1lWdNx6+vVUJTU3lS+b4AIjnMLYVYb9tI9bQF7YJWS1R6hGf/YiyMe
         2GYnHQy1pXwU6eIz8iLQSnfkDQbQtnKaRNHjvVBKLwQgNirNhNPzFMFH7M4TkFi4ldre
         fjnZdEvj0vnhgM2xNjjv38innWjd3RwN0rgAmXB6bF/3IMPoE64cTWSrkOyPlLB2WoEn
         7yM1Dxa56qh8eQzHEilIn1oZhWfluiTw7kFlrYeZgvypLhtBNBUvmXEeYyd+UTuTlK/J
         HTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125654; x=1711730454;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A203k2xbTsBRBrrfzkZniuOXNcZbu3uvIQ0YCbWZJvQ=;
        b=tZM1YpIqMpEjgF9PUS1qR+iyVzjufgEeT4Nbl62ikscigFjGKUm0Vp3cBhiCbOlszo
         2uz9anEkJAO3ydO8JzvV1sx/iIXnF3pu+lRr48VlqKdy6MdJCGHiZa+VOBV+fRyRWHcJ
         LVxnjtqg5pftTLOAooh5dJNQpuvRkMX2IDM0457h4ItY/EBGUngd4KUNxkfC9AYFmNZb
         39D2mIJIFnuEG8OJa1CEe79cQHCUIqrG8EA89kpgfgRd6BCRT35UmklwPosqp7gvPZff
         0+O6CR3tb/HEuLQJgydME6FYDztLrq3RTelWchsLy/CNCSf3LXGnaalvPaYJldZYI/Aw
         mFfg==
X-Gm-Message-State: AOJu0YzbMkH+LJDRibRpamRrTtTzjGFM9C8ybMD2hkU1sZ/KJ5CSV9B9
	WFKBFU3IINOhAYrOmrPXnP8JqG5QLB1JnzVZhh0D2m6o+q1zKrnWL7fOznOE
X-Google-Smtp-Source: AGHT+IFSdpz0eWQMfjaOmfrKmqAvkxmIKVOS5cJg5ruYSNH/Zey7IvR3RobyGNRfU0b+H1Qj+vMpyQ==
X-Received: by 2002:a05:620a:688c:b0:789:e7c6:8389 with SMTP id rv12-20020a05620a688c00b00789e7c68389mr4256015qkn.3.1711125654274;
        Fri, 22 Mar 2024 09:40:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.50])
        by smtp.gmail.com with ESMTPSA id z19-20020ae9c113000000b00789eb058e6fsm895532qki.117.2024.03.22.09.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:40:53 -0700 (PDT)
Message-ID: <65fdb495.e90a0220.42cd0.86cd@mx.google.com>
Date: Fri, 22 Mar 2024 09:40:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2464842952998654069=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ] avctp: Remove redundant UUID checks and additions
In-Reply-To: <20240322143830.1476938-1-xiaokeqinhealth@126.com>
References: <20240322143830.1476938-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2464842952998654069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837396

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.81 seconds
BluezMake                     PASS      1770.17 seconds
MakeCheck                     PASS      13.18 seconds
MakeDistcheck                 PASS      176.25 seconds
CheckValgrind                 PASS      244.12 seconds
CheckSmatch                   PASS      349.27 seconds
bluezmakeextell               PASS      120.00 seconds
IncrementalBuild              PASS      1522.33 seconds
ScanBuild                     PASS      999.12 seconds



---
Regards,
Linux Bluetooth


--===============2464842952998654069==--
