Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630813C9D4
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471764; cv=none; b=VgZM4mGqC7CpQztGaSgbYQuXo+4bnJLl8qsdYlYEFwIwOfwgYbDI075qZC/PgbMbPMo82xTIJoNvD4tPysqJHfBbqJZxq6aOm9wM7l/8I1cDgY5Jb2+R4mBMfmjJrxs4ngNDBj+ln5pHhGSBFCRMXiOnKnPXwzifIW+UboMEzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471764; c=relaxed/simple;
	bh=phdX5zGTkThp9R/B0e5gPRGS38HXymv/QyJ4MIfDvlw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GkMFZW6N6RiRJGuvJ26Wwa0kf0SnLnqP0GsJR6uGO+XRVyAo3ylkt95ch0pafmoUVWb/QvRejwY1htuUvyW7L4VNtgcYgSo8hNW2GXEUgxcfAg4q5Ui9dfd1h6AZWRHC8ZvmL/0sJ6mKjVV+RVZQnHGYcj6uXf8p2Mj5VkHk5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLNe3HH/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLNe3HH/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ea8d322297so2872055a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2024 10:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732471761; x=1733076561; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=03E6OYEpt3WmWy/mSDfs6pE7gCgEHMa/M8+lvKdIq70=;
        b=mLNe3HH/6fhFHOkaPGZCBMMlx4G//vbffZJjwzRyeSd3QbnVEW5w239N/Jzm8QtXZc
         lNaH9DatlcRujHAHK+OFN+9Cndq1TIAaYHfpKVBWLyTVI5XcyuOjITW4m1nbXlVrYw39
         dkQ0QK7bIWJTYQXwYo767Scsq+q7dudBe59N+tDyY7uzj319+Zy6VGzc8b3+WMZXdDJ9
         ARm9haxsoIqq8VotIiT0YeVsMLMANzKuARr0CjfeS2jgBVLwHMedeSuHqHlZAJOpFIb7
         Sm8ExuTl1ZRb0xKBzJVBfOK3AN61XrjGoPdHrXGgoiGS/HiyNo4KpjjvHVyXKzHGILTj
         QypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732471761; x=1733076561;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03E6OYEpt3WmWy/mSDfs6pE7gCgEHMa/M8+lvKdIq70=;
        b=H6kA/aAkZyanF0VFN9glhuZ1S11DSB/y3COE8YgpxoSPjdqBkdCv0PhhccUM5dp2lh
         PWfcefkkmlSg/4DGBmMX+w4eskVxeJvGMbNc7Qg8DcCB0fUb/Gf+nAvIwO0nEcqE9WXC
         KBx0DGjiU0BOKREjfhHkmfJYCTjPKdQm4gTZc7pfwJMo5yAz19rwqlO2k0X4R8OrcBey
         UrLfK1I1syxsw7vZKNoK7qq47M8yaSwSw3+jm8X6DtffmmMQS4tIU6myfSfR7ihQAlqS
         Qyfzi6LmvOzm3+mmBFFfHgbiotYXq5yBg1Yia6BAe8aBziy9Fiu/DxTxTW+ABrxcOaXG
         jUaw==
X-Gm-Message-State: AOJu0Ywrxn8+MKrd55yuSghIDksKaRQEl61aFgaIBZESyiQSuCOmUORa
	NqGh5ohm2LrxYLaYc9gV+OgUpwy4j68pNK2iNJ5PPTC2DhkKYdTzSmwbfw==
X-Gm-Gg: ASbGncuIRD4FgUXrT/QCatO8chJ1PqumRPBLPzPJKoMr79nL8oM+v/sjuAJdADqzD+D
	k17kxPAnapO+nmrALqoJJfsuPpjo1M+MnPQL8AQl4VGPYgq/zsch1VgAKHFBzFFTQESuy2Al6MR
	7PaeJuYsihyQxebbVXxZEPdoyN85cFQkFjkUYRcLtJy7Y1AH0/1KSCtYnGFJ1YaK87f8YHriGrc
	+CWq+HU6ijAOFfTYWlstnM9/48NTyaq441buRebcTErSL29smJ/Nw==
X-Google-Smtp-Source: AGHT+IGyOD1rOQ+vB9WNdLeWPK551lVrwQosGqoLYk02mc0hJpPxCqlmj9SiV7f2HYtQSHTKhqubxg==
X-Received: by 2002:a17:90b:2884:b0:2ea:8295:cd0d with SMTP id 98e67ed59e1d1-2eb0e527e2dmr13290191a91.20.1732471760859;
        Sun, 24 Nov 2024 10:09:20 -0800 (PST)
Received: from [172.17.0.2] ([52.157.4.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cfe4b25sm5101148a91.11.2024.11.24.10.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 10:09:20 -0800 (PST)
Message-ID: <67436bd0.170a0220.3addaf.4b25@mx.google.com>
Date: Sun, 24 Nov 2024 10:09:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8814175637202885018=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yuxinwang9999@gmail.com
Subject: RE: advertising: Add scan response data handling
In-Reply-To: <20241124165539.2913146-2-yuxinwang9999@gmail.com>
References: <20241124165539.2913146-2-yuxinwang9999@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8814175637202885018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=912054

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.61 seconds
BluezMake                     PASS      1574.51 seconds
MakeCheck                     PASS      13.03 seconds
MakeDistcheck                 PASS      157.63 seconds
CheckValgrind                 PASS      213.80 seconds
CheckSmatch                   PASS      271.26 seconds
bluezmakeextell               PASS      98.25 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      850.31 seconds

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


--===============8814175637202885018==--
