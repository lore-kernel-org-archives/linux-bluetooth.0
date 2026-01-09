Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AC33CEA8
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993803; cv=none; b=lMx+gW7oiP3d9rOAEurevZVHX/44ErlcjgWP/MnxyLWtSz4m8eKfa+vl6N955ObuX1lvOfRFgHa95zn63hK3f7lQNhvrBFB7G45S60y/U0+pCHYkFKGmRBrJI/unZvVYv/lqLPZ0Jq0zAAgFPW1igo1VG4kM2OsBMpqmHkc4jDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993803; c=relaxed/simple;
	bh=g8xqWgckZWczptb4bWaPnl/ffY50trJOWD2gzNGm1wA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BkHQd6TQfJm4kE+3lrS52K5VlyFmD3BOPDVpUv71HBwELiC8h/8t+92gymdtTlCxxzDf4LEeN//C5kMp/gcq2gZwAkiabvMtEdSi8L1Kj4JBBKKeqE03FgS+wgpF53bkapmOHXSkogCxm5q8cBpT3OIPPLOLD+uGwqgSDItZLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvxFbzCS; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvxFbzCS"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2d32b9777so681957385a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jan 2026 13:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767993800; x=1768598600; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=35GqRQWyktBDONBfpjgf2APwpX5jYmCwXrFj3nCD0Fg=;
        b=bvxFbzCSpjl95Rkn1mfBYC+BdfilA2UagJWXQ8E79Nl3yP3/0I1BVtmuUKJjvdLbVD
         OlEuPUHJePOOgAoygWcuUzhdaSxVdRhavu6RroIwHQKK58lQvK8pIkqAmIl4K4GEYg++
         UpZurMgIrykI4b/BO7X+1w8elNxJsLuRRzJGL4tMHqMG/q8q6LO2pWRmFGlhgxXyygoQ
         qyE8Oy6ttWkpmCPNaXmYYV4LQqnUp1VkC8ayA44i63RpQO60BzRMZVpOEySTnUAQ6D7e
         gzJSw51d8174Uh8iK1fvgE4fxZDrt0TodCgtmmPlolloL5+wKBks6y697qkS/V3X8L3d
         RaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767993800; x=1768598600;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35GqRQWyktBDONBfpjgf2APwpX5jYmCwXrFj3nCD0Fg=;
        b=TFK7BtNX/19hWeF+SPUKWf2wHAyYVrVFwTbLO0JoY7DtMzPM2wvSuXemi+tvGRNupW
         c2502YAIpwcvWHUQUeRG4mkkpjLm9mLWucY/zOzqLf2vJTjzWWEvku/TYfT+up7C5sj9
         rfX3/2KgNsn3jrqyITsAXgv5eKQjkBwDuBWMrdmuCb/zOjKiTIdRl33qZ7NxUYwgqBUW
         BC4JsYqAs40HKh7cdoEzpeorDwqT5oh6jYhI5/sjThpvLFJOsq3j72mNj9QA+g0PClyj
         89MHIcaD6A8NPZjz17Jv8n35MtQikPjEm6dZEApwemsv8DeGfnIWqK4V/OG+jPg2eWIM
         OgGQ==
X-Gm-Message-State: AOJu0YzPrb5szmgLkJ+vAVnHn5zP6OFKDOl8/t0PxROqtS2iaqd35EJc
	opGShbXH4qCnOHBCxvsFBgzN3u6271vkdQCPYJ6TzHnZb2M8EUTjLr9U7KTDlKLf
X-Gm-Gg: AY/fxX7xNIvPqmn+PkdWB4mM39Pi/wHPr2gW2vsmQyu5hHOdJzrmUPyaEKZ5HhwR9AE
	h31aAkhJse9pl+SjzS+6Z9V4XLhFgvps5bt0vyA43sMUAweV7OJtndvzLELeh05ngc3QhciWFQe
	1xY/KnC5OpqjzS/Ju+r/q+XpOiw1/dYwVfR9Vx6a9Yx0z1UA8Y0SFnyjs4USjukjGX8npeVnObK
	oxad38nUeqSnI/tYJ8icGIuCmYG2ujMimeE+iVjt3v6keboMCtLFlbm4ZRTfaCJ4T5tbo88RaCb
	NigxxljjcFQGQ7F93vhORvjnUm0YTxCdAQ2KqjaPCNiB7xQSVKR5BQJjKr3DBmKnnRe408sk48t
	UuYsMa+SA9S2+MGmwVzEqUUMFWrXVwVDGL4xLal83DtbtpuzWW3DQX3Tr2v9Mg3gbJeYh9+Gx/g
	ELEmOmEu4p1jwmoSbdjw==
X-Google-Smtp-Source: AGHT+IGWiFmdmkBkFbjQAaGQutEj1wzWwR0wN1arbL6hKGczg9V/eq0ZLWNoCuvNA3NoVLf1nKsxnw==
X-Received: by 2002:a05:620a:4503:b0:891:cc30:1018 with SMTP id af79cd13be357-8c389416e7amr1529808085a.71.1767993800307;
        Fri, 09 Jan 2026 13:23:20 -0800 (PST)
Received: from [172.17.0.2] ([172.183.132.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a97fesm894921885a.4.2026.01.09.13.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:23:19 -0800 (PST)
Message-ID: <696171c7.e90a0220.2739a3.b77a@mx.google.com>
Date: Fri, 09 Jan 2026 13:23:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4552325150014944677=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dalegaard@gmail.com
Subject: RE: [v2] gatt-client: prevent use-after-free when clients disconnect
In-Reply-To: <20260109202925.774809-4-dalegaard@gmail.com>
References: <20260109202925.774809-4-dalegaard@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4552325150014944677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1040618

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      18.28 seconds
BluezMake                     PASS      637.05 seconds
MakeCheck                     PASS      22.06 seconds
MakeDistcheck                 PASS      221.04 seconds
CheckValgrind                 PASS      289.24 seconds
CheckSmatch                   PASS      313.20 seconds
bluezmakeextell               PASS      167.38 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      912.45 seconds

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


--===============4552325150014944677==--
