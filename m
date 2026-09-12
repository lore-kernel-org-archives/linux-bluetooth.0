Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564E37757A
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254791; cv=pass; b=EkSZCOXaK7BWAZBYs7vW9thDI5KnPS3vvdQ+yrzR8oKyE1rCG2qm3feMc1XIU1izpST8yB4Gu2G5SqSkiFGFZ6zMrKa3K57FSjSfed72HZ5kAY7waOe5NY7xKclB2uIIMu1UNQoHMG9Woizd+bRM/U65yYsODKf7rtQ0KBhzgvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254791; c=relaxed/simple;
	bh=CRdTYSlWoxwI5O1LIpbsAafJmyVnPa/HDQyKnaMCsgM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qtd0YZCJgDkaAEm3CIbTv6aBBm0CMMLM/u6QQOvkuLI4+/pm7Hk9+J7mocMPu9F/PyLZYctM1Z4PsDp29SzCdegmBnWaB0v1bSlzA6Y+v6y0ECOSMjdjoEB69CR14xeXIfV1ptoKjRLpLukBGypJhe/W8HfV207VCN1MRc+mGGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZwPg8re; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZwPg8re"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2940d16190so299362766b.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 16:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789254788; cv=none;
        d=google.com; s=arc-20260327;
        b=jTr10y5uY3iGEKT4y4adJl6ofKxTJ6OPQYb+XEruTkBRNimf6Ro6PNXgJgvms4uIoJ
         WiKXtbn0/nrIGs6VAFe2HeR8pz5EmZYCWXfHXcuYBPmBPUmSyC8NeUwtfu0nxvOnb3HW
         Iy61ppP8zLJnRB6lzfTV7lPnxMt+Kg2eHE4+//WYXMnLSwzr9hoJDXqqSr1O3HpopKwq
         t+fSOyGmj0+nTW+cqXyk9PvGcCIHpdRWR2fEAYt6gfk7iN+9QV/CwTepbPWvjkZ71PP9
         4DWEAVzOLYF7+ejTsE2t4xufyYa2fA9A234GKHD97wurJ/pHLRKgYP77FGc8JQWqZ6kn
         mGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BoxMHVmfTlPBTfgYByFZQ2v4/oWwZNQTlDf++U5ln2U=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=gOmkv0Xr+9PkWTCVqhWrq3oDO0pczilbh4yJLcb+PF8vJqi69tjnJSMiS9SWiqSNuU
         T0zOWLmV4wx7y8bqnvSULvlVDo1RNnGpMcVAahMivkcxY6U/alrY6gApMEVOmN6u276E
         QuJhED5UrAXZM8JktDBS9EcaNfxHwuofKfKAQcw7IgjVv9YEGPxTu5ip89nbkK225jHR
         pT7e+VCFGCuw8NqYDqmNuCXZFwvzbXkmG4FNRES2gfXvGymgLCyoXd0rOYeCkke/sOrt
         rFXEoFDJbKBGU4/upmsN7IumuyeUAzG+91VWutKrmY2YDygrlJJoYnRPCHjNQxKe+wuN
         YJhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789254788; x=1789859588; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BoxMHVmfTlPBTfgYByFZQ2v4/oWwZNQTlDf++U5ln2U=;
        b=KZwPg8reIKRp/bHqZJ24zccvooVqSsWArvfCa9tK57JbZ5DhyvtLgIWiD69gYAhqtp
         Ypej8kOu4kSvIKpMr8QYC2cOPSLtvYPLzRw2DPweYeD04Ma/ca/2f3Rkcdl743zJMmx4
         OruR7eiMwMtG0BPh/sUj5S2gDND7uis0bRiaWvfVHeNYrkesGaUhNnwQMbQjt+hBq/ND
         65edvMnRvxbUiowhC55KTGG3vTL9i5vxiQ01YkjAVW80SruZsm50pjThvdbaG8WSUb95
         cxFwc0ZDqLP6EVWxfeXbJRK+15qNkNwat8HXB5R9UEjdIks5hmgZn/provrNymbGLTqO
         hoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254788; x=1789859588;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BoxMHVmfTlPBTfgYByFZQ2v4/oWwZNQTlDf++U5ln2U=;
        b=D5Hdjqsp36mh10Zs+NmC2ZdOS1w655TN8sE6lLJEFjzOXdOQEPMtAzkx/1ceSbiE8W
         hv1B1aMbteeZPDpYTgFgfjeamvU8Byt2j/NUZPPjuvccSrM2WALq0t1VR+RH6+6Wm7jV
         /Osc8z5QKzGQEgVJzMILow5kE40GbfTSDrg0ivGZSBPNbCMRnUCIhgrgg40+UpaMSs02
         4LpsUOjpu1sex4knGw5rfN0NMRwtjZbPqUcL/ZpLRPct6s4DsknjsZsuKV6ib+B0WZzA
         QHJAY5m/xbzl6oi3Jk6qGCZZUo9C5Jk4usCGiQLVd50I8Bv7WkF+DTh8iRp+OvyeDM+y
         ctKg==
X-Gm-Message-State: AFuF++lNayzpVGk4Aa38fW6QaAjygeO3A/2MWkpyamQr4fP5GviYRsAk
	lchAoGro/SOos4IsPob80oNQy/VYm5zc4zm7rPIeoUiBqIwoHI/9GkAZwwqY60KSmj3+IHWrmIC
	Aq/QGu1gFbbITfuUxVHQltyUHaFV2q3XBygovgOzdtw==
X-Gm-Gg: AYBFou3MHyTgYa7O3ZofpheGhjHQNrm/OmsHbe0QCIuP/Gz1yJJPYY5jDjBB3PDus+A
	WYXZkOYj1HLGcoqPWyzLi4bITySWElxBKiGTbALf26dYC3SGRa0U+kl4bDwzuMkpSBWM4Cnu6Vb
	51FdqpKw7gid2ppsZDZz5JERIziZgVtpNOkokfjVYXIrg2JphqWDeTZdGyMOEwcie0PIEBrzTZG
	7xHCE49B7z5MHI6NdA8tFUyJo0dtuLbk0DqbDXzu/nJ9PTwiNkoc52gy8cYkKlG+EZ1IyD9l9oh
	hVZmr5RWrO0HiLsQdQ+fM/61RHUgBiG9T5PKpqZEn146IqReBNNPc1o=
X-Received: by 2002:a17:906:6a28:b0:c29:5a76:72be with SMTP id
 a640c23a62f3a-c29667452e0mr582925566b.24.1789254788424; Sat, 12 Sep 2026
 16:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JLQvtGA0L7QvdC+0LI=?= <alex0plays007@gmail.com>
Date: Sun, 13 Sep 2026 02:12:56 +0300
X-Gm-Features: AcwNN1UTeYAwwdS6O9G26lebkG6CAVarov62rfKIxYg1dE56yGY9zcJ7ok7btO8
Message-ID: <CADv=UDciT5p+8RuV2-vz1ozWCENZe0SDYms05YT3bC=UDrP+wg@mail.gmail.com>
Subject: Re: Bluetooth: eSCO re-setup after HFP profile switch gets no
 Sync_Conn_Complete (Intel AX201/AX211, handle 257)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Following up on this thread with a same-signature data point on
different hardware, which argues against a controller-specific
firmware cause:

- Realtek 0bda:8771 USB (btusb/btrtl), soundcore Space One (mSBC),
  kernel 7.2.4-3-cachyos, WirePlumber 0.5.17, bluez 5.87,
  pipewire 1.6.8
- Your 12-cycle reproducer, run verbatim: 1/12 pass (first cycle
  4.01s), the rest 0.02-0.55s with spa.bluez5 transport errors.
  Fail durations alternate ~0.54/~0.04, matching two alternating
  dead transports in our logs.
- Kernel logs "SCO packet for unknown connection handle" on the
  failed cycles; HCI capture shows successful eSCO setup, flowing
  traffic, app-level silence, host-initiated teardown, then A2DP.
- Manually pre-setting the headset profile before joining works
  100% (no mid-join switch, no race).

So the 7.2.x + WP 0.5.17 trigger combo reproduces on Realtek too,
pointing back at the host-side interaction rather than Intel
firmware. Full standalone report with timelines, HCI summary and
diagnose output:

https://lore.kernel.org/linux-bluetooth/CADv=UDfoE-YNrqmtCNee49eh0_yE7NQtNNCEYWx5MW7W_ziGrA@mail.gmail.com/T/

plus community tracking at:
https://github.com/Mr-V1be/linux-bluetooth-headset-mic-fix/issues/2

Full 2 MB .snoop of a failed join available on request. Happy to
run any further diagnostics or test patches.

Thanks,
Aleksey
