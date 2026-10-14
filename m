Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC0522EF3
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984798; cv=none; b=rLk5wrjkDsfEymh80VFCAt1W8nSgDm51cYB/IvtsZmpk1rw74BhQiLyqfg7fKjNp4IQKuVy0WZ8liXlE9wa0RKt+wDGZTRMYNT4KeB2fVNTuqVwwc/BL3mkWCKkykfkA8Vlr8J0xO5VSYOaLchERS2OMELNOLaZ8bzHCu3oXJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984798; c=relaxed/simple;
	bh=zl5qPLtG3FOVYddtq4A9L0KK3ntYJtAkmYCTfscuIsQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hzPSkjw+yexynWJhIQ5ISekYyQepMbCrhe0t0Fu0BJkPcWVEdDIOMk9ra4z9M6inZHL556mbSzmL06Lwff0DpaB+8s5THU8cAdJTZnyi79/FHO+cy8XVm4UTl6aO7+NgtHa0DM6oxPXWNYwBTrnm4DZvDsbTOs1iQ9KvgLb1YEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojWChSwz; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojWChSwz"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5352a876d5aso53645731cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791984791; x=1792589591; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XfuecOofqyCKSGayJ09BF7hx7K1CbHvJq+JxzRn/VMQ=;
        b=ojWChSwzClDvXXGIJVglxrCajYqu5ot2H3UVlVKpjOIsdPEvUfmHHP/vkdrRGtwnI9
         SM6rL5aVm4eTe+f2o4D4qMGyKluZvCOc5hWHYA4TDf5tcee7mNFbbC4g2W4urpCDXv/+
         wA9XLGPxz7atUUB74WhaLUT+CAFZ+RHnowRpKIB40g/yPup8zAVB9/YVXwitxajwNjmV
         3/UUxAEKvzV+EiU7FaPat2MSiJVzWxQ9f0/xoOr/RsemlfWSmNjeWwDZqaH0FBZHOrik
         dUERdgdgBENzb0NAk5XSRjFnBRh4ZAJ+CViwaAazo2tsvIm+nC7TEAZxERk/B1CTmDfj
         OnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984791; x=1792589591;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XfuecOofqyCKSGayJ09BF7hx7K1CbHvJq+JxzRn/VMQ=;
        b=gOTJo0hS18wnoKII4tX85K7JBkBvZG2C89r1IiIgeZ2Edcmj2CwSvRMByXDLF3tb7G
         iWbhBz5jh718GvVEycsQA8DhfTrPk50G60NPL9gM88oV9tokOncO15AZUmLC+WNUWl30
         4+4y+HKyDIB/HbXAUTwMvHFJGT+q7SqxLDe1DY8bX4EuCnWiH3af61de7s/2wmK/8vVF
         FHgijAHJVDB5HJzkJBCrqlzocueULTQWetV88Jcj3Lt4laEgZQ0LWKeLmSNv+65rDUL7
         7hXzHMsKbQBgKiOzHHny9YWjoDCacAKr7HttViEDzWHhfoNqDhU/dRStn2mXNRpjjbjk
         N7mw==
X-Gm-Message-State: AFq9FYK8GQs5SDpqK/OcYoJoY0S7+caLEhHigBILan6c7g2BUdvx6p+u
	adp2ddGuqWWBWpwRTyo6abjgKh/GwRU875kT5xhuzdEd/4jQcL2uQjF8GUIKdg==
X-Gm-Gg: AYBFou0b4ytyHFSCu7ATWH1G+2M54kNUY2NR6BnLXl1/BC7tLaLVsRkrD6I36ZRw4v0
	P3apF5vDH+y6dY64bw3O1ShkgDPzeQRVrRDzWUTI5CaxoswyjkFvYgRxGf5uAODaojfvdRPVTQH
	TXYynuAQoMGWMDI/EQI2PfQ+FkMO6YoCRXwPCnXNA9/QK+5Dja5XM1IKoBfrxTGncapSZinV30X
	VXZ0B80u26bR1KN+e/YcOlZ93wBngNBVxRxsdPbtEEK6ZT+YaThY4k79dIFnNC1RcbSNMole2ff
	n8awFJDgDTT7y1Cdb1php3fvBE9WtP4XndTvufbPY5wLxQX/yjeWKn+QkSXseQtO4060K04HpqA
	B7Y6uWYI9Hb8LX1nhKxsa8gKhZBcVjiqMfV9ilYLjA8t/TAm+ZS0hHKnvaF9fpAIyOS8pHe1FRa
	CgcFfhHeMvcSZPQFgbRMd1mjdKPUzM7A2erDAfu8T/SxgEQMUwS/04CkhHmYHKkvgMSgrjaDUIh
	Qr2bQ==
X-Received: by 2002:a05:622a:144c:b0:535:4c3:70ff with SMTP id d75a77b69052e-5359fdc2edcmr257081411cf.54.1791984790807;
        Wed, 14 Oct 2026 06:33:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm125139931cf.19.2026.10.14.06.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:33:10 -0700 (PDT)
Message-ID: <6acf8496.2d0a4cdb.2cebd6.e740@mx.google.com>
Date: Wed, 14 Oct 2026 06:33:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1104528998336793577=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] hci: add ext adv interface
In-Reply-To: <20261014-extend_adv_api-v1-1-6ad07ff280f2@amlogic.com>
References: <20261014-extend_adv_api-v1-1-6ad07ff280f2@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1104528998336793577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185477/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      19.73 seconds
BluezMake                     PASS      309.89 seconds
MakeCheck                     PASS      0.88 seconds
MakeDistcheck                 PASS      143.31 seconds
CheckValgrind                 PASS      149.31 seconds
CheckSmatch                   PASS      298.05 seconds
bluezmakeextell               PASS      96.79 seconds
TestFunctional                FAIL      1161.14 seconds
IncrementalBuild              PASS      303.01 seconds
ScanBuild                     PASS      1179.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,bluez] hci: add ext adv interface
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#102: FILE: lib/bluetooth/hci.c:3023:
+				uint8_t peer_addr_type, const bdaddr_t *peer_addr,

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#254: FILE: lib/bluetooth/hci.c:3175:
+	size_t set_entry_len = 4; /* handle (1) + duration (2) + max_events (1) */

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#255: FILE: lib/bluetooth/hci.c:3176:
+	size_t plen = sizeof(le_set_ext_adv_enable_cp) + (num_of_sets * set_entry_len);

WARNING:NEW_TYPEDEFS: do not add new typedefs
#304: FILE: lib/bluetooth/hci.h:1739:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#320: FILE: lib/bluetooth/hci.h:1755:
+} __attribute__ ((packed)) le_set_ext_adv_params_cp;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#323: FILE: lib/bluetooth/hci.h:1758:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#326: FILE: lib/bluetooth/hci.h:1761:
+} __attribute__ ((packed)) le_set_ext_adv_params_rp;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#330: FILE: lib/bluetooth/hci.h:1765:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#336: FILE: lib/bluetooth/hci.h:1771:
+} __attribute__ ((packed)) le_set_ext_adv_data_cp;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#340: FILE: lib/bluetooth/hci.h:1775:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#346: FILE: lib/bluetooth/hci.h:1781:
+} __attribute__((packed)) le_set_ext_scan_rsp_data_cp;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#350: FILE: lib/bluetooth/hci.h:1785:
+typedef struct {

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#353: FILE: lib/bluetooth/hci.h:1788:
+	/* followed by ext adv set entries: handle(1), duration(2), max_events(1) */

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#355: FILE: lib/bluetooth/hci.h:1790:
+} __attribute__ ((packed)) le_set_ext_adv_enable_cp;

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#369: FILE: lib/bluetooth/hci_lib.h:115:
+int hci_le_set_ext_adv_params(int dev_id, uint8_t handle, uint16_t evt_properties,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#372: FILE: lib/bluetooth/hci_lib.h:118:
+				uint8_t peer_addr_type, const bdaddr_t *peer_addr,

/home/runner/work/bluez/bluez/src/patch/14888331.patch total: 0 errors, 16 warnings, 282 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14888331.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f96f1756510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f96f1756510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
            return getattr(self.plugins[name], method)(*a, **kw)
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 502, in expect
            ret = self.ctl.expect(*a, **kw)
          File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 354, in expect
            return self.expect_list(compiled_pattern_list,
                   ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
                    timeout, searchwindowsize, async_)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 383, in expect_list
            return exp.expect_loop(timeout)
                   ~~~~~~~~~~~~~~~^^^^^^^^^
          File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 181, in expect_loop
            return self.timeout(e)
                   ~~~~~~~~~~~~^^^
          File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 144, in timeout
            raise exc
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f96f1756510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f96f1756510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2677

---
Regards,
Linux Bluetooth


--===============1104528998336793577==--
