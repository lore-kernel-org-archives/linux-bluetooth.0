Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF20210F9
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330172; cv=none; b=DDbWM0aIjLut9538emiJiuv60YqZ74vYwjuZsolmJ4EakXKLIYkucGiDiumz4Oh00541BNd2vIn/C+0CwstGksNzPdV84DJOkpBJR+huO5KtbN+yTE1AjHM/X58gjLb9ENUTsX3rgMkuIozUB9ynmGd9+dyTkoLiCoA5tjbu1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330172; c=relaxed/simple;
	bh=x1va9kJtNGXwOf9cv+8lHEG/7+hWYQ9wyzDE03pfF/Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VS13DaDUlaWh2lGv+dFRSfglKXJ3SR5iuLQu0IVUBIW6aEizAXhp+/Hm9Yrx9QRhB6u8P9S8Vwl/tcyLgBkRZyTZdwTE1G1FqIP2oZGO2PdoNaUT7T3bD2wC5V2/NbN9YM7FTr9LTQmJlmztpazswk1hTLg3KnySNkjP3L4cj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8V28fBE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8V28fBE"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso3437191b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 00:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708330170; x=1708934970; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t3CSBxq7ysnWEBAEHfm3QYs3rC6hu6r2BrLwsyhU+dA=;
        b=H8V28fBEfOlTtIBnqZthM2q3WHuLGfY3lMryQjT6dyJCdxGyLvof3E+eJPymKUUsHo
         MJ3Rf39HdMxvc+01KQE9SkF5hAOj+fVcdGQMlIgrBBrHZhKEYCvx7lFjrkPWPkAxs6pZ
         BrHr76VMD1ljObq0LUVlqZjWJZ5NUS8sfUwSjlEYwUk6KzVXUjr86p72PiTTwAfyurNF
         0MYA9/w0Q6fxExw7Gy6ZpZ45kYZ45k2Kg0tUHGvH8rb3nlMEAxrF5vrGoUokt4dguagq
         68N6wHRo11+hM53YxBIYo2OmvZkw7pT1rG3uIKkOvlfNFVmDi/qTue1B9XIUCgGfmdIp
         teJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330170; x=1708934970;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3CSBxq7ysnWEBAEHfm3QYs3rC6hu6r2BrLwsyhU+dA=;
        b=R3LIiUPCSvqpIMO0KwK+gxkopa7whOKLwsqfprNA8vOeHGdrbu5SCEZ0UNq54CoATm
         d8rbFr4xgOJmwYFAsv2oRTSnmI4hQ9dUdn/dvPTmiQtGKMLm4zuB5kEgKZr0t3QYhEDh
         0jVsVKoZ/W401ekx6u5J6cSgnJxhY5GT1y90Cdj4C7gwqDf29CfWfaYNH1VTzGm++BZd
         X3yRPER+rkIw1ZCAtEsNLH/yXsTcVwjFUYbObpnSsgrvh3rEPikFTH4lWf0ntIrLUyuJ
         5sBdA1wMj0hVqLW14XKPoKHuQstptopXiWHFlfqb/UZD7nCwl3QQj7ikJIYPnPaDGMq5
         Uj8g==
X-Gm-Message-State: AOJu0YyDXwMQWCCJL2Dq0d+dwPF6HG77D/Md52ZY8KeSQcMNcImKkx25
	yzX9afdwQCDD/4NrRjmEygY/omdt2nlNthmLkcoxbKEeHFu+qt28LgU65Su3
X-Google-Smtp-Source: AGHT+IFq+2iCyflSgbBFMXlMmO2QR3XAS7Q9u1UWKYiWrRC7ON4E4xGA+FT5MAPHan2hZ23koZLX9g==
X-Received: by 2002:a05:6a00:9282:b0:6e4:6048:75fd with SMTP id jw2-20020a056a00928200b006e4604875fdmr3411719pfb.4.1708330169806;
        Mon, 19 Feb 2024 00:09:29 -0800 (PST)
Received: from [172.17.0.2] ([13.83.123.180])
        by smtp.gmail.com with ESMTPSA id r22-20020aa78456000000b006e24991dd5bsm3971459pfn.98.2024.02.19.00.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:09:29 -0800 (PST)
Message-ID: <65d30cb9.a70a0220.2dd2a.9fba@mx.google.com>
Date: Mon, 19 Feb 2024 00:09:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4438806504167077323=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shahid.bashir.vichhi@intel.com
Subject: RE: [v2] profiles/audio/ccp: Add initial code for ccp plugin
In-Reply-To: <20240218235401.2511586-1-shahid.bashir.vichhi@intel.com>
References: <20240218235401.2511586-1-shahid.bashir.vichhi@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4438806504167077323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=827344

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.11 seconds
BluezMake                     PASS      745.45 seconds
MakeCheck                     PASS      11.58 seconds
MakeDistcheck                 PASS      163.30 seconds
CheckValgrind                 PASS      225.72 seconds
CheckSmatch                   PASS      330.98 seconds
bluezmakeextell               PASS      107.32 seconds
IncrementalBuild              PASS      685.96 seconds
ScanBuild                     WARNING   990.69 seconds

Details
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


--===============4438806504167077323==--
