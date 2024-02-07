Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3C8062A
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322650; cv=none; b=BaxiMSTm1HDvoABUS/FGyIKXw1THPlSiYlD1w9ljblMxOvRrYIGirg7II8cSpE2P7uKCgpUUq70fq5mg4OX4/Mebt7+RaF4PFjQfxNbmdfMi8JCGYF70YB09ODvM2+NzshDH1WHKe1MrescbNlkfOn3zklgh6+0w3zSJRywEV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322650; c=relaxed/simple;
	bh=SobKBw2h77U32SBbhJz76Rm9HzQeBieXOZnD8ULzwy8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ij0KMJe3uWvxmEmauYxSQqBfH1eRHHVJw1OnBRmM4VvIw6L94ZmXtO/npyVjaKZssWR6rDd2Kk/HshoLMD/3iOhzhbnpfYuv67mB0E4D+ISnHI73Joe/SInXtkFYkCfexqIK6Lh7uGnipaIynx2kuMxFKRh1iveN+NLIyB0/j6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtgOuItn; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtgOuItn"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5bbbe592dso346636241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Feb 2024 08:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707322647; x=1707927447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoBYPN7lwn0KGxzF/gbIhV2NMNOTgUJVv347uNrhKW8=;
        b=DtgOuItnykgWiALBHSGwTYjDm0S0S0YPFXESCEmjKN+OsOpJ+4tm20ZldxCEyw7p8D
         WHCpDk1Zh2baE4ynFsNayJoHnr88tUK444BusHT/fAXl+tIFEMPLPr1SgVd+HVURxIKJ
         S+WdIUHSyEFnw8Wfo++ruP5xE6LcrU89uruzvQlvDP4SI0N8vfWIrN9kiVnvG676Xl02
         r6j7jdAkMyC4fIZnP4krLHWYLcq4MbrpBfRacXNuvhtS6+u+jQcmJfujgBEQH7XEoS+s
         3GFM3iCe7NOV2Twh05qIhJAUCFekueBWd1PZU+Z+l4YLp94AsexTbTZLyPfqT3E0pzW7
         zP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322647; x=1707927447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoBYPN7lwn0KGxzF/gbIhV2NMNOTgUJVv347uNrhKW8=;
        b=OB9yJG9zbu+LH8Q72LpeGGbGMi90ct088K7soYnIff+YoPhwadzXKJC7REwXB0vl9y
         12g+W4e2s5A5Vh6vA+3RxKsgnOWlGYLEZfHHDqvS8a6emSsh4r3nXiXX/8FErj76C1/A
         vwLkTdHXYmdcSy4NM4hzhAbJGhh6AQ8m7E32G5+SEy2kjjR09r/Jq82RNdk/oCOj+iaJ
         9Svwb/jfZGAhDQ4kBHfJdwF8DgffmapCQoM4Pes3Bsf31B9PSmZ15vkI5z6/fvMqeiLY
         HAL7gDMv6305JAv4wPtnAhqCoUOB5TvFmgq34ulvvaeIFTpmeyeB5Uvdq4eOjaVkTKj1
         zxrw==
X-Gm-Message-State: AOJu0YwZuhn2N/hh3qUH2q5y2tXD/AeLKHjcw1zP6Q/jJ1mFS1ndmu3r
	8KbQbzAci0ZfojIqsipQaUS8AmUJItfgdvDpeWUk93Pwc9dKx5KIorhKAcez
X-Google-Smtp-Source: AGHT+IFfiwyoVOkIt1XfAnuEF/A/xSw84hOG4gLdT4iu7GiGYJwH6eCFJO9PEffOaZqzg56IQGjy7Q==
X-Received: by 2002:a05:6122:1807:b0:4c0:1f44:6707 with SMTP id ay7-20020a056122180700b004c01f446707mr3145250vkb.11.1707322645684;
        Wed, 07 Feb 2024 08:17:25 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id m13-20020ac5cacd000000b004c0460eeea3sm226480vkl.43.2024.02.07.08.17.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:17:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] mgmt-tester: Remove High Speed test cases
Date: Wed,  7 Feb 2024 11:17:24 -0500
Message-ID: <20240207161724.2906072-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

High Speed is has been removed so these tests are not run anymore so
they can be safely removed.
---
 tools/mgmt-tester.c | 63 ---------------------------------------------
 1 file changed, 63 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 2411267bcb4c..e85fbacdacec 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1688,53 +1688,6 @@ static const struct generic_data set_sc_only_on_success_test_2 = {
 	.expect_hci_len = sizeof(set_sc_on_write_sc_support_param),
 };
 
-static const char set_hs_on_param[] = { 0x01 };
-static const char set_hs_invalid_param[] = { 0x02 };
-static const char set_hs_garbage_param[] = { 0x01, 0x00 };
-static const char set_hs_settings_param_1[] = { 0xc0, 0x01, 0x00, 0x00 };
-
-static const struct generic_data set_hs_on_success_test = {
-	.setup_settings = settings_ssp,
-	.send_opcode = MGMT_OP_SET_HS,
-	.send_param = set_hs_on_param,
-	.send_len = sizeof(set_hs_on_param),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_hs_settings_param_1,
-	.expect_len = sizeof(set_hs_settings_param_1),
-	.expect_settings_set = MGMT_SETTING_HS,
-};
-
-static const struct generic_data set_hs_on_invalid_param_test_1 = {
-	.setup_settings = settings_ssp,
-	.send_opcode = MGMT_OP_SET_HS,
-	.expect_status = MGMT_STATUS_INVALID_PARAMS,
-};
-
-static const struct generic_data set_hs_on_invalid_param_test_2 = {
-	.setup_settings = settings_ssp,
-	.send_opcode = MGMT_OP_SET_HS,
-	.send_param = set_hs_invalid_param,
-	.send_len = sizeof(set_hs_invalid_param),
-	.expect_status = MGMT_STATUS_INVALID_PARAMS,
-};
-
-static const struct generic_data set_hs_on_invalid_param_test_3 = {
-	.setup_settings = settings_ssp,
-	.send_opcode = MGMT_OP_SET_HS,
-	.send_param = set_hs_garbage_param,
-	.send_len = sizeof(set_hs_garbage_param),
-	.expect_status = MGMT_STATUS_INVALID_PARAMS,
-};
-
-static const struct generic_data set_hs_on_invalid_index_test = {
-	.setup_settings = settings_ssp,
-	.send_index_none = true,
-	.send_opcode = MGMT_OP_SET_HS,
-	.send_param = set_hs_on_param,
-	.send_len = sizeof(set_hs_on_param),
-	.expect_status = MGMT_STATUS_INVALID_INDEX,
-};
-
 static uint16_t settings_le[] = { MGMT_OP_SET_LE, 0 };
 
 static const char set_le_on_param[] = { 0x01 };
@@ -13088,22 +13041,6 @@ int main(int argc, char *argv[])
 				&set_sc_only_on_success_test_2,
 				NULL, test_command_generic);
 
-	test_hs("Set High Speed on - Success",
-				&set_hs_on_success_test,
-				NULL, test_command_generic);
-	test_hs("Set High Speed on - Invalid parameters 1",
-				&set_hs_on_invalid_param_test_1,
-				NULL, test_command_generic);
-	test_hs("Set High Speed on - Invalid parameters 2",
-				&set_hs_on_invalid_param_test_2,
-				NULL, test_command_generic);
-	test_hs("Set High Speed on - Invalid parameters 3",
-				&set_hs_on_invalid_param_test_3,
-				NULL, test_command_generic);
-	test_hs("Set High Speed on - Invalid index",
-				&set_hs_on_invalid_index_test,
-				NULL, test_command_generic);
-
 	test_bredrle("Set Low Energy on - Success 1",
 				&set_le_on_success_test_1,
 				NULL, test_command_generic);
-- 
2.43.0

