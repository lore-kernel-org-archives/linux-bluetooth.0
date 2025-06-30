Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D01E51D
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299655; cv=none; b=s/Xsrt5VpW1jfCBTKsmrXNAmSjoUdAwQLcSxbJIAnCk1GJk6YMryPSst7WstoIZmVX/WACArVFLx4zXdHjKfmgUvU7QZ3HTMpCQDMpR/7gnzIa7MYCQNvmJbsemByhkCOhk/ktY5Wr6eHUWrKvJBkWsoD7uLtkukYSOCbOR9JT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299655; c=relaxed/simple;
	bh=Ku8mfrtFWJumgs01m2kz0E0BkARzl5T8ADsoIPBRV7k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fssLPL8Hc9+0yjc01mPY+FezyWS1vewfe5pAHY9tebbAK2WN0Ia4zogaoLQake3zNKBouSbmertDO/kRQPVdrW1IBPxpSbJjoT/PgfD0yCeNYwRy+9HMdnJuEyTph4AnBhADdUDLTK5TOtAvS+HEvHb9moChZyCCoY+DwlA/a/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJkJvKQY; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJkJvKQY"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70109af5f70so3490796d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751299652; x=1751904452; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yGU8g2+G5b55QkqyfLrK57lY223tn71EztU9zgCf+lA=;
        b=OJkJvKQYBlhUdFBaC87/tApJyzaKNdWZAmvy/6X9x5crvhPWrw82zOcA/O2XYE0N/a
         7jJsn2PtJEIUbNrQGIiyWiRaaj01Dhu9quhu4kkVtczUORJJ3h901ARNR4eV2j1Jdgyt
         YDIRzZQm3UrPTaeW6EGdYM5dJt+C7wvZdTnkG0m+O1TjiwOWNZtOhFpUO30uI3fAHxr8
         XYlUCC3vjTpQhm0VTBgy3j8PDDi/aUQ2f2ohbDz0wSHYejcKOCwqy6D5svEm+B4hukUZ
         +jIdIKbBMDsuuAM+9z8Kuvm3jVUupUdF0oo+uEBHH8A39/Iohh5FgZKM7HTH/A04TZuF
         VdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751299652; x=1751904452;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGU8g2+G5b55QkqyfLrK57lY223tn71EztU9zgCf+lA=;
        b=Fk7lr9OsOXwzIXz5fNtkaN+qDJg/IGTKXQyImGyGC6JuraW3sP4sQ4O0TX6jmVygAd
         aD89O0XPUk5z9eo3sGiDgukiPyxG7iHwL04cTG8oXQTXUmmgfOrX2y5XNAqBa8CUqiLN
         mxeKYoNjCMIRFHSVimheRmoArTnCkOAnbnGlcSc1yDH2RtO2LZ7ox4RwMRSpW/Jfpzrs
         R2Jx1PwlZwTRxxhsiP1HtWelmgQeyeF5BD7lwDd0oT9rdMX50FvtFuC7SkXpgsL/MwXO
         9ms8GBNCyxTxcPWrI5p66SMe3xGaM/TfTr5FLCA32YH9PHvhQYv4uEPPqOzPKAyC3Xtz
         BPNQ==
X-Gm-Message-State: AOJu0YzexIHafwY5HkGESwyFYjjhmisOs6ewPtQntCACHp9NSdkNHC0J
	NXQ/f1sudrKGjkeSzhFS5WWr1nYNDlG/VlqtuWWj/yDT2UxN6ax7dJFP6bZlfA==
X-Gm-Gg: ASbGnct4PriQXz0elnAf587MuxBA6CaAGVOcaQiU5KkFgOK1w0+tmS/RspI8FLG50pJ
	yWHR/jVVq0aLw19eHluTXMo5m6jNmLPPIKVkWqzGg0mw9KxWR7tzlpOWFvvmqsYt+AfF7kD+rOV
	NlByhoqj8gHn8HcTz6qtGJ1bMNx0PvT5drcypHTrdPhRQUeXLW7XIly3LXodj+hMY/X9HTCZTd5
	+RK1j3coaekQOE7NAatkI8LJj+d07/+ByEb4A+Q6+29ZBE7xmN1/O3vXoeftpy5fXcmjAPT+9dz
	wvEScufNxoIWLJBe5Bi6Xd1esgaTDVzU9zXzjzqDShZzMEHMrbKkSptTbwe4c2IekdUR
X-Google-Smtp-Source: AGHT+IE4EDwjoEBVvCo0CqiOSvkrfhCXGk0HL9tSl/ko4UxH4APhzXVPRqxM6dT3Y3PkPxFo2LlOUg==
X-Received: by 2002:ad4:5962:0:b0:6fb:4da2:967c with SMTP id 6a1803df08f44-700036ae38cmr225110266d6.32.1751299652164;
        Mon, 30 Jun 2025 09:07:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.238.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718e76esm70198966d6.12.2025.06.30.09.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:07:31 -0700 (PDT)
Message-ID: <6862b643.050a0220.3cb9d1.4e8c@mx.google.com>
Date: Mon, 30 Jun 2025 09:07:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1301228202733348127=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andreas@kemnade.info
Subject: RE: [BlueZ,v2] gatt-client: avoid UAF after acquire notify failure
In-Reply-To: <20250630143933.1658224-1-andreas@kemnade.info>
References: <20250630143933.1658224-1-andreas@kemnade.info>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1301228202733348127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977363

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      2736.07 seconds
MakeCheck                     PASS      20.45 seconds
MakeDistcheck                 PASS      199.31 seconds
CheckValgrind                 PASS      274.33 seconds
CheckSmatch                   PASS      303.81 seconds
bluezmakeextell               PASS      127.57 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      907.77 seconds

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


--===============1301228202733348127==--
