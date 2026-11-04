Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769627;
	b=IRuX+Ui0oiFnBxG9z8JvcQp6QebrB4PAK/tr1z/N4kci0/lBJJfnqekxkx+agCyymoWo
	 KBzNd7x24/KX1I3gOpN1EX7F87GAkLnDx7E85Bq9f4r2bvVbGAf1MUzHxb1fuIEbNyrw4
	 Y5/TuVB4sPhrVSu6dtUDu50sWn40DzyfMebtIYLo0dbFzw30v+ZgYyxzCC2cEoU6Lovd1
	 mi3uDt0PIQKHciJhuvH/StbL1VUZRswQ65SjzbueDwaRuCkSSffhT5ZKYhT+avH6MisVa
	 /Iqp5kytXk8rxya7keAdXrYVcwWhFKqofew8sQ/a34nuTN9zSoG1yrLa/zn1m2TQZVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID;
	bh=dkzEiqiH403slnnUf98tQB2VoCJa6NmQ1s1XzpZruY4=;
	b=gU392ydiok1qzdHnoXyVPkPMaUMi1xC1kD814LceV0hQjTzREv3/YmVDzKOWRGr3LFg5
	 SDwWvnMlFL3IKmYwBSrIj/BwQ68uo4zxi8F2XuAYe0ogx3YJ89KRJdFPvywUD81IUccF3
	 i+yk9mxbBJR0j1SSS0i/2ynoeoSYOcwk+UIi0XihDqln7Ce+U6WfMshwkftnUSjGYbBNt
	 34314mens6OwSoysCmznrt8Eg0Iz5kZ/ZTbTxe7tfrEWofnvAkg93td2ditwxAsf+SwCf
	 uQ0jpW1O61PTPzytLuLFB/YjwNp6qW75UonJZTP985awfkklVMmBYCn0a85jIKtTj+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LBKHqbi;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E902B606A331
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 05:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E902B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LBKHqbi
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-369f33df08eso515120eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 21:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793769626; x=1794374426; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dkzEiqiH403slnnUf98tQB2VoCJa6NmQ1s1XzpZruY4=;
        b=0LBKHqbim1r29ndS41rtycCoCW1+57UXE85O8UDvVq2hXd/JMyS25+4j/Cab88X+NU
         ek+aKMW4U5C6TXOBd+vWvjyWo4bem4Uf21TsxAbvzQBxWAWGcx5N/57nGhwhbLz+tKcQ
         ZhIBgOAqaTtCvbL4yfhopKCOH0XN7A+P2ksp2W+rfpEyOm2G0qbal/jDhLJJWQJIFmyF
         GNwTXk4y/uoXwZOqSNFZZuSVGEJ2no6zI5hOgKI21mv1rohKu1UrRUc1Zp85//pQU8tC
         ol15KXJDpPjuogPIOATT8Wnobgp8baMobYLRMbKVExtA3iqsVLiVtKOeycXemOPFQ3AO
         fbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793769626; x=1794374426;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkzEiqiH403slnnUf98tQB2VoCJa6NmQ1s1XzpZruY4=;
        b=VTlCg5ZgIfsXXqogg9D6d8FV0U5Az+mT6A6OA6lrY9k9524l78kawIQ+kNL5h9kA8a
         ralSt7naj4IHMJ8iyB+fa2fnn8lf8fsj4AKWWvNe9hFoGkS0uW0ppwNgqTflo6N6HtSd
         2yaGS+3rwP1VfdrwoEsVyHQhUtI+oLyLWI6geyuZXEbXALphcsvKlDi21NiJ7QbpJ16F
         GKoWaCOdfGyuwTUqxPv220icxYco4XBCmCy/yGYHwsKPGhfN4GD/xLqQolWQDMDA4qwT
         UGPyOwzIORpdsX0HIiBcJbjaTuFHbmX3ZACNfZynVN452Aw4Aj1cKE7RtXLSA+wPtuyS
         3VGg==
X-Forwarded-Encrypted: i=1; AKwUvByq2w6Mpgz5AA3dq2VI3zqYvkLQI1J2+6gX8whZ6Ho4ijPICrJDfQ8Zrhh51jao+lbhBC3hbnyLGZOwkW/cTJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eUhg20UAo2AqGHJePUHsDWqOdx5vGQ7fdOQy3st4odEGBk6Pz
	NE6aOcu7ZimLsyUH9vYTEksz7/cPv/X8T9D4jHHUC1YdH+dT3TZx2uBz
X-Gm-Gg: AYBFou1KoQuiz7YwMHBQ2vU1LPNIeDog9E5tXbTtFmYahBdvAdcchMjogRQ9/4GzCs1
	vuZIsKyHdt+w3F0QZndboXEkmftq1K9pvkr5dYXat1j2wSHMkiS4BCagQIdyLA+ww6uv75H3NDC
	Dm75Q3dwHkzM9BHeyFOKog0c/+V42qNiFZb9ySRZqanqbQVimabpjpJXNUnJfFqoxWdTt5Q8vtj
	ZQxVzZBoTVR3KnbnzSEcIGy674qxrDRL+LwhynOehgC+DsPGcV9WO66C1x5POVfBTbph3NKX8gd
	2Xg5VEaXAhbZeq1qK6C8wUzRl0+9z8wyQ2Z4vGVlU3V1fC2GKIVelfFH7GzhIqOJE3NiUsqjtiL
	Zl+x1hEd0Wo7UGEaCVERPhQjpfXbAJ1u3NCAxfBzL6eOxUG4o9EsSgC6z8yruVymuAg70HcK1tW
	jHXba2fHEyg6SGR+T3we9qwQNLY/ydZvfhHXLxa6UAoirjA0g2A/lMQsl7tRpC3kM6WjpOXY2jc
	uAHj+qlFa23WSNUMUW0Fpb3NXkTrDX4+/hET7JTR1Qo5sqtVkd1009uy3RsV5F5O/OvYNgIL+hj
	2r9NA993oMOp3zRvMTCvIMl5eQltoyrIS7cQAQOpDhdVoNMnRILUjPYso8qO18Z2uw==
X-Received: by 2002:a05:7301:dd8c:b0:36c:9959:c37e with SMTP id 5a478bee46e88-36c9959c4acmr4601667eec.10.1793769625768;
        Tue, 03 Nov 2026 21:20:25 -0800 (PST)
Received: from [127.0.1.1] ([23.247.137.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3788bffsm3617382eec.1.2026.11.03.21.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 21:20:24 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: nicoyip.dev@gmail.com
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Bluetooth: hci_conn: hold a reference for LE
 connection timeout
In-Reply-To: 20261002174658.3596771-1-nicoyip.dev@gmail.com
References: 20261002174658.3596771-1-nicoyip.dev@gmail.com
Date: Wed, 04 Nov 2026 05:20:03 -0000
Message-ID: <179376960391.50454.8822263457423416137@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list

Hello Chengfeng,

We independently reproduced the LE connection timeout use-after-free
and tested your [PATCH v6] ("Bluetooth: hci_conn: hold a reference
for LE connection timeout") on a clean Linux v7.4-rc1 tree
(6628e7d4c6b2).

Test setup:
  - QEMU/KVM, KASAN-enabled kernel, /dev/vhci virtual controller
  - Management SET_ADVERTISING and L2CAP LE connection
  - Kprobe-assisted timing injection at le_conn_timeout() entry,
    50 ms park, with mgmt disconnect at discms=2015

Results:
  - Unpatched v7.4-rc1: 42 slab-use-after-free reports,
    with the first relevant frame in hci_conn_failed()
  - Your v6 patch applied to the clean tree: 0 KASAN reports,
    with 200 confirmed probe hits under the same timing setup
  - Control run without injection: 0 KASAN reports

This is a test of your posted v6 reference-counting patch, not
merely our independently developed fix. The result supports the
lifetime fix under the tested interleaving; it does not establish
coverage of every Bluetooth shutdown path.

I also confirmed your analysis that a naive
cancel_delayed_work_sync() replacement is NOT safe: the mgmt
disconnect path holds hdev->lock while calling hci_conn_del,
which would deadlock against le_conn_timeout's hci_dev_lock
acquisition. Your reference-counting approach is the correct
solution.

Tested-by: Yaohan Li <shunsheng1218@gmail.com>

We can provide the full console logs, build configuration, and
reproducer details privately if useful. The investigation was
AI-assisted, and the patch application and test results were
reviewed by the human tester.

Best regards,
Yaohan Li
