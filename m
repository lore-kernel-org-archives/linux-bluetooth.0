Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9C186C
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmNDe7+G"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7812750f665so52820485a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 20:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703218006; x=1703822806; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=guIgdpDH93MYA9m8ftbv8zuXaLJDDGRLS1ZkwPoT4nE=;
        b=FmNDe7+GtWPbDWkMlTtXbdmV8TwEO/QR67CoMSMXIg2VMqtZ/nQIN5OD30zfeAubX9
         meT+CdELEcPrnJMCy0EMbSlJMv0OGa+4g2xiquKiNJZCQtyj3t8qsx7GvPOs0UaOM2NZ
         4iPUZ91vzbnefuMImvKTvuf6DNuD/F5ZhgyoD0WutRM3XaeX1YRM+Ih0SGaVO6h5W590
         h2I9ZHK+oircJSSotT81pdoRmU7nDXjIOft3eQGxf5udCwG4YpQE09dCx2VR8tryCkO4
         s6+f5Wvs6UYqjX17athvPAxgE1y0zF4F1RM5/OaGqMaX1OLXCZojMeUq2vCjfrL2Y8pQ
         zpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703218006; x=1703822806;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guIgdpDH93MYA9m8ftbv8zuXaLJDDGRLS1ZkwPoT4nE=;
        b=tzAofUY4RFJfOAO2sfzAe0elqFhuHAl8LqexDkTx0zC6WCM7xTlDIRSIRZMcyDpXF0
         wgHs4Vxsd28dUMlznv4Ky8mX/crFh5v7RYut8DwpYhPIFmynXMR590psaYieg0/ejQ/X
         oVUFG1GBST6lfCZvOc/xor34ETSz7/AXY1FqLnf0Z0qTWpW40YxN73pGu+Q6PuhWeiRU
         qQydupfMlDJhE1IjFMpI9c7dv97d9SMeQI5rhn61KAihaBaJ4+SGLMUT70bDhM34p4N5
         cxXWsDtxu/x5jWmYkNnhyopc6+Ay24qYI4S/gZlOM5/AU8NSiul8093GcuHRLZ7We2Ts
         t+Gg==
X-Gm-Message-State: AOJu0YxcerDUOctp4g/E7/mOEvJSzSzmYjjG2yp95cfrRseH1NiS93z6
	gv9LMO2o6gnt5IEwUo0jedb6Rfy87QE=
X-Google-Smtp-Source: AGHT+IFfAU/ckEvwOVAtKWx6c09ZimPK+mNNCqiAkGtiX5EW8JC2s+IG182QVCqtKd7txTUOXYQcVw==
X-Received: by 2002:a05:620a:839b:b0:781:2b60:66c1 with SMTP id pb27-20020a05620a839b00b007812b6066c1mr1036698qkn.55.1703218005850;
        Thu, 21 Dec 2023 20:06:45 -0800 (PST)
Received: from [172.17.0.2] ([74.249.5.98])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05620a318500b0077efb969151sm1102001qkb.59.2023.12.21.20.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:06:45 -0800 (PST)
Message-ID: <65850b55.050a0220.3868c.6101@mx.google.com>
Date: Thu, 21 Dec 2023 20:06:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6982952485878255433=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 15013537245@163.com
Subject: RE: [BlueZ] adapter: Fix airpod device pair fail
In-Reply-To: <20231222031056.1253528-1-15013537245@163.com>
References: <20231222031056.1253528-1-15013537245@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6982952485878255433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812362

---Test result---

Test Summary:
CheckPatch                    FAIL      0.70 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      23.81 seconds
BluezMake                     PASS      692.73 seconds
MakeCheck                     PASS      11.60 seconds
MakeDistcheck                 PASS      159.04 seconds
CheckValgrind                 PASS      221.20 seconds
CheckSmatch                   PASS      325.12 seconds
bluezmakeextell               PASS      105.74 seconds
IncrementalBuild              PASS      652.81 seconds
ScanBuild                     PASS      917.36 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] adapter: Fix airpod device pair fail
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#50: 
Airpod is performing inquiry scans in BR/EDR and advertising in a unconnectabl

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#68: FILE: src/adapter.c:7070:
+static bool eir_msd_is_apple_inc(GSList *msd_list)
                                         ^

ERROR:TRAILING_WHITESPACE: trailing whitespace
#72: FILE: src/adapter.c:7074:
+^Ifor (msd_l = msd_list; msd_l != NULL; msd_l = msd_next) $

ERROR:OPEN_BRACE: that open brace { should be on the previous line
#72: FILE: src/adapter.c:7074:
+	for (msd_l = msd_list; msd_l != NULL; msd_l = msd_next) 
+	{

ERROR:SPACING: space required before the open parenthesis '('
#78: FILE: src/adapter.c:7080:
+		if(msd->company == APPLE_INC_VENDOR_ID)

ERROR:TRAILING_WHITESPACE: trailing whitespace
#92: FILE: src/adapter.c:7302:
+^Iif(eir_msd_is_apple_inc(eir_data.msd_list) && $

ERROR:SPACING: space required before the open parenthesis '('
#92: FILE: src/adapter.c:7302:
+	if(eir_msd_is_apple_inc(eir_data.msd_list) && 

ERROR:SPACING: space required before the open brace '{'
#93: FILE: src/adapter.c:7303:
+		(not_connectable == true) && (bdaddr_type == BDADDR_LE_PUBLIC)){

/github/workspace/src/src/13502864.patch total: 7 errors, 1 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13502864.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6982952485878255433==--
