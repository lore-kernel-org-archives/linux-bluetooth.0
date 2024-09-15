Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931D3770C
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Sep 2024 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726437593; cv=none; b=oazbDVdk/5Z/iSwx2fkf2v9Uwk+18Z3D+6PWjl6J9etSyUIKK1KUewJMteZ2lCD6Z1uM2NpRyKLze23xkCodyK5jVMFH9H5Y1yAPPFXGGnElv2eSiceKeKu3KsN9r7K+FROMZBIuCDA7dZYFk6YflOpE2dilgyZleh+fQdglVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726437593; c=relaxed/simple;
	bh=WG501E00ZiDC/3X2O7rIGqT5l3KSImXaE3XO8UWzxkA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mDEfaapaqQiONAXdjTpaEnr1OZjXFC/mPsQT63mTAUFPOTA1nBSr9XGdArGo/IZTbqpZDQKbN1HbtvSDAbWYkUiQ00mqyYTzkpyIomMe6W7pCYJWpCCdBV9mkmlNpDPoQeDNUHo6vepf8dP7kp0DRfT1SJyGrOhY3UQ0C05qkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMC6RtyI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMC6RtyI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4581e0ed0f2so41133161cf.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Sep 2024 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726437591; x=1727042391; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xXSiZxm/ZfKZyEuV3tmvHwbK4SfBQAZZ4Xs0euAHM4g=;
        b=lMC6RtyIqe7oqpK6HEo1Jg1K6at9y79Men0/jw9FmAR6PXwekRKZ4oUnQA+ZjSu/hK
         tpPoYIf9EJghBWtK1VHABTm4gV+36jckbqbcHlQ1hsspfpelg8JCQTvdKN3mB4ZL3j6F
         wdM1+pKq6o2HkAsbNTDBVjDTc7Wz2XsuBsGOFCqbYNOkrGNZewURVj4CZqpXK5+Nxa3n
         Qcaub7wRSidGJeRThWCJ96+q7r/uiVphcltAGIk5U9AZ5e8Qpx4nU4nXnQD7n8PgqA9d
         ow+XKp7Vwd/OLenIGS6SshbmQn/UavikJvElNz1742r2qONG66cHNSi10tlWJkWOdgLP
         2ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726437591; x=1727042391;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXSiZxm/ZfKZyEuV3tmvHwbK4SfBQAZZ4Xs0euAHM4g=;
        b=Amj1ZxtpMLls0nDtG36KxM+kQPmdosd1ImDx3xjOQB30iB2B+/2eK1ERVDN/ku6DsU
         MnnzSgKVuw+BmG8C1vF2NkrADFtrsGW5pG434pvHnK8C40Wr+p9d1y3rE1DV/J+cdG8O
         zzhbF1oRcNLgu/X7SrvCSjCPhf0tE7OI1pAyqQrRABFHqvREoxlGkS5K+zT4knTe8Ibv
         dro0ewkLP3K1SudKcEEHn1UukqKCa5vpCkseL1842D5CY73NT1Klul46q+MwbU/DGFIT
         z/iL9s1Vsro+RLhot+qHNbtM0HHEMyC2n/jdS2/nzTAc9qEdstDSjuR+1xe6YJqNgXrA
         fF6Q==
X-Gm-Message-State: AOJu0YzXVpIJD1vCEpmN55ZbfC/NLC0W5LBqm57fESIK9tYe/mvho6H6
	uvCmyt3ZZNoXmsBXpmQ2tcVz0em5MAcbVv1jsf6HVEEXtj2XyiBlItD6vA==
X-Google-Smtp-Source: AGHT+IEzg8zK2V57FEJabb5BUTDvg0lqrGBq+Bo5T0oiWm3ezybHDeNiWvCO9QESmUsQtshdTTZQ+A==
X-Received: by 2002:a05:622a:1823:b0:458:27cb:a5e4 with SMTP id d75a77b69052e-458603ba80cmr249562851cf.1.1726437590907;
        Sun, 15 Sep 2024 14:59:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.107.135])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac7e6b2sm21099251cf.31.2024.09.15.14.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 14:59:50 -0700 (PDT)
Message-ID: <66e758d6.050a0220.151903.4dc7@mx.google.com>
Date: Sun, 15 Sep 2024 14:59:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0640409702612733320=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ismael@iodev.co.uk
Subject: RE: Fix missing inclusion of <limits.h>
In-Reply-To: <20240915202320.8181-2-ismael@iodev.co.uk>
References: <20240915202320.8181-2-ismael@iodev.co.uk>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0640409702612733320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890531

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.41 seconds
BluezMake                     PASS      1629.00 seconds
MakeCheck                     PASS      13.20 seconds
MakeDistcheck                 PASS      176.75 seconds
CheckValgrind                 PASS      250.36 seconds
CheckSmatch                   WARNING   352.20 seconds
bluezmakeextell               PASS      119.12 seconds
IncrementalBuild              PASS      1386.76 seconds
ScanBuild                     WARNING   982.79 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/serial.c:151:2: warning: Assigned value is garbage or undefined
        enum btdev_type uninitialized_var(type);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/serial.c:151:36: warning: Value stored to 'type' during its initialization is never read
        enum btdev_type uninitialized_var(type);
                                          ^~~~
emulator/serial.c:36:30: note: expanded from macro 'uninitialized_var'
#define uninitialized_var(x) x = x
                             ^   ~
emulator/serial.c:214:2: warning: Assigned value is garbage or undefined
        enum btdev_type uninitialized_var(dev_type);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/serial.c:214:36: warning: Value stored to 'dev_type' during its initialization is never read
        enum btdev_type uninitialized_var(dev_type);
                                          ^~~~~~~~
emulator/serial.c:36:30: note: expanded from macro 'uninitialized_var'
#define uninitialized_var(x) x = x
                             ^   ~
4 warnings generated.
profiles/audio/a2dp.c:372:8: warning: Use of memory after it is freed
                if (!cb->resume_cb)
                     ^~~~~~~~~~~~~
1 warning generated.
src/gatt-database.c:1156:10: warning: Value stored to 'bits' during its initialization is never read
        uint8_t bits[] = { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
                ^~~~     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
tools/bluemoon.c:1102:8: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        if (strlen(optarg) > 3 && !strncmp(optarg, "hci", 3))
                            ^~~~~~~~~~~~~~
1 warning generated.
tools/hciattach.c:817:7: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
        if ((n = read_hci_event(fd, resp, 10)) < 0) {
             ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hciattach.c:865:7: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
        if ((n = read_hci_event(fd, resp, 4)) < 0) {
             ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hciattach.c:887:8: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
                if ((n = read_hci_event(fd, resp, 10)) < 0) {
                     ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hciattach.c:909:7: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
        if ((n = read_hci_event(fd, resp, 4)) < 0) {
             ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hciattach.c:930:7: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
        if ((n = read_hci_event(fd, resp, 4)) < 0) {
             ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hciattach.c:974:7: warning: Although the value stored to 'n' is used in the enclosing expression, the value is never actually read from 'n'
        if ((n = read_hci_event(fd, resp, 6)) < 0) {
             ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
6 warnings generated.



---
Regards,
Linux Bluetooth


--===============0640409702612733320==--
