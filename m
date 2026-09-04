Received: from outbound.mr.icloud.com (mr-2005e-snip4-8.eps.apple.com [57.103.71.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E5339872
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.71.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557818; cv=none; b=AA8DoG4GjkU7iRgLybc1pra3GIJUAfuCEK08EAvuF+DEadv55g6Sqw+UiZu1f3gOLA/gQYiufiG/EKpU+RSe/3eTovMdOSb6J9ayshUZyUsyfGc/g2BUX/d6soomKz2pDD3mTnn6xpEfUvec7+idnHYwWjJHl1VB3ZDWs3R7Rqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557818; c=relaxed/simple;
	bh=fq1H/ITq/3DxZ68YX1HdL4mjA9fHpTNedGmhUcsQQrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNfiaqczyp5OMF+isGTU8uoLB0pL+HC/yqTM2etO99Jcx68lt0MYnv6oj8XPoubozvDN8J/9aLQosxwhJ6FzGj/06AsR7rpX7a+m8IfGei4NH1nsRpNf7zL++smf6SjYhiRYzDYUi/emBrYxlNJJKS2yLSJgsbt5IuFqPeO7kuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev; spf=pass smtp.mailfrom=proxy-alt.dev; dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b=CznDXNnN; arc=none smtp.client-ip=57.103.71.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b="CznDXNnN"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id 9D90C18002CC;
	Fri, 04 Sep 2026 21:36:54 +0000 (UTC)
X-ICL-RepId: 01a06e5a-6b1d-7e6a-a98e-8aaa4c4883c9
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHV8DXRxCCkodXAFbEhVdRUMfWBNLXVgURy1HGV0IQFVSAUNFVhVPWFUJChtAH0EBHgxbHxwUXA4TH1RWAFBRHV8CCgRHBFsXRgNTRV8CFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDwBLF0sUGgpeBBccVhsXBlsUBEQBXQVdAkkJTAFcBF0GQhdOC1oOWR9CFAhBAk8SHxFVDHMdRQRKCRQZXxkZD1cGB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proxy-alt.dev; s=sig1; t=1788557815; x=1791149815; bh=vhOXXBrk8PxGKUMOAt6wHAJ+w0S2yseA9A7491OGqug=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=CznDXNnNpDMc/BCOZRDxjvicgOE3l1VjCivg4J5Exoe91UAotgf6nyS4JJNbsKVeshkmYJgoyhuiPcJG+/4H2b0w9HxTwdmM9qWer2xtzyGJWqOOD2rbjW1JGRTS02BDIaRoMbg7zkSdgyiGxD2cmsfeq7+fBH8rSuqBD627XXpoRdjeExtPBu668QpFlg2qhKgduWEtvVSWbfrOkUYQCHJWv6zP9U1RIafP8r2lK/pFfLetyKxdZx8gScsN4GlhPM6jw5xGc1QLmCJ558PSvNfc1r9X74XiP9Zffs8Bo4Gc1cdzqwUi89cEMyPs87OIdd+2vK8UdY+Ip+TwJO1fAg==
mail-alias-created-date: 1786144344056
Received: from localhost.localdomain (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id CBA191800129;
	Fri, 04 Sep 2026 21:36:51 +0000 (UTC)
From: Proxy alt <proxy-alt@proxy-alt.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Proxy <proxy-alt@proxy-alt.dev>
Subject: [PATCH BlueZ v3 2/2] unit/test-micp: expect the FIND_INFORMATION the CCC fix adds
Date: Fri,  4 Sep 2026 17:36:42 -0400
Message-ID: <20260904213642.68792-2-proxy-alt@proxy-alt.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904213642.68792-1-proxy-alt@proxy-alt.dev>
References: <20260904182833.59624-1-proxy-alt@proxy-alt.dev>
 <20260904213642.68792-1-proxy-alt@proxy-alt.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwMCBTYWx0ZWRfX1j8ouLjMPMFT
 n/Vi2VNN55N+Oa+3dYMvXn8Jx0eLgVo0sp7npCtCB+aTa0DMbH9nctoZuAQL4jgq/VdbxsaPddH
 8fOdbB4uWN+XRcHUaP8apDo9e9IOc/K1corgaROO8kgBZL0M7KRTp1j6rFnTnT6V4LaSlxhAdFq
 HdoHsVeMiHnVX61hofv32w8I/HnXMiwdTXX3PmjzdoGXGCaKE3WjoAGDd7u5zd32KE/xS7T9XLm
 m9LIHpSZNN30sVlKSlu8RMuWq6e1udil2AoTQ9b2cOMiRTYdhC4xFL2KEfLsKVnhdATEOY8yYcY
 QGmVHI97knUSoYBj0WMOahN2ZPPNCi8myc3X8vkRNzN0D/5rVYLZU3NWnQFcJU=
X-Proofpoint-GUID: ucYEEQInOSnYmAnOyLIw11UtGNVKjyVz
X-Authority-Info-Out: v=2.4 cv=QOBlhwLL c=1 sm=1 tr=0 ts=6a9b39f6
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1qvH1PtQXffjxXuNSIUA:9
X-Proofpoint-ORIG-GUID: ucYEEQInOSnYmAnOyLIw11UtGNVKjyVz
X-JNJ: AAAAAAABJxcS2sXceLo/6CDZSCA8tEsXtSiuuSUZF96VKz/5DVONOOIfUPbCMfZ5IVLpp4p5oTLCqvK6VkezqX3IZU+mMfmhTPT6wIJ4epefFDT3ssamXCPPWyrqww1o8cE2I2oQ/7f8JDczh/KFbibOt5gI1rc5d0nDlhk++FsgfcNFENcpekUYeM0bk1iIS0u5De8Q8Ir4BBZgjpqMoiVoCPT76vwmQsXZ4B7tCsf0HzIn/khF28LNa1MrYpwHDa1JkAR+/83dmYH5qKSyNXMvw+sXE4/oLgdJtX0c0eTEURp0VVhdzkn+rRi84Ji1WLwd/9n4N3LL2HGSk9wSzL1KDES3GEcEiPOMj4aAspDOmBQNhhJhIU57BMwbzXcLrfgifv4LjiwKCu2mlWIwV8nmqdwsSjsD08DYaQy3kGYtGOrEvhh/dpCL4YczqgQkcXL7eZdzEVugC1TqUPgzBi6Ydwi/k+1gHNI4U+12GxXNCtnI8QQ/YGqTrG+Fm+tNKQQzcZGtMh+ppjAk7k9ThP5Z7AeV6Tcfy7licQrv9oj5Bg8XeLNpHsqcbJe1Tg62WBWU9ELr73CVldUVbEnwilnJO0Vy2dfv7FJOeZ2n9sai/N1Yms2kXTx6miz6X/nmgDO66SSNIrJlfoyS+YEbUbpIXWP+tfwW2YUWLiyw5wkB2abiA9YpsGqrzS6sZTHcoqX47f09yPpfkrjXKoP1c5P4tba+phBcerJuVxLKZFW5rkGxlJLIl4xlLXhLc0DTaMWN4ZncxuldFkVkww==

From: Proxy <proxy-alt@proxy-alt.dev>

Companion to the shared/gatt-client.c fix (bluez/bluez#2383): the
lazy-verify patch adds one FIND_INFORMATION exchange before the first
CCC write to a characteristic whose descriptor discover_descs()
synthesized. MICS_MUTE's CCC (handle 0x0004) is exactly that case, so
the three client subtests that drive it now need that exchange in
their scripted ATT sequence, right where register_notify() actually
issues it (after the value read, before the CCC-enable write).

Verified: ./unit/test-micp passes 7/7 with zero leaks under
LeakSanitizer, against the corresponding shared/gatt-client.c fix.

unit/test-mcp.c and unit/test-bap.c need the equivalent update for
their own synthesized-CCC subtests; not included here.

Signed-off-by: Proxy <proxy-alt@proxy-alt.dev>
---
 unit/test-micp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/unit/test-micp.c b/unit/test-micp.c
index ff17300..2229642 100644
--- a/unit/test-micp.c
+++ b/unit/test-micp.c
@@ -455,18 +455,21 @@ static void test_server(const void *user_data)
 
 #define MICP_CL_CGGIT_SER_BV_01_C \
 	MICS_MUTE_READ, \
+	MICP_FIND_INFO_REQ, \
 	MICS_EN_MUTE_DISCPTR, \
 	IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
 	IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x013)
 
 #define	MICP_CL_CGGIT_CHA_BV_01_C	\
 	MICS_MUTE_READ, \
+	MICP_FIND_INFO_REQ, \
 	MICS_EN_MUTE_DISCPTR, \
 	IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
 	IOV_DATA(0x013)
 
 #define MICP_CL_SPE_BI_01_C	\
 	MICS_MUTE_READ, \
+	MICP_FIND_INFO_REQ, \
 	MICS_EN_MUTE_DISCPTR, \
 	IOV_DATA(0x12, 0x03, 0x00, 0x01, 0x00), \
 	IOV_DATA(0x01, 0x12, 0x03, 0x00, 0x80)
-- 
2.54.0 (Apple Git-157)

