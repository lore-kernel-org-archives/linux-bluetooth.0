Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5DF519
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921977; cv=none; b=nxKhr0QoMg14tJw+H8+7C4ERPC6ISpm7iEcVygLl7ORGZC5XIjcakD7xV6nQoGUlptrdBVErJwQ7m3nD9lrRevUg6xWn7IjQOxAAJDvX5ga8xixRpvYjByy4YMVbqcLBTW7LtH+MjZ3Ys5WhjAbe3hkqG4SakQmo8dKCLRcod4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921977; c=relaxed/simple;
	bh=UVX1jtGsU0EJ3qgtzfsNnnGDpRfAUtmhahUdYpQrIVg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cXloagKNZqknvkiaXb2Jz5Y4QXSKXcIgvBVYU+N/CVvOfOWIEKzNF0c2e9MJtDcRAT7GqrL00E5l7/E2hGSEutLsxWznx+5PsmG3HaLeqovlvHiQ0G3AGmyCfyLoVajCF77buH4jcbqfGlVzsrod/7zvUnPBdlJDOJQ8qeNTdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/KjZWGt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/KjZWGt"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so6612845ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721921975; x=1722526775; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hJC6EBRtsE9buDmBbArIjEj4qMD4gJ0LW1XVP32r5YM=;
        b=e/KjZWGt3TtgF8g4gGWx02ZTAsNxi5X2azWva+yr7fgDWHI/DAllumvmMJqNlMB+Ji
         bOpIDnScuPwT7wMbJzBBAdWktNPtPeWBXlVsTgO0eV/ntkeCZ7QZvbe2sMkX4rd0LfBD
         a+pDoPlu0wWq0mMr7DuF1RJsCEN0thesswT8q3AsCEATWe/tirqlh3FBe/GmC+oNN/rq
         d0AKTnI/UEI2FrP2fgOZVf0N8V8vWBQrVWe56uej6X/qrM6RWtSWrAy7RjyM8McN683w
         RYqw4tZVwCcuyHCJr+hFanP/JWUCuGUMept1KQhlZVKq2dxz0JcbSobsvV1aI164Z0zZ
         wx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721921975; x=1722526775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJC6EBRtsE9buDmBbArIjEj4qMD4gJ0LW1XVP32r5YM=;
        b=l/QCuHXHSBR3HMtt3v557VuMCjDAyHjnd8aL8KtthC3BRgLlip93F3ArjG0ua1MlgM
         9pZScgT2UbY5qq7At4epTly8UEycQGyK0qe1YVhOmS9ZEhKlAENNQAN3RYabfqGoqafU
         9q/9vnmH6tq/cv9lEB/lK5QDZnHfAQ8wUjq7Zy1ZYCJtZPVBlMA9KMjEoaRk8mmovQs6
         NF0/RNP5WGMvYOYzNlukELg0PsQayh8PvvIvWDLmV1g40OlDwrSQthHn3QPirMMzdn1F
         +8YuSI0guDlSOGO3aQAlW5oFqNlZfKdAOcoJxatJC4o8K69j6UTlkiB5zDqkiQ2QeWhh
         OeTw==
X-Gm-Message-State: AOJu0YzNE+ABJ8jZEs7FJTWmmZB4GUwKPa+O4Xdt1OvwR+gWyDWzxS54
	1V8efGZP/XAAN5eR1Ci+eIWgduKmuVqDGYpe7W5PtC0yWZFDLetVHg4mCA==
X-Google-Smtp-Source: AGHT+IH1OKd/Ux6INM2u7XRPSRBDFPYOD95VzbrkQSVvgVUGOsb+S1MNSGQAHbxz3+rJiR+nQwB/Bw==
X-Received: by 2002:a17:902:fa4d:b0:1fd:8677:6160 with SMTP id d9443c01a7336-1fed923e7e3mr21440645ad.15.1721921975025;
        Thu, 25 Jul 2024 08:39:35 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1b80asm15574835ad.184.2024.07.25.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 08:39:34 -0700 (PDT)
Message-ID: <66a271b6.170a0220.2e033b.3b21@mx.google.com>
Date: Thu, 25 Jul 2024 08:39:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7957309993350828278=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Add 'broadcasting' state
In-Reply-To: <20240725115854.234781-2-vlad.pruteanu@nxp.com>
References: <20240725115854.234781-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7957309993350828278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873820

---Test result---

Test Summary:
CheckPatch                    FAIL      1.78 seconds
GitLint                       PASS      1.47 seconds
BuildEll                      PASS      24.43 seconds
BluezMake                     PASS      1678.94 seconds
MakeCheck                     PASS      13.63 seconds
MakeDistcheck                 PASS      176.04 seconds
CheckValgrind                 PASS      249.84 seconds
CheckSmatch                   PASS      352.51 seconds
bluezmakeextell               PASS      118.54 seconds
IncrementalBuild              PASS      7869.54 seconds
ScanBuild                     PASS      986.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,3/5] transport: Add "select" method
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#128: FILE: profiles/audio/transport.c:975:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                    ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#128: FILE: profiles/audio/transport.c:975:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                                                     ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#128: FILE: profiles/audio/transport.c:975:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                                                                        ^

/github/workspace/src/src/13741852.patch total: 3 errors, 0 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13741852.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7957309993350828278==--
