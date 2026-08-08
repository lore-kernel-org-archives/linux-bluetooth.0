Received: from outbound.ci.icloud.com (ci-2004k-snip4-11.eps.apple.com [57.103.89.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE5835DA77
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786162602; cv=none; b=u1V63o4lXkhraYfaxjuO4tP2L7jeQBwYwJUxFn+0RqYR0gidmxxKLuW+MveggY+cC9YbybG7eWfR+VH6ATwZI8TsrvyWD8LcYAnw52gQW9gNoM9Dd7N7Iukb643fS7Dav+LYjvE1kUgQij1GEuXYXO14mdVQOmMWnYBjJWX2Dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786162602; c=relaxed/simple;
	bh=g7d/prbK2/z6S2bLj7HJyMTJiL9Ge+lglYmNpeRowrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hED9ITil70pLhV+bz/eHD6hHPOV52gIUeflX9BfKGwgGemfLHnWnEmNvmZ8cO3FjiN1nhNU4+iHxDwLu1pxXw0dC9wHaaYKls4bqLY5Q3Ct8wuuropkaJcJR83EF0AbahKsunXkLgdBb354xyxnSJp0bIiFmTCCwomuw+nX6VII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev; spf=pass smtp.mailfrom=proxy-alt.dev; dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b=QRjYRgIZ; arc=none smtp.client-ip=57.103.89.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b="QRjYRgIZ"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-0 (Postfix) with ESMTPS id 5C3A8180012B;
	Sat, 08 Aug 2026 04:16:37 +0000 (UTC)
X-ICL-RepId: 019fdf96-4dc9-7e5e-9f04-0cb70b44168a
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ5JHV8DXRxCCkodXAFbEhVdRUMfWBNLXVgURy1HGV0IQFVSAUNFVhVPWFUJChtAH0EBHgxbHxwUXA4TH1RWAVBRHV8CCgRHBFsXRgNTRVEZFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDwBLF0sUGgpeBBccVhsXBlsUBEQBXQVdAkgJQANZBl0BQxdOCl4EXB9BFAhBAk8SHxFVDHMdRQRKCRQZXxkZD1cGB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proxy-alt.dev; s=sig1; t=1786162597; x=1788754597; bh=UZCT8NW0xVC4WNU/ttySLkaGBycu0HHtAtf2ATVIqDQ=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=QRjYRgIZSKBAqKS2wqRPTRlHbdNOc5aTbNzT1OrMmmM4PS2nnTwtHtE8qQdma901tlTrrfZ6mfSb2+f1CybQwz8lo4Xcg3cG3o/wucCNEiJs94oVrMfqluEVkH84cWGwqB9dUspq0CuPfT9Kh5Sqk4/DByyUI/0OD+UWM7ZVLk5s1NrL21k/uZD4Tl3Y+4zXb41gfaAMU8p+Jr/1bPVRNoQm2BoQMhGypHQaNA9qdwP3NF3dvi4T0GmQcCikO2oOpzWldCKv2mjlCRAI3G3AHOS0spZvKvsMtzptdMJuZXePK+LvpwF8GtyPQS1U0nhuINptHbj11YbZNgy/6xh4Kg==
mail-alias-created-date: 1786144344056
Received: from localhost.localdomain (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-0 (Postfix) with ESMTPSA id C5CB9180009B;
	Sat, 08 Aug 2026 04:16:36 +0000 (UTC)
From: Proxy alt <proxy-alt@proxy-alt.dev>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Proxy alt <proxy-alt@proxy-alt.dev>
Subject: Re: [PATCH BlueZ] shared/gatt-client: discover the CCC descriptor instead of assuming it
Date: Sat,  8 Aug 2026 00:16:33 -0400
Message-ID: <20260808041633.69337-1-proxy-alt@proxy-alt.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808031940.66686-1-proxy-alt@proxy-alt.dev>
References: <20260808031940.66686-1-proxy-alt@proxy-alt.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2bwRZ0EZHYhBy5dvoYJebpMYWxqbE3LB
X-Authority-Info-Out: v=2.4 cv=TLNIilla c=1 sm=1 tr=0 ts=6a76ada5
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fN7Wovw5WoxFwK9X2xEA:9
X-Proofpoint-GUID: 2bwRZ0EZHYhBy5dvoYJebpMYWxqbE3LB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDAzMCBTYWx0ZWRfX8eAJbUtTO9y5
 hep9BPwD02O2BMpaVZ0wyLzEw3VN7MA1Ga5QFwxhW+hFIjFj5HeYOg4p8hJaK+xANWThHd400DP
 HwVCzgmcHjVjFpjNefX5jQmscGjU5j5g6+pSzC/lRAryoTYcwnYR1uuh/u8GHP42fYF5trS2w49
 0g9CAhiVRi6KbhtsnSQdxsd+iGCinBw8GFaQA+dwaXz4Zu/WfwfaAtw53NEj8u3Xt/lt7Q1Uzqy
 RQQ+/a7B7J9rlkadsR1XfBjPJ4ijEQ0NvNHuYUKB6WBUf/qBMBhubIGNaUBcQCdmOok2r27iZiN
 nz6TKD60ljpFGIRVBjqVk4S9ro/Stfvm13iZWTTYOjxdMA8VmCLnLxPmie3yK0=

v1 breaks unit/test-bap, unit/test-mcp and unit/test-rap. MakeDistcheck
caught it; I had run unit/test-gatt rather than make check before sending,
which is my mistake and why the commit message says less than it should.

Those three profiles have notify characteristics whose descriptor range is a
single handle, so on current master the synthesis fires and no
FIND_INFORMATION goes out for them. With the shortcut removed, discovery
asks, and a 5-byte FIND_INFORMATION_REQ appears where the expected sequence
had the next operation:

  ERROR:src/shared/tester.c:990:test_io_recv: assertion failed
        (len == iov->iov_len): (5 == 7)

Everything after that shifts by one exchange and the tester aborts on the
first mismatch. unit/test-gatt itself is unaffected - 192/193, identical
before and after - but that is one suite, and stating it in the commit
message implied a coverage I had not actually established.

I still believe the change is correct. With the shortcut gone,
gatt_db_attribute_get_ccc() returns NULL, chrc->ccc_handle stays zero, and
register_notify() already completes the request and registers the handler
locally without writing anything.

That is now confirmed on the affected hardware, using tools/btgatt-client
built from 690c16d, same device and adapter minutes apart:

  before   descr - handle: 0x0013, uuid: 00002902-...
           < 12 13 00 01 00
           att: Operation timed out: 0x12
           Failed to register notify handler - error code: 0x0e
           Device disconnected

  after    discover_descs_cb() handle: 0x0013, uuid: 00002901-...
           Registering notify handler with id: 1
           zero writes to 0x0013, no error, link held for the full window

So the device's real attribute at that handle is a 0x2901 User Description,
and once BlueZ asks rather than assumes, notify registration succeeds and
the connection survives.

v2 to follow with the expected PDU sequences in those three tests updated to
include the FIND_INFORMATION exchanges that discovery now performs.
