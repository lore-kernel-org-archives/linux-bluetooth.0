Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E155769
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946628; cv=none; b=QqievSdtK3+Se2dwM4VxDoQY9iqnu63gGbxnyPLKHm6xhStAgyFn2M3YaMbx902zMz9hnu/UGeE2f7cCTnx7ncn3eSaBSGYz8Jbs+wjJbUF41LefCbznE/S/2ByRwDNWxfK2DOZ+QOqoRu1vEI3e8MhvbfHq9XVZeOptqK1oM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946628; c=relaxed/simple;
	bh=qvZVka/lZSY8HCaPvOs5Fwsd7CCyvxghVYrHf1qCzoM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lSkwrWpt0kpQNfPvGDdb4X1nnkcJaxnl2IroR17GPTc1Vg6ma4VF0dTCSN6QI+tu9yv9pE2XuYiN2WVDO6YALid1lyFUj0HeW099xi6GAPMNfn8vXEqK2EMG7an5A41Lmf66ZMxgmGIpVmc/eRPUYfOa/9i2cdq0P2Qo5YaXURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhaeIgLS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhaeIgLS"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-686980d9a9bso3036166d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 10:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705946625; x=1706551425; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oWth6/nP//pBTcSmzxZt72ucXoQTz+PXRCHye8YrB/Y=;
        b=LhaeIgLSudCaknX4lc41sAgdDvPBRa71g8jDOJZqplrLXT9wdrRH9tblIWNFqWxv/o
         YveAkatr/tHh3NtA325LkAbOyUSTFINdBvNw8R9ZG/wCFe2ktYMeXzfTt9gPaQK62BNJ
         rlz6K72YsL+HweFGNuLG34b7wESFkiLW/pbrSp1P9tYOinO4LhxdvmHv44LueD88cPSb
         053pn8HFUUwmCBLLalVIGe9Gi+EnWjZ7tbIz3cM//IEPvfZVqOZrLvVWKFA4JbDzHJhR
         ONLTFJ7XXWmdeN+SJKh/w1Vh6lWFN/dZErquvc9mWamhv9kJCm4T73tEPwhcwbSgpfFf
         TVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946625; x=1706551425;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWth6/nP//pBTcSmzxZt72ucXoQTz+PXRCHye8YrB/Y=;
        b=nPBtBiARuFSF3Eku23QMlM8J+GPdJP2hfLchr+ai0OMZNMSzERzloWnzejq4+NE4BH
         pWsdJNKlp4j3RbsroZS2niYE/9+fi5LJ1OyQQEaqTxu17lw7xFGJFL7lF86tjaCuozRi
         IJifivU4tdrW36OfIQrUFXiQDQ4CSxjf08c3d8Qu2A1wDRxtpJaIvj3l/7KONzfSusY6
         OBZ6XffAmEYi35JrwSFwMzjCFh+oRP1Pte6ySrcCzCkQitdgzhjJR1PwhrNk5yQMZ0Ps
         Uu/mi+fXjjD/xaVN3pqOM1Y2jVQpUnzJOVlPyhnqhCoxPAHaKw8lL9RAuNvOGQEvQ0oD
         oe2A==
X-Gm-Message-State: AOJu0YzwRT4eze7gY1Bx0lLQM9HK3WT2dvadSZhI3mPnyb8O1YFSle0J
	ALCYEeEnD6L4cMcc2owaj46czfLQ/jBD80IuAM8OcTmzQiOPA4AcrFVJnIT3
X-Google-Smtp-Source: AGHT+IHqs13BV8qL+TFKQKgFKZA89IoScybrKA8JCbHgvWXfefllvhFTq/UnZF4SD0qVu8FwaQok3w==
X-Received: by 2002:a05:6214:5292:b0:685:6715:9693 with SMTP id kj18-20020a056214529200b0068567159693mr5405188qvb.8.1705946625548;
        Mon, 22 Jan 2024 10:03:45 -0800 (PST)
Received: from [172.17.0.2] ([172.183.154.245])
        by smtp.gmail.com with ESMTPSA id ly4-20020a0562145c0400b0068688a2964asm1571054qvb.113.2024.01.22.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:03:45 -0800 (PST)
Message-ID: <65aeae01.050a0220.502c3.5805@mx.google.com>
Date: Mon, 22 Jan 2024 10:03:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6931538898725619884=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: mgmt: Fix limited discoverable off timeout
In-Reply-To: <20240122165955.280126-1-frederic.danis@collabora.com>
References: <20240122165955.280126-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6931538898725619884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=818709

---Test result---

Test Summary:
CheckPatch                    PASS      43.26 seconds
GitLint                       PASS      40.68 seconds
SubjectPrefix                 PASS      39.07 seconds
BuildKernel                   PASS      27.86 seconds
CheckAllWarning               PASS      38.74 seconds
CheckSparse                   PASS      76.42 seconds
CheckSmatch                   PASS      119.42 seconds
BuildKernel32                 PASS      40.00 seconds
TestRunnerSetup               PASS      437.18 seconds
TestRunner_l2cap-tester       PASS      26.76 seconds
TestRunner_iso-tester         PASS      47.64 seconds
TestRunner_bnep-tester        PASS      7.90 seconds
TestRunner_mgmt-tester        PASS      159.16 seconds
TestRunner_rfcomm-tester      PASS      10.99 seconds
TestRunner_sco-tester         PASS      14.43 seconds
TestRunner_ioctl-tester       PASS      12.50 seconds
TestRunner_mesh-tester        PASS      10.90 seconds
TestRunner_smp-tester         PASS      23.59 seconds
TestRunner_userchan-tester    PASS      7.29 seconds
IncrementalBuild              PASS      29.75 seconds



---
Regards,
Linux Bluetooth


--===============6931538898725619884==--
