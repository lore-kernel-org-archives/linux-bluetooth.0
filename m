Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0B13D503
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549737; cv=none; b=ms3eUdHxDOFb8p7mdMxA2O0cgIxfQ9e4Hvfx7SPvkEXGFUu2fIxXlwUahZydCg1A8mJ7104u/D2jN0IK7l8PsZO/J3emIlAeXzdbU7nQ1tAv/Omw+1dnQCrjIyK7+3b8j3oz8Y19k0q9/kJOKhFJ10fzXd8FFDQGATUoRDrVAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549737; c=relaxed/simple;
	bh=NqGq7Q+eNvOEy1C+hpukkl8BXnsvP91qZ8Bm8sYQLfo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B8NaRJpJRnDlnqmUHTpA8+w9gIzbDipjE5T4LDNxz9Ub5ZEEb6Ii98es0U6XCQXz5gHfQqjOjjES5BkAlvFvXwNV+TAdOouGWNarpqZ8qMN0rMePlM4hGs9VtpMzAezwNAsvPft6KoAZj1xvZi1g3Vs3XhzBKKuis761RaUbSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6HkFDKR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6HkFDKR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-87808473c3bso1245144785a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760549734; x=1761154534; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=55QHKyFqz8qUubV6xLIgfNAdGF4CoPxNJVik8fEPZZQ=;
        b=Z6HkFDKRUk7BcGZybTkKntA9T4qQEXbXnnAoEeRybgcxXyLR5IrXKTb05/xjh97/67
         RAIoF2xr43j9sTAK5x3p+w4wp23UnyqUlvM4QfS2AgWpB/AIeJTzoygIi22V0gnQ1Gb9
         K6iIEq8KXHXJqym9UIfkIWKzEshD2p653qpbqJ/GIzRXHYt6YUt73zKTPZi5Zb024fF9
         y7dcbTWzBYtyNFObkT3aSOns/m0f8l/WuDAc/4gI5PswrTgMw+t136ZEqM4dZeb6BDdE
         Y/CbajZAStdYPNDapLf345feyLhASsgV/S6Ipa6L6oyC7+GLXcf4N8sZF+JxB04rqDD6
         YiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760549734; x=1761154534;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55QHKyFqz8qUubV6xLIgfNAdGF4CoPxNJVik8fEPZZQ=;
        b=sA/ZajcjPm4xCDpj7ZRfHfJRh/+gQShJl2ZCT7QXta7/MLeR0z0QCRCPmKq0Zm5SHM
         G2t1x8ZU/h3hB78mJvDqWSCoBB9Ra0QEM5CpxnX7lUCtkpBz2H+lONMlBBm3bNa4I2fR
         O+N+itAL8HkzNk2fsiVKpq57E9N2jL9KbauWIBvUl1NtArQHUjtWQAVLX4W4eDprJbnS
         ZOsSunTlzbgP8iKdPhViQrFovc6/Mrw6ZKGpSfmO0ZYbcfstu6Xgk6yVo/Z1/ZJTp9o6
         rg2NBzYd4slbN5bXyA1TklWo/Z9wknDA1JCACzsE23dfhm9/ufbGJaMMEW7bRuwyWXvZ
         o3Fg==
X-Gm-Message-State: AOJu0YwVHgk2MNJG30LDHy0M+VLqgCYhvjlWUuYxSeITqaPwJfo8UqQ3
	t7xgQ3jJ6aJnY63KuZN92d4E21eITv6XkVzwSK7cbUhyF6NQ57knLOJAZLr7bA==
X-Gm-Gg: ASbGncuRxIHQtAj0uXyD6+F7XnIm+1Iw6E1kYdOTU2ljBv1mL8godzu/9YfgWyixCcq
	YaxYZj1m2yHHCjy4OMeE15oeDoauuQg7mufIHMsLeDA2ksOsuOftW+E6J29vH8g5mOfOo6ETTwZ
	iSa2Y2edL/I25qSIMHmrUqHUB/KP4X2+jMXzcNSjMihByiHy1+T9C96NWdp6jxOcPvfbTzVZzk0
	w8T3RKtKoIFKvd/1sQCSTPpX1RujN9SbdmHtGBmC1qmjlAmPvaig5OXZ+Ak8AB6fleYXOtiqL5q
	/mtsaYqecrLT0McG9zPXQtW2KqcfyedgS3NNHCnRCTjnpZWDDg8dcwoGSutZERa/QU3QfmcYe1o
	Ei1/x9zHxV00mZ/s13UxKxAJ/qez9Y7jblAJdBO3tkXJjHQ==
X-Google-Smtp-Source: AGHT+IFkCDhW8qfZbHxip3B0Bu7nQtJyLYneY9uf5PH8LjzobgFrHbX2d2tZRPJMI7nRMa/nKjG8qg==
X-Received: by 2002:a05:622a:1f0a:b0:4d3:3ecd:efd0 with SMTP id d75a77b69052e-4e6eaccf9e8mr426196151cf.6.1760549734377;
        Wed, 15 Oct 2025 10:35:34 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.173.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881d1753esm22991141cf.30.2025.10.15.10.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 10:35:33 -0700 (PDT)
Message-ID: <68efdb65.050a0220.2fbbd1.736d@mx.google.com>
Date: Wed, 15 Oct 2025 10:35:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3869817852332331284=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] bap: tolerate inverted STREAMING and iso_connect_cb()
In-Reply-To: <d442c20f47eb10f51c19480988964e881f6b0049.1760542606.git.pav@iki.fi>
References: <d442c20f47eb10f51c19480988964e881f6b0049.1760542606.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3869817852332331284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1011959

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.84 seconds
BuildEll                      PASS      21.40 seconds
BluezMake                     PASS      4532.07 seconds
MakeCheck                     PASS      21.63 seconds
MakeDistcheck                 PASS      196.56 seconds
CheckValgrind                 PASS      256.43 seconds
CheckSmatch                   PASS      326.57 seconds
bluezmakeextell               PASS      138.99 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      1004.61 seconds

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


--===============3869817852332331284==--
