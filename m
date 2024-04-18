Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75816ABFF
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476587; cv=none; b=LNJkge/OfrRIUfx6hXH7qO4cLsrLD0Y9VFLLq37uWbO5+7gq8+z7l9u4/synaDAsYwmrP7/HNC+AheT1Z/p9wsw92QKdYza8c4ecDzigNV2AQl777zlMHhvlra27DDp5uBm2P+qcA01+OiKKPNzE/J+JT1dnqiaPBlkkV758xaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476587; c=relaxed/simple;
	bh=WcFxqpVgwj66zsXk6VsYqKH/oEH/5hEqQ4jcRJLZ4O0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kU9gkO4JfHQjHSplUL13sWXl5JfzD5qsCXiPfmEmwT09CfLkzJVpKHIoXI61uTY1x2LVen7d7YvroahNdgIt7VQk/ZQP7h1TweGGOrVKB3YQe8p9DAh2f7VKpP3qsa2NWkOHRUlior61J7+UtWEDhpgMVK671sPOhyAmQxexe1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS3RBYX/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS3RBYX/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3c9300c65so13352385ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713476585; x=1714081385; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XN8Yr5DOR02sYDoUUp0zY3vhj78Sd55I1jwfoRW5R9I=;
        b=fS3RBYX/mXpGwjjXUXklB68N8610ylHf5e9dfb6ugGlLYd13tplrBmPxtziRK5YrkX
         xNtINm0pN/CwY8KvRtZ61Joy4X583bVlJOexNXi0VPlUPvgiWaSbf90w23k0AreWQvmy
         /2qDjKpGt3RH83TIwu6+Gf5ux09Jsda7SUAsvimXpzjCIaBlYjUo2Uv9gRkhRKFfO9XL
         XBB7OKzjO+wkH+EZz51wZn4UVKPcQmGvJgc/jOKpG7MlTFiPHnnffNDnX99EF2hh9kp9
         /R5ErqmxWc4WrdssUDTMCkjv4veXjzzyOTl3aptRDva8scPi5OxUtKnhx7vJhmLMkOee
         z4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713476585; x=1714081385;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XN8Yr5DOR02sYDoUUp0zY3vhj78Sd55I1jwfoRW5R9I=;
        b=eEZjuk9wZddQ7ifMQ14gt7Jq/Hg7DF67s9a1ycNUnIteDJR63sG2CiookxMJn7bkT/
         x7FebsKFR9LBhikPEySNwmO0C9hcNFezD/Aap4wgtSsgPLFl4awa7DMTnrAOvbiOtBRl
         yecsO6N+/dAKV6mG8Q2lSsP/M82sebHMprm3a1Rmg7ABW0fxxOvj03u4caKobeD2Lqnz
         WhDPc02xRTLGeZy5IeIN39kqtJyz4JEltXwxKm1f/zZWU6R2MFcX0IyxusC2V9jdvTGf
         AM+eBx9NidzBw/M4g4qNysXEEWEYtAbkkE7JrGKtrgk4DKdm5qrUgKg5kiukToTaQfjR
         7OEg==
X-Gm-Message-State: AOJu0YzSbDZwSgl4Eb0+cTH1eB0P4GAyojhIYBz0iuxkBgUQkKO7rV8o
	OOo94T7jg69Ojd3476v0T7xnBgbFtZi+7cLo/2SOZo8xEkqshX5XhznRGg==
X-Google-Smtp-Source: AGHT+IH82HNrG5HSMUE+38aHAQ0zUuQh7n8GA8GZtbSgRCEUfvfQjc5f5uVEr7NEmnwRU7o4KfIBJw==
X-Received: by 2002:a17:90a:2e18:b0:29b:bbef:912f with SMTP id q24-20020a17090a2e1800b0029bbbef912fmr450273pjd.10.1713476584708;
        Thu, 18 Apr 2024 14:43:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.4.81])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090a058200b002a7fadd6828sm2090649pji.43.2024.04.18.14.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:43:04 -0700 (PDT)
Message-ID: <662193e8.170a0220.494b8.7f76@mx.google.com>
Date: Thu, 18 Apr 2024 14:43:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1898301827329144485=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] gatt-database: Fix sending notification to all devices
In-Reply-To: <20240418194723.1440686-1-luiz.dentz@gmail.com>
References: <20240418194723.1440686-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1898301827329144485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845939

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.18 seconds
BuildEll                      PASS      24.77 seconds
BluezMake                     PASS      1733.68 seconds
MakeCheck                     PASS      13.70 seconds
MakeDistcheck                 PASS      178.89 seconds
CheckValgrind                 PASS      248.20 seconds
CheckSmatch                   PASS      355.07 seconds
bluezmakeextell               PASS      120.05 seconds
IncrementalBuild              PASS      1575.95 seconds
ScanBuild                     WARNING   1022.75 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/gatt-database.c:1155:10: warning: Value stored to 'bits' during its initialization is never read
        uint8_t bits[] = { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
                ^~~~     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============1898301827329144485==--
