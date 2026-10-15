Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBC260565
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068365; cv=none; b=LlByMl2+z36JMUg/K2BPScZN4KwQ4rIm8qFOdG3BmE1qAn+k1XftEfLmiiDFUyWZ3Fql8wJ13NvrvJzwnSBJ4UsIHtauFzIYWwH2KRcXM6lpSIlMlp+DASn7YbJZycWfcHvquAFnZyZbDD7gsnYpvryYIzkG4Tylsjhp5voF0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068365; c=relaxed/simple;
	bh=XBANaX9XmxPomR/CFTc/c52ZequbUV3qGM5++oZWMgQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YWW6HyVKhSKcDJAa4p0LsYzCbwVW9TwwAC+aY4GbrWDxl80xeG0Bbpq8i6wV18om2rnC/a1myVPHP3BC4w5DcxV3uGvJnyTEZHtpCD5Aguhru9AVBh4wURyqTHiOMcMbBE8rXnab53Ud3IkKl8Sx+sxIfedKNfxRmvWLbd5CxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0HNIvdZ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0HNIvdZ"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6cf995766a3so4190785eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792068362; x=1792673162; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HayCoFyHhTDZNbR5j1aFw0Wxi0UJun32AbqmUVyanN8=;
        b=A0HNIvdZ69cRWuY0bxuL1zc9BsD5dLuf+I9Nynxb+bMgZ+e8PNF69T0+Kj7752QchR
         zVFSaheXxyBGUhwq+GM/Jkl0P7K8MFBS0i5epxkQ/T0NN9xM99XnwxuWtsXz3zybuHnN
         FSWSvsIEKrQtUnr27cbKfwE3gndEvQ9H44ebK8zeDUlplAUpcot3CJTgm81jK4DuQBrO
         W2PTy/UWTBqw7lpzs6wsXV6MaTXF7hOyHdFQSTHawlv/xkvnwW91qKavtn6NZmQFqdx5
         gv4iNzn4Ed9BWq4AEmYBdTUH90VYpcGoGRkABovO/4X9uyzBRL4Ws278H50Fa/6rdCK/
         NJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068362; x=1792673162;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HayCoFyHhTDZNbR5j1aFw0Wxi0UJun32AbqmUVyanN8=;
        b=qNIg7nuL64bggnUu70tmfhz7Nu6m9xp5DckLxRR1kLSrM7jnZGEbzzHIyyHoJ/3Att
         dEnh0GC9TqNR7J4FWEUYFbK5v5vmtd68msUZd+36g2rS6gPKIAmZeinX/A83E6OorkSR
         9HOWL+p1KJwuZ2OCO5RaO/cowqm+jQBLQ4v7KSvcE1HW/RhPRRyh3u+HB9/nHUGIfcFM
         OMTZzRuGDuL7OTNN9XobghLTFLWVR+38rrcq1+e9Ksc9sVeZ2bYTvzlE7gCWusZ2+2oO
         6uVjCPizjcpj0aaBoOVE10ZQmcb1Y4lacmFMnJOy3HzRM/4pj0jD5sJpmkIZzyLX5+Cn
         KfEQ==
X-Gm-Message-State: AFq9FYL//nxXwTrgDREhXL0+C9riJGSvvv6yKgiXDa0f2aruyYCfbkb+
	xjD/zVIJouNAOmi1GdgIJiHQAQPZ1Iqj3HTBUAsNXsj/MURQzs2EbC1J/9AyWg==
X-Gm-Gg: AYBFou09mZ36IFg6ieCboYp73BhfwpiqtOmlJ7FEccNJmctsN3h5cjqjo5IdEv4TWUB
	7tNzHX7QhlzW9oxtMLPW44aYVPgAMoYLXCKHdCjfFTgKgIDR7ILMW0Ox/q3dl/tbJBVkX2iRFgu
	okS3VYZj7hZnZeBuhhxBG8UBTQzo0gfAjOoWP9VS+iioDyl1Afij/FhaPZ8GkQd6Swmz8FNCtUO
	E+R1QCUImrzMw8Eu2vG+RUj0cF4fG7prLEXxa+jXQ+k1j80/xmQileDddK2XNvE+Hb4Qi+ooE/m
	5FNFo0Qx1iJ76kk60pO8bmC7au2I0whUUypnAR+w6wA+fijWRCR93TFq1eqAWiSXY9ojk9HGG7B
	72YhayZVUgfCMbC/iJK4AZ+Uhm6S9742W2A6825A2NoQbu1lbNyVbC7lYmADBHTuU3LkqRYFzqB
	gxwRQvi/lWlhWgOp6ON6JMuMQE1CyLR//7zzygT/hvfAnZZ1Ln2/qZdgKpntyhvwWcgtUHdNy3U
	ZR+
X-Received: by 2002:a05:6820:2006:b0:6df:baf1:fb09 with SMTP id 006d021491bc7-6ef10e689ecmr14874407eaf.87.1792068362047;
        Thu, 15 Oct 2026 05:46:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.31.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6eef6e22b46sm16566548eaf.0.2026.10.15.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:46:01 -0700 (PDT)
Message-ID: <6ad0cb09.870d8f20.127c83.476d@mx.google.com>
Date: Thu, 15 Oct 2026 05:46:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7930462483254281130=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez,v2] hci: add ext adv interface
In-Reply-To: <20261015-extend_adv_api-v2-1-8b76d8a1c0ef@amlogic.com>
References: <20261015-extend_adv_api-v2-1-8b76d8a1c0ef@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7930462483254281130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186303/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.45 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      12.70 seconds
BluezMake                     PASS      166.45 seconds
MakeCheck                     PASS      0.53 seconds
MakeDistcheck                 PASS      92.68 seconds
CheckValgrind                 PASS      87.35 seconds
CheckSmatch                   PASS      166.30 seconds
bluezmakeextell               PASS      57.75 seconds
TestFunctional                PASS      802.36 seconds
IncrementalBuild              PASS      186.96 seconds
ScanBuild                     PASS      607.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,bluez,v2] hci: add ext adv interface
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#261: FILE: lib/bluetooth/hci.c:3177:
+		sizeof(le_set_ext_adv_enable_cp) + (num_of_sets * set_entry_len);

WARNING:NEW_TYPEDEFS: do not add new typedefs
#310: FILE: lib/bluetooth/hci.h:1739:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#326: FILE: lib/bluetooth/hci.h:1755:
+} __attribute__ ((packed)) le_set_ext_adv_params_cp;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#329: FILE: lib/bluetooth/hci.h:1758:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#332: FILE: lib/bluetooth/hci.h:1761:
+} __attribute__ ((packed)) le_set_ext_adv_params_rp;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#336: FILE: lib/bluetooth/hci.h:1765:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#342: FILE: lib/bluetooth/hci.h:1771:
+} __attribute__ ((packed)) le_set_ext_adv_data_cp;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#346: FILE: lib/bluetooth/hci.h:1775:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#352: FILE: lib/bluetooth/hci.h:1781:
+} __attribute__((packed)) le_set_ext_scan_rsp_data_cp;

WARNING:NEW_TYPEDEFS: do not add new typedefs
#356: FILE: lib/bluetooth/hci.h:1785:
+typedef struct {

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#359: FILE: lib/bluetooth/hci.h:1788:
+	/* followed by ext adv set entries: handle(1), duration(2), max_events(1) */

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#361: FILE: lib/bluetooth/hci.h:1790:
+} __attribute__ ((packed)) le_set_ext_adv_enable_cp;

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#375: FILE: lib/bluetooth/hci_lib.h:115:
+int hci_le_set_ext_adv_params(int dev_id, uint8_t handle, uint16_t evt_properties,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#378: FILE: lib/bluetooth/hci_lib.h:118:
+				uint8_t peer_addr_type, const bdaddr_t *peer_addr,

/home/runner/work/bluez/bluez/src/patch/14891171.patch total: 0 errors, 14 warnings, 283 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14891171.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2684

---
Regards,
Linux Bluetooth


--===============7930462483254281130==--
