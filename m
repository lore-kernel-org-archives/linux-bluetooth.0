Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J39wXwrV"
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F010C3
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Dec 2023 15:16:47 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1fb38f3cb57so225025fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Dec 2023 15:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701904606; x=1702509406; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DAC8OA/GxannVEStTeLmgoMNo/9S9rEpgJCK5LoExSw=;
        b=J39wXwrVIOCTUNYQOkwd7fo1yFQCHDHlujh+oT4kp9c7vtKTsc/wvWeZhtgd9eGHjf
         wznErvyoOwo4s6Sk7Na0nKGpcX9WFm3Ze33/+NWF1IiWfgMbVH/c1uB8n8Nwr9jnoV9N
         WtfiMxTNIxpPAQHPXWeeg26Gp1E6KwauUM1Cf2OIY3TbFIGtBGyUIrRgHsvBQx+GY92U
         nNmrp0VS/9x9d2Vc64wONeZuVGyH+oRL1yF/Ty74FaOxUeDZa6J4A7OgOCDlPCZpRG4o
         ZwdsfZdgPxSkGjjetfR9kYzb7WDms1+iGW1lqyrCLWUJjmd6HCWqHDRCX1xhz0P2yteN
         iYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701904606; x=1702509406;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAC8OA/GxannVEStTeLmgoMNo/9S9rEpgJCK5LoExSw=;
        b=DK4GVG4MP6sCkg3LicMRynsI2u3BZJNtejuvl4ukv0mQbLJtD/ZkxbNV4AQysQULwN
         SryBKI6+dQmz9wZvTRgUh6OrexJDRXc/h/42tsM/zsn1/p66jhD1uQt/3sRS7DnNIPTJ
         cCgFx9ScCs9pVVvo1Ofbs0szxEqSy7gY8GBnZv3pi0Ut49ZFl8S4Ah+/IEmpgI6Bm1xt
         Qu+vK33ghhsO0UvsPvGkFmlv0E88qx9cIxL78AuLyY0lCTMdhVDQZNURn14PKAps+Xec
         u5sAPzY9INZAwpCkvdv76PJ1oRL/NhnYivtSgfu6Owsy91PD69lz6vDi0uzy0U94yWqN
         zJFw==
X-Gm-Message-State: AOJu0YwHPtpjIOuP7JvBgdkGEBprDEhnYdHsj0qpq5oYpJI2ZZYGk2Up
	wl2javX8VU3bgxh6gpMNVqqaekIWi4E=
X-Google-Smtp-Source: AGHT+IGmhHg0BjsWFEhVeExD+eS/72/I5uWv4YPVgAMuP3LyojrBm9VlgbkW0m554Jfji5YSx1yHPQ==
X-Received: by 2002:a05:6870:1683:b0:1fb:75a:c430 with SMTP id j3-20020a056870168300b001fb075ac430mr1652132oae.89.1701904606378;
        Wed, 06 Dec 2023 15:16:46 -0800 (PST)
Received: from [172.17.0.2] ([20.57.14.16])
        by smtp.gmail.com with ESMTPSA id n6-20020a9d4d06000000b006d93adc324fsm11367otf.46.2023.12.06.15.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:16:46 -0800 (PST)
Message-ID: <657100de.9d0a0220.5f68b.0128@mx.google.com>
Date: Wed, 06 Dec 2023 15:16:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2138891102127219086=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] bap: Allow setup of multiple stream per endpoint
In-Reply-To: <20231206220325.3712902-1-luiz.dentz@gmail.com>
References: <20231206220325.3712902-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2138891102127219086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807629

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       FAIL      0.88 seconds
BuildEll                      PASS      23.90 seconds
BluezMake                     PASS      726.49 seconds
MakeCheck                     PASS      12.22 seconds
MakeDistcheck                 PASS      156.22 seconds
CheckValgrind                 PASS      218.64 seconds
CheckSmatch                   PASS      321.77 seconds
bluezmakeextell               PASS      101.23 seconds
IncrementalBuild              PASS      1298.14 seconds
ScanBuild                     WARNING   915.30 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/2] shared/bap: Make bt_bap_select match the channel map

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	  0000a0201030202010304280001020206000000000a020103020201030428"
14: B3 Line contains hard tab characters (\t): "	  0002020206000000000a02010302020103042800"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:4767:23: warning: Access to field 'type' results in a dereference of a null pointer (loaded from variable 'lpac')
                if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
                                    ^~~~~~~~~~
1 warning generated.
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:228:9: warning: 1st function call argument is an uninitialized value
        return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
#define be32_to_cpu(val) bswap_32(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
In file included from tools/mesh-gatt/crypto.c:32:
./src/shared/util.h:238:9: warning: 1st function call argument is an uninitialized value
        return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./src/shared/util.h:34:26: note: expanded from macro 'be64_to_cpu'
#define be64_to_cpu(val) bswap_64(val)
                         ^~~~~~~~~~~~~
/usr/include/byteswap.h:37:21: note: expanded from macro 'bswap_64'
#define bswap_64(x) __bswap_64 (x)
                    ^~~~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============2138891102127219086==--
