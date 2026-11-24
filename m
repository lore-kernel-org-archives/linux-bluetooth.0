Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529432;
	b=4EWpibnxeSqRHDOLWM5Am3ikBvuijrJLnjyGgZeKlMIbxG3yK7JTMU3J0mlqfQnCND9f
	 ke5QuwNl7CiIR5wJYEb1/xuy4i53n9LSDbfEzOdv0v7HU+RGa9eXun0h7LDaiIDsNAQIP
	 b0ZJ29BjEBavA4TpMntRXE6Gx6Tpm+tPpBnFYc/npiug1ySCNkDanGbOCdqtW0SMbJTea
	 6h4f9+ZTD1Q3XopZaxRd6RDQ6mG6yEbA/GUbdCUDst1ATsibCvXiAq/IQxkBnDjNMK5LZ
	 LSHswAAb6f5h0k3owE3ukuj08I6xl1WbyGhVEVS0t/ij1AXGvlABLELm/B5qOUlt7yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jXiPVtfN2wZl1+H6KM7aKPWRvFLxQP41vzviKryy7aM=;
	b=YCJIMSi5BhCEUvaMTNM8Xiw+x2uyGIC5gWfc4DEaSEWSkZWklzviMuwZoP36+AZXHnH7
	 kiUI8RTAva6wmJYEQFsbvpZByc99rLPifqO5kA2DF/FMvuG/01X2zPlLlPr9iR809xvFJ
	 GDHpGalLSDZxI5fqDFBStY0+sHW7QEYg9Np16tCxCxE24a/Q5TjHs3xtanBrtSkIReHb4
	 Hzmwu6CUvzzRtJiGBORS/gMloLVIKha/pNRR7CooMzaht22OJQsmpOwXb7vJxOkXIEUQD
	 15Mz6odBZabxPRuVAwzthU3OQk+e46XXC/WFHiwcStaTzbDO+jHbJvGN7V39D5g3kiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B9cOdsCf;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0D606B031
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7E0D606B031
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B9cOdsCf
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99e145569c6so978219241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529431; x=1796134231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jXiPVtfN2wZl1+H6KM7aKPWRvFLxQP41vzviKryy7aM=;
        b=B9cOdsCfRSm/kHBVHQzvDZZF/z2RrcH2FFKfpsj/vjD+Terp7WV3aMU4fYavvSdty2
         +DfuMEiqNsVK3QErFBhvOWY6gPu0rMGwMdpc+OBca16yQnDzoF3rtADwW64d2+HTDYbn
         9lcAu1EEZ/4BhGNFidq36l/XsWiVYGWDUxI6nXvdI0pBLWsovczeWdW5yu/3ybCpre3q
         XdYPXaixauQ9TCHlVQ3CvEnE2FHYNH50FqFh2T9wq85/vgt/WMnDnW/ZyUhM+aBH//wb
         bOJjrA7aedUkkWYf3xaF5yiJ94ZkfqLf+nkzQ2Tn9i2mSKL8VuoiKXOmjihuQS5Jo8y8
         fSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529431; x=1796134231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXiPVtfN2wZl1+H6KM7aKPWRvFLxQP41vzviKryy7aM=;
        b=TVavu7qCKypg9zEpDQeh7ZHMukF6JGNbgznKwtoSP06ErCdrDWSqEm7Ur7/pfIEHYs
         kt3VsZDcYGE0BtY/vcNVUx6+B08QbQWQScD+e5rFCZ1G6OPwsX24l+yybHutDIJsdjby
         Y6G9Y+V0XNYG8SVj633fUV/1d0QZq5YD0SWKihvllulgVP8PqvAAq3bSvNbadv1IO0CW
         pk7+vLblkobmVrKV8tDDINyWeKvHcVSXDeMDqJYGXVNsjGIry1X/XXEG9YtGTgIO0RYs
         TxUIfXgbqlB5FCmGD8eGkVlS3GUBmKfS5l1k0Mk3Vzo35lI+HjoXlhbWlcHR1k2ieZ9K
         Os8Q==
X-Gm-Message-State: APuU4Z/mHvocaKE1ladmr5idIL04OdEV6pcpuK3aGhR9c+Md5RlwBdJ9
	Cc+NtAcXh9cVHjMkRQwRlI4OLf3vJMIfpRewU+FHWo7eihJYlQREFuNmul5EDc5jj08=
X-Gm-Gg: AZFdTZf2vjrGHbZ9DF7HkCVRwAoZdHqosuq4eaQ5+j25dG2dUSU8H/k17HEBnpqFoXV
	H6VBsRfOnY3MDAAtEQQfr4VuZGhik/9wvhzwSRGWMnr9YR03EUX57rtueMWMPuj3uPjeLP+mm6j
	R+mdtLBGOqK/9VgYwTFUxfQJHdZ1NKDeInDVRsmzvGXIHlWG7PU+FKqXZuK5p9Zny5GC2bQtmX2
	9DDOHqW4ktfEChPyYCnenkgm8DppbzuzYCc/Q5nb21UqL9/HpacsExG2u2NBqCIqJah5mmX89tj
	HiOmKzA35wNzZ52QxjTP38n41MkkJZntEEjEBXtEzBiwquWdMWEtXaS9VjriecW72itGtLlwpxY
	Z3JdLSDiBwVf7B8pRWqaVJlkTVQuTKSKfaZTeBCkyo2PXUpu8M1ZfGnutNfnx22x+3PwYDSYvID
	3XBisW2+ff3ZpysusKz3kuEhRJkbIlXv038DQRpZZNUac1DBeDl9qFhXntFKBucYIT9S7mwbHKK
	R7NN5KFXaQ2OkclaybZhOc7F+BOhgHHkWdVkqrnTsXQHgfkvRHXHbCTM74p+Y+Lv3umX9EbtfTV
	jz06uAZVUetl2YNSTX0tzxln5AiqlXap
X-Received: by 2002:a05:6122:628b:b0:5ec:e6b8:eb94 with SMTP id 71dfb90a1353d-5ee8aefcf60mr8116807e0c.12.1795529430568;
        Tue, 24 Nov 2026 06:10:30 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b555137sm14056121e0c.3.2026.11.24.06.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:10:30 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: fix bonded LE peripheral reconnect completion and holds
Date: Tue, 24 Nov 2026 11:09:54 -0300
Message-ID: <20261124140956.15296-1-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two interactions seen when reconnecting a bonded Windows
central to an LE HID peripheral on an Intel AX210 with BlueZ 5.88.

The first patch preserves a synchronous terminal-event waiter across an
unrelated command reply and refreshes that waiter for the next synchronous
command after timeout or cancellation. The second keeps LE discovery hold
ownership in its completion callback and handles both encryption and key
refresh setup paths, including failed setup followed by a late event.

Changes since v1, following the public Sashiko report:
- Refresh the saved request from a callback-bearing synchronous command,
  including after timeout or cancellation; retain Reset resend ownership.
- Handle the BT_CONFIG key-refresh path through hci_encrypt_cfm().
- Explicitly abort failed LE setup and prevent later feature events from
  announcing that aborting connection as successfully connected.
- Rebase onto the official Bluetooth master at 4fe38719e673, rather than
  the GitHub workflow branch used for v1.

Local extracted-function tests pass 152 dispatch and 62 lifetime checks
with GCC, Clang and ASan/UBSan. Both the unpatched tree and v1 fail the
new regression cases. These checks model kernel services and do not
exercise concurrent workqueues or a physical controller.

A full kernel and modules build of this revision on the official base
completed successfully; that upstream build was not boot-tested.

I also tested a backport to Linux 7.3.5 with the same configuration used
for v1 and upstream prerequisite f3183d7ad101 (Bluetooth: hci_sync: Drop
the command's sk reference), already present in the series base. Repeated
bonded reconnects, approximately seven hours without observed connection
loss, and disabling/re-enabling Bluetooth on Windows passed.

A hardware trace confirms encryption can complete before remote features
without prematurely completing the feature waiter. The short HID test
sent 48 reports. In a teardown run with 20 seconds of post-exit recording,
Disconnection Complete arrived 137 ms after Disconnect, with no observed
command or connection timeout. One earlier teardown wait of about two
seconds was not reproduced; its cause and relation to this series remain
unconfirmed.

Windows suspend/resume remains a limitation: in two attempts BlueZ
reported a connection while the test HID application continued waiting
for the notification subscription. I have not localized this to the peer,
BlueZ, the application or the kernel; this series does not claim to
resolve that scenario.

OpenAI Codex assisted with the analysis, patch preparation and tests.
Sashiko supplied the review findings addressed by this revision.

v1: https://lore.kernel.org/r/20261121033104.441146-1-andreiab9019@gmail.com
Review: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121033104.441146-1-andreiab9019%40gmail.com

Andrei A. Bykov (2):
  Bluetooth: hci_sync: keep unrelated replies away from event waiters
  Bluetooth: hci_core: preserve LE feature holds across encryption
    events

 include/net/bluetooth/hci_core.h |  9 +++++++-
 net/bluetooth/hci_core.c         | 16 +++++++++++++-
 net/bluetooth/hci_event.c        | 36 +++++++++++++++++++++++++-------
 3 files changed, 52 insertions(+), 9 deletions(-)


base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.56.1

