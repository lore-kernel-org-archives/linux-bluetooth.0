Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584017BC5
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067575; cv=none; b=N+hHDGIZa/vdR6L5Ip+JoyXG6UBzCWosNz0aLolCJ3YIKemGLC3I6EnqaXtztFQ5fzV97bZI9xdgAovbLqm/7U3wFw3hm/5jjLH+/lRR+wHHFgi5swSNTCotIrGqGivVg9Lyw5Uih4ecdPDTI00qb9Ng44E7+enZExAtYa7A6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067575; c=relaxed/simple;
	bh=L1+BlePQLdMeAJbsj3GxS3+KpGvg5gbHw1kug+/beZQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ADG1W4LWOPL0bnVXGPULsTcWknZ0khmWEtQoLTFhGmUEh5/UBTJ0fj56DQyTKmdzwU2HA/oO15x0LYd6CUVPYSvi6iS6EZw4Y3qRJ9ebeGEeccAcfUSKndKrQkjeUsVtT0Mw1TwVP1q4CW9ezhobCDBf0/kInanxwIVLC8DZXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIAQNkY+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIAQNkY+"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-429de32dad9so9844421cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 23:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708067572; x=1708672372; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zBSJmxIvzPtOD6epPFQKRil1Muaq9OvDivaZPqFiL2o=;
        b=KIAQNkY+WH1P7zO3n93uYM/xywnx8P8sNVcg8KTh/nWjKxdh0VFnS49I0DUuVyXkfY
         ++y0dugP8/IwyNmWb2gFSeFoMWv9tsP0MA1ZEMnjhKH88iidKKB3utxF+GIzH8ezaWA6
         BtXirr/c7gKqvmUFY7P/QipEkzZtCaHX0lKViocgg/2ao8+TVVrPLQ3BE1uN0o4ILWXV
         X9C7+yWRZSZGZE69oQo7DCyhoFJh2bwWF+ICGQlk4ArmUAkd2FCo5oI5otF4Ce/9fFBM
         Nm/Bmc2/7QkAiXGRyH20aEFM8EAWHIVwDngFGIkqrEMboULTNr/slx/YA+V8q/eiPx2N
         Lr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067572; x=1708672372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBSJmxIvzPtOD6epPFQKRil1Muaq9OvDivaZPqFiL2o=;
        b=pyd0biU/d0tGfJWeW+a1oH9URT90mWxfbgHzOMU5HEsEx1dJNKGU+E5jOajgss0TT1
         hICFSf4DlZYOZ3Bpfk4+QUisN4EuX/ibUywJxfqSzthGZDgcAzmUPWcW9k+RwqSPsTAX
         cwW7y9jMSkCPj9CIcDx3ibIVDjaM51nSp8gqHW2G4ZKUJkBSq55pirpJQYsZKJ0HPJjR
         LEsbWBSW9rqs2JZjBI7QJKVAjazqemOnRewQUm01QLgnvD7GOGHfcF21RWlGIce92uCe
         8kGwIKj2w1EIf7OAu25JUb4wl34oATKM++TFs4EsY7y7ugilNK5Ga3xfPYJtpji5pXuQ
         lqVQ==
X-Gm-Message-State: AOJu0YyODQEg4xc0mZ2WyBLhhirEgp7G8aKvsJGzAuiXGaeuQgnu4p4A
	cRELpC9hy4A2pOBs7PSHIOWPGnHoluiRN13t4qR/q+fr7FAX3la1zGcJ1bVAQbE=
X-Google-Smtp-Source: AGHT+IFjkaomxbUtjkZkiJQ9kP1C66ulrOew08c7x0d2Lt3bOK8hmfpqIgL2huf4g4ePEBfQf8FUtA==
X-Received: by 2002:ac8:6e82:0:b0:42d:d4b0:69c2 with SMTP id c2-20020ac86e82000000b0042dd4b069c2mr2565611qtv.6.1708067571785;
        Thu, 15 Feb 2024 23:12:51 -0800 (PST)
Received: from [172.17.0.2] ([172.183.155.27])
        by smtp.gmail.com with ESMTPSA id e25-20020ac845d9000000b0042dac47e9b4sm1292231qto.5.2024.02.15.23.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:12:51 -0800 (PST)
Message-ID: <65cf0af3.c80a0220.3a82.6c45@mx.google.com>
Date: Thu, 15 Feb 2024 23:12:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4496080293085562898=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shahid.bashir.vichhi@intel.com
Subject: RE: [v1] profiles/audio/ccp: Add initial code for ccp plugin
In-Reply-To: <20240215225008.3996772-1-shahid.bashir.vichhi@intel.com>
References: <20240215225008.3996772-1-shahid.bashir.vichhi@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4496080293085562898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826656

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      24.21 seconds
BluezMake                     PASS      750.96 seconds
MakeCheck                     PASS      11.61 seconds
MakeDistcheck                 PASS      167.44 seconds
CheckValgrind                 PASS      235.84 seconds
CheckSmatch                   PASS      340.89 seconds
bluezmakeextell               PASS      110.94 seconds
IncrementalBuild              PASS      696.23 seconds
ScanBuild                     WARNING   1007.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] profiles/audio/ccp: Add initial code for ccp plugin
WARNING:LONG_LINE: line length of 129 exceeds 80 columns
#218: FILE: profiles/audio/ccp.c:100:
+												 btd_device_get_gatt_db(device));

WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#313: FILE: profiles/audio/ccp.c:195:
+								 struct btd_adapter *adapter)

WARNING:LONG_LINE: line length of 100 exceeds 80 columns
#324: FILE: profiles/audio/ccp.c:206:
+									struct btd_adapter *adapter)

WARNING:LONG_LINE: line length of 115 exceeds 80 columns
#356: FILE: profiles/audio/ccp.c:238:
+												ccp_init, ccp_exit)

/github/workspace/src/src/13559560.patch total: 0 errors, 4 warnings, 259 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13559560.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
Makefile:13722: warning: overriding recipe for target 'install-data-hook'
Makefile:13717: warning: ignoring old recipe for target 'install-data-hook'
Makefile:13722: warning: overriding recipe for target 'install-data-hook'
Makefile:13717: warning: ignoring old recipe for target 'install-data-hook'
src/shared/gatt-client.c:451:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:696:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:993:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1099:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1291:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1356:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1631:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1636:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2140:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2148:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3237:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3259:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============4496080293085562898==--
