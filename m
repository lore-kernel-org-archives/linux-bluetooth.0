Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BA282F29
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428653; cv=none; b=N+43zPMbQM1Wh5Yi78AQlaxppwWcdgAC6/wBHgQ0+13lglAldW33r3m5oG3TzpaLIxXDxHNhpjPaRVLeyUWf14LxUJ3921G7HvW5xMHvadASUy3X2779lqA+PBTzkojwgltehfv69Qy1RoMIAVd3FGC09ZP7mnspyoNckQs7Yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428653; c=relaxed/simple;
	bh=atR0XpZP9pcCL/1G4MiaNO3xPiHFFJf45wFmBBon4EA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WoP0INsn1VIcpZS2YlO+/snuD/HHfhExzkomK7/WnBVxRJegF4XIHU2DL6CTd6BmNl5nf8aporE/Wak6sKmNmdGLPLiJeaXy10fuyPhQZ5M+p81FuXzjMdWIV1bJqZ+rkwAjFLsM3o9C1AUwl3ALe2W02qJBqzauZOaFXrXwO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pV/VkJA3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV/VkJA3"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so2709067a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 16:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789428652; x=1790033452; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hBaZ+TDia6IWPwr1bN1YosW5nfUm1paE9cZZI2RCPWk=;
        b=pV/VkJA3Msq4XfnAmD+AAmSdrItqdqvuqLrR/nZwVKf8AwyqaXIy/BrbrAuaUlWv7a
         pAEIm+yq5bIXSOgoPiQWnYZeRBjHVR279us6J4/sr9civcSX+DucwgCIsgKFgafx6EGa
         +kq95Al+rSD5XnFfFOJFL0gfaIqz6We9V4rqso+MHhj9bhCHwRtbGfnci1q0Wvw3dTe3
         fTzBCsPvnKyc1rlWhkevYyHo9F67F0jD8fhkdN7Fjgj3pH2j9njLIBlo6CdTPoSrYTDQ
         RZFCb/SlrNPOCgHWcWwpag+dCmdEPWl/QffV0PIE1iFPJC+Ptgvg09KFeTRut22uhbTe
         Y+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789428652; x=1790033452;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hBaZ+TDia6IWPwr1bN1YosW5nfUm1paE9cZZI2RCPWk=;
        b=gCSBBOm1aIjSa7wKY5utf7RlL5BJ7oQyUf3uTAXQLrejocceYqsVeCK3FrNwpXXjjF
         T9wesJCHtsnN6UhOjOURdnHhvFqTocl0tL7Lr+zlLXpnYPd9sYmnfaVcdQMRnPhJLuXz
         6R0C84xSOJ/aMCcQxtUu8T55JNIpyW7fOChiaEk+Z+CxBBu+AnkrJ9QWkoDWHjZLLv9j
         oywW8DHVrtKRhIy8WmzdfI34YbF0qmHgjGI2iDqda5m/OhMAzuld0Fixde6E4TYqPOnh
         C3hv2F4za4j5S6np0Y70uDVI7xl9s1DtgI8uKl8qCQ1qy9HtHFjjCVWp/M8/RRKdYGGb
         YQAQ==
X-Gm-Message-State: AFuF++ka90q77xCVYXox5VPqz/XqbAJsAAkcOOljiW6+hYWpYqNgyFHB
	VN9uvxwL88LhmhPzbHn0QwWRIOccaYKn/zKY9SM6r0r+sT2LCO1XTMJC+116qQ==
X-Gm-Gg: AYBFou2F3sw0Lt4zs72sk8B1fYO+DYkOBoevnypH6Caj4syV9guSY1vC5fK2uetICir
	au/0tYFn7v/iPLt14qd+Rkv3JmME9Chw/mJ9lOuw7+LfFI5Gii2kkqVmF9gBMyk5OOFcyBX4hMn
	pJVGVagLNMx96OkaaLBuJMuWILZEfGcMIgyenH232mzg+A0Vfh1xbD+LnPmJ/xwJfEBkxXHBhHk
	oACOFqINEz0RAl6JpI7erVCyXE2E7F47Ctt+191S0EQqivjuU9aX2ZV6+tIufWrrggf678lGna3
	J23d8Mz8McRlZHcegjZiHBETpUt/d+4/bNMtHWK2deb8DUNVfFPDlzS+o6JjYaJhOTfK607i7b+
	ZiYj4jkbWMLxjrTUIpNOCTidi/PDt9UCoAVVkeJnKesbTl98uBct48UFfZN1IianwjoIySM+QaL
	/88e1mfy0IZrCfexqr/bELLOOmnuvofa/dUgl6lYk3u38AbsEy2e6AY694bJx31uPk3vPIo/tGo
	KL0XQX77Ln/Ccjs
X-Received: by 2002:a05:6a20:72a6:b0:3bf:b84c:2984 with SMTP id adf61e73a8af0-3db4046c3a2mr9370340637.11.1789428651562;
        Mon, 14 Sep 2026 16:30:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.229.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f5833fsm34699323eec.23.2026.09.14.16.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:30:51 -0700 (PDT)
Message-ID: <6aa883ab.1ce3d5fb.ae9c9.b59a@mx.google.com>
Date: Mon, 14 Sep 2026 16:30:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6680436996330007981=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] doc: test-runner: document the virtual machine architecture
In-Reply-To: <20260914175136.613532-1-luiz.dentz@gmail.com>
References: <20260914175136.613532-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6680436996330007981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164802/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.41 seconds
BuildEll                      PASS      19.42 seconds
BluezMake                     PASS      371.20 seconds
MakeCheck                     PASS      14.23 seconds
MakeDistcheck                 PASS      139.01 seconds
CheckValgrind                 PASS      232.65 seconds
CheckSmatch                   PASS      290.59 seconds
bluezmakeextell               PASS      95.03 seconds
TestFunctional                FAIL      1057.13 seconds
IncrementalBuild              PASS      389.26 seconds
ScanBuild                     PASS      1125.63 seconds

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
FAIL functional.test_obex::test_obex_ftp_list[hosts12-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_obex::test_obex_ftp_get[hosts12-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
FAIL functional.test_obex::test_obexctl_list[hosts12-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
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


https://github.com/bluez/bluez/pull/2528

---
Regards,
Linux Bluetooth


--===============6680436996330007981==--
