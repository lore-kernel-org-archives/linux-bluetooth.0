Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962A36F90F
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231147; cv=none; b=S/ra9OE9OFX/OYI3at60Tu93fj3avcxr0IIuFLYDxyh7oHY+3NBNRt75YEU7rI0yHAy7t7zZGolw1y0V8Bh9h7rjJ7fJZ6f9sRZDeBI0/SWJGYARgDLm5D4NPt3SLv3Kk8XQ75Vd2lVzhTHAIiQhZMgHnVNhkWetA7RtRJG4Pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231147; c=relaxed/simple;
	bh=PB9bDu+Y4s2Mg2rq/K+fr7ngyYkKygM5rubHAYazb+k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sIo2nrbDwKVLzS2vqtwhBYIfhmyLZd0iayqSX+eASLzbAzH1fJqdgkIOB9waCDGQ1dLISbr2lgNcdeEBn0ZFetzdx4/6EN9p6lQpfLA4bidZYzZSfjc9HML0L1TMWvO/HTzcR2Y6H3nmMs2KWWyB9GUnS6xd3p6DlO0ThBMwV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9LvdRq0; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9LvdRq0"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15354aa70e8so5331848c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231146; x=1791835946; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rQ4tgKWsrUm66A0+TSTcj70cHNf8smIGChx+cZcXQ/U=;
        b=B9LvdRq0UhP7wx9Hi+yCn8QPOE55xGQv87Ia+Ve0Cx2aETs8E1UmuTpJrVwjYuj/yk
         D54kwshZII8W0O+eZOtgYmrCyjyOo0uOha0QunAcIKQcg9k23HrbAEIQ922MOrlGnVna
         u06PuYmDeHKF5rKJyf2P/6rrALC+mN9WBwQc0UwsvHZ0sljp/i/jcSSyEYfeL1vxzbEG
         VDDM84gQwloTj4V3KqwpYg5ywyNvS1X9/Etbvm0pJxvcFvIiTMEWZHqawxcFlYJI/qCx
         CET2CDhGlY3HSi8O/ouFXCMXhkn5fNQcnenRSkMZq69MS60Rt/WEChAoBVRi9tHH6BoD
         buGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231146; x=1791835946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rQ4tgKWsrUm66A0+TSTcj70cHNf8smIGChx+cZcXQ/U=;
        b=cVdBP5HtbbPJwImz0vh0xAJzwzwsxX3PALcOlf7VDJdmig1zZk60aK9+WMn4iGRlAO
         L3whGQU7oyUiqLV6sAXY1sbrtK6o7pP2uySG6wGokz9XqRa+SiZ0Wmb7bNMU3yMbiWKq
         1vGIIIplnQRperdTEw5MMDoKswCNwCz8z5zRDw43Bz4kFN17BhXhHcCAkk3W8nyb54dP
         obwHyhJXm+W3ALXfv6dWeU/lkYq+XwcCrBmnyeTG2M5sN+12E+Jec/iv4oQJR9kpyHkt
         1tvSCPcnHoQ2V2XHxJQ76yg5GqcbAWG0ebQljadbvqBjQQybjDQ6RRX991Zq2F6GD2hr
         I01A==
X-Gm-Message-State: AFuF++nu13bJ4TEYaQbqOUeBetdQfOoaObFU8EzlltOcSpg9j61YvvWm
	P08PsNv9LiZpBiemj2yR4vb33DQFEwWDlJ9Hct2NXVQ1k0pTuLXFFpGxSCJn4BZJ
X-Gm-Gg: AYBFou118bTod/bxPvl24x36GQ+36lecCoPFjLYbBxUoKNZ5QiQnBHffpGPJZYszKOO
	wuzIksp3IkeDAlzjH0DczOpztSmzJYq/tCaei0GnyxVUDrQNKxAMycdiPjlf5SRxysJy5gT6DAy
	P01MPjwryZjHEzPB+fQVRzo9irWVXOcWKRP5XjxRTY142kAU/7YlljT+i5aHbeiH51Pxfzdoqt/
	pE7Ue7dWzaGw2+C0jVKQEnR2MNUgE6cA1UWABeh0mKZfcEoKhsYFIacsRNTzbj5G4TZrvAQK5t2
	7lpa2hNce1ufBuIfyy5aL7aEu+86GUC/P5WiwM8+XZKR4vRZSQl0oXHhq12DKDV2x82dkLaI9UV
	yMkq14Eva14YVQiF58i5qBzB0Gy/bxvWAZbywyUuGVeJ3bRR03veJKGZNjuA00Sb/MMxEmfWdfL
	lu1rrjJjGBSuy2Dvf5cxPUlJudbHZhIJEf9zmBztWMPnWEHEiGsUJ3VekuN4DmvmDcsrqV2Sbcu
	+MSF/A=
X-Received: by 2002:a05:701b:4186:10b0:151:5d01:9316 with SMTP id a92af1059eb24-151c3d89d3dmr13085216c88.23.1791231145620;
        Mon, 05 Oct 2026 13:12:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.184.150.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d83d6af11sm625932c88.10.2026.10.05.13.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:12:25 -0700 (PDT)
Message-ID: <6ac404a9.b97a138d.16226e.bdaf@mx.google.com>
Date: Mon, 05 Oct 2026 13:12:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3686214619744929259=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: emulator: Fix extended advertising report types
In-Reply-To: <20261005162117.4606-2-kevin@simpleble.org>
References: <20261005162117.4606-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3686214619744929259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179769/

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      1.09 seconds
BuildEll                      PASS      19.55 seconds
BluezMake                     PASS      384.09 seconds
CheckSmatch                   WARNING   292.94 seconds
bluezmakeextell               PASS      93.64 seconds
TestFunctional                PASS      1127.10 seconds
IncrementalBuild              PASS      390.07 seconds
ScanBuild                     PASS      1108.07 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:479:29: warning: Variable length array is used.emulator/btdev.c:479:29: warning: Variable length array is used.emulator/btdev.c:479:29: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2628

---
Regards,
Linux Bluetooth


--===============3686214619744929259==--
