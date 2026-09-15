Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA873CF1F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437338; cv=none; b=GLc7ZJP36vpaMged7Ti6gwMUT++j6xyyY0q4QHBuZntgM8+Ir/kLw3pgV5sImacJux1tjpRuowZis8AbM3c9lhKtCBNRZzZcc+l5560atNH0JkO81z12vdF0js9YOIiNH8Ic16mX528U3SFCEJ87LdalKkCHr2z0KCK+84vCh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437338; c=relaxed/simple;
	bh=eH+i0RuQVzGFkpGIYWZzIsbKGPrjqhliiVJgDhqaOd0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D1IN71/8MSpXXNz2uAOOkXqxr0v9RHeYrCDm2WznuKdUMTQ8dCtl68LY07AiJrWwYhSs1KajkHB8F+wjruCQ+cHDHlRnpWcrj+wt/1MWiRkIvaGYjcYnb8qj5LM/7GSRuTQ9An5KHrWt8EJQyB5TLJzM1YCvUqpgbw5h2WH3LLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfQtEytN; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfQtEytN"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd7so271181385a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437336; x=1790042136; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=36K99Lk9dZNl2Xywinavz9Gqy8dSU6xQOV70ZrSN974=;
        b=lfQtEytND5t6lfA1jro00XrMh1lyZdDl2r1irHIq1ew2lpKnKSVtzZujvXsSM7tnrN
         gPsxi0dPoNKGBLlbPR15vZo2Ur7WHIIVGM0/T9NeetiDSuWvZV6Q2sciG85E+QMkS87j
         8bc/7pX2X6j5/Pw+iinKLRwnLnF7TsThAkhN7d/L48Ddi8CzlIAgtYcKMME2OpmwQCvF
         GnJfHhAa87cV327YuQM67kWy/BnlB9/67OMaDcFu+AIzs2hIFcuNa6wxxBg26X3ZgHqq
         gUcKU0zBugLvqYPjmu6BWQ/ogxyyGDy8100esXJ+evcwcrCOxC4w6Bufatz+icQ7el0r
         ip+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437336; x=1790042136;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=36K99Lk9dZNl2Xywinavz9Gqy8dSU6xQOV70ZrSN974=;
        b=aZK5lBDmHvBeEcsKdHv97u73MItasIS+WLczTVHkhyzkRHT68hsTRnex3vXvAMhICp
         FGO6bLNVBRtFMLGkAkfJQG/yUz89vsNLVjVucabYpP90VpHco7JQBQCqKeI52wYMs5fU
         BRuzRgn6Ep4eNeq6t6GfOCInfgvINXsoX/pwP98vd7oWfeCLERW+WERctHkoNk8ALafC
         R64uLY96FWAkJvocA5uUQm/910XQpRFwJubnU2MNVNZ4uQFJJrSQgaeVSJEuC+Nz9ktn
         aIQ5CRR5jcIhz4mY3OYSTSZ+bz+vY90/YBWJc+FVH6sn3QkapsWLu5kGMaVpjtZb/EoJ
         FmyA==
X-Gm-Message-State: AFuF++kfP8s1t4FHmSQ9C9YsJhxoMS7SaV0A7lbKrs4PnqhMgLFn7GGS
	QVtnMl7Tvoq9SdIXucxlOuFTxJHOmMo9Yr0YMHYBHxbdb5mhpPKb3hJjoMRqMw==
X-Gm-Gg: AYBFou3nVj8mIjCHX50VNs6saC97Yn0OrbxHkb7OdPS2icLrx+yy+Ia8uscFQZOee2Y
	+LuDXiwsntszY7KY6j3Gm+WfPi9kpW+r1RxCrXEhDzC3M7/VCTpuFtI2PzLu8havkvDmoad7u6U
	Tt0NlJryOIDnoleo9YvSPMKnBiOPMti/PaSlR7IFE9KWzX/qNs+y/XOM6OcY9tXlaslcRIgEhvp
	iyHdgUonELAZs8dEOje6xUV3uIhvCL/KCmESkw70DV/IoUXFFQ76foMxvEDJ//0Udo1MuW1U7F0
	Ri5a1AZDpgbbiAipTU+edvZ4MJhnUMq56D0YYPyvZ93ufVQokA4PUr5mupQZPXAKlMdUygCavwd
	nex4WqlZ2jknNK0bvmNMuBjZDRturyAMrnBsPw7f5OsE4T5dwFKLdJjHVhZnf/pHhd4SsNiHboW
	RcYeQZS54eJR4KVjFS+gKjVj628BnjoN+G6st/BCvyppJcanc1gOWT+oYa4ud9D8Mtqt5T/OgAz
	jS0/zp+
X-Received: by 2002:a05:620a:480a:b0:939:ff11:532c with SMTP id af79cd13be357-93a29c0c0c2mr751551585a.49.1789437336071;
        Mon, 14 Sep 2026 18:55:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a62b783sm91745446d6.23.2026.09.14.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 18:55:35 -0700 (PDT)
Message-ID: <6aa8a597.13b7621a.73d9.e246@mx.google.com>
Date: Mon, 14 Sep 2026 18:55:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2643903051464951800=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: test: functional: add mpris-proxy end-to-end tests
In-Reply-To: <8b99b164de814997898f380e9418f8b88aec65cc.1789430529.git.pav@iki.fi>
References: <8b99b164de814997898f380e9418f8b88aec65cc.1789430529.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2643903051464951800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164934/

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.98 seconds
BuildEll                      PASS      19.69 seconds
BluezMake                     PASS      377.40 seconds
MakeCheck                     PASS      14.22 seconds
MakeDistcheck                 PASS      141.53 seconds
CheckValgrind                 PASS      236.33 seconds
CheckSmatch                   PASS      314.14 seconds
bluezmakeextell               PASS      97.81 seconds
TestFunctional                FAIL      1081.13 seconds
IncrementalBuild              PASS      386.98 seconds
ScanBuild                     PASS      1170.83 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_kernel_testers::test_kernel_selftest[hosts11-vm1-noc]: failed on setup with "ConnectionResetError: [Errno 104] Connection reset by peer"
FAIL functional.test_adv_monitor::test_adv_monitor_GHSA_hhgc_hfgf_8m4x[hosts1-vm1]: failed on setup with "ConnectionResetError: [Errno 104] Connection reset by peer"
FAIL functional.test_btmgmt::test_btmgmt_info[hosts10-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to establish connection"
FAIL functional.test_bluetoothctl::test_bluetoothctl_show[hosts7-vm1]: failed on setup with "ConnectionResetError: [Errno 104] Connection reset by peer"
FAIL functional.test_bluetoothctl::test_bluetoothctl_list[hosts7-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to establish connection"
FAIL functional.test_bluetoothctl::test_bluetoothctl_script_show[hosts7-vm1]: failed on setup with "ConnectionResetError: [Errno 104] Connection reset by peer"
FAIL functional.test_bluetoothctl::test_bluetoothctl_script_list[hosts7-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to establish connection"
FAIL functional.test_a2dp::test_a2dp_transport_created[hosts0-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_a2dp::test_a2dp_transport_acquire[hosts0-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_mpris_proxy::test_mpris_proxy_playback_control[bredr-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_mpris_proxy::test_mpris_proxy_track_control[bredr-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_obex::test_obex_ftp_list[hosts14-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_obex::test_obex_ftp_get[hosts14-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_obex::test_obexctl_list[hosts14-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_agent::test_agent_pair_bredr[accept-hosts2-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_agent::test_agent_pair_bredr[reject-hosts2-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_avrcp::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts3-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_unicast_transport_created[hosts4-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_broadcast_transport_created[lc3-hosts5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_broadcast_transport_created[pbp-hosts5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_broadcast_transport_acquire[lc3-hosts5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bap_broadcast_transport_acquire[pbp-hosts5-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bap::test_bass_past_transport_acquire[hosts6-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts8-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_le[hosts9-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_mpris_proxy::test_mpris_proxy_playback_control[le-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_mpris_proxy::test_mpris_proxy_track_control[le-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"


https://github.com/bluez/bluez/pull/2529

---
Regards,
Linux Bluetooth


--===============2643903051464951800==--
