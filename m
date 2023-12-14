Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06F671E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLVVhIrZ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42542b1ed5dso412901cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 15:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702595056; x=1703199856; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=URek9GBkoq692pqcoAGRzykh3SUL3AZ0iWvX2IPDt68=;
        b=FLVVhIrZGT1p7VMllumeYjYXIpSy9AaTpiNEM7CzVSOKiFlF2PVyJn/JO9b8CmYWOc
         KA4ondXYYRflQHqfZiqP3JTSVwyvzjFCL7oHrrpUv+ZA0n67gh6kLRAdNw90hVJI/0md
         EyQGHyIGWGzQZ5SnPLHeAqmII2kBc7Pls6y2Fuj9x+nO6T8jRCTqZFrHbK8NFNgq3kON
         71FrDnCaFt8CmQd2Mi19kChRsTtiveRa0EBiixE+XOaKYBOnnQtWAM+gYZLZNvSda2EL
         xm1SIBeFVK6n5kDC8SpawdYCYWvJl9W6/pQwc+Vx+p/5yp8IwFF6j/AtsNLiP6PRVIx5
         lUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595056; x=1703199856;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URek9GBkoq692pqcoAGRzykh3SUL3AZ0iWvX2IPDt68=;
        b=plbSZLxi4LKRClmAg+7szH1Hz24dMxCTzf4EIEoWugwbpyE+K0QUWWh0FB9UATw+WM
         40kWxae/tiZBl4IFr982jPa6WCg+DFVFmX/3bxIXFkcQLjDR3MzHkgFFdbPXHZ5DZma/
         ufPw3Dgkv6HlxcTSaC4SL2JMG2K4zCp+7VnyaCe7R6DogfvhSF5ItzlPA4r1soseszH6
         EveveqmNhAhQ+dwIXdwASdEDKT3o8rmfPs4dz4fwtgp874dkSVwpRe1UG6wkdXQYE8As
         U8n6cXn/eqKzjAvxEvJM4daMcxyqmhzxb3DhC/lSsfs8A3Hl05c4UljuO6XQEdKrfPJW
         +2Jg==
X-Gm-Message-State: AOJu0YxXROaB7hF/2RQid+YxFwmJYSAQRqkMYzONpuSqw7qmV/MuqRZv
	s7CYIVsLG8UuSIOhCQqfTXHxVSEPtNJoOw==
X-Google-Smtp-Source: AGHT+IGyGyHDJGE5VM3wOMvaLhp7jsPx097DaVHzJazeUsF2g7tZJihsASFcIpRmU5LJTgLBOilc/g==
X-Received: by 2002:a05:622a:1006:b0:425:4043:96f0 with SMTP id d6-20020a05622a100600b00425404396f0mr15199701qte.125.1702595055649;
        Thu, 14 Dec 2023 15:04:15 -0800 (PST)
Received: from [172.17.0.2] ([172.183.51.126])
        by smtp.gmail.com with ESMTPSA id m26-20020ac8445a000000b00423e1b606bbsm6112869qtn.69.2023.12.14.15.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 15:04:15 -0800 (PST)
Message-ID: <657b89ef.c80a0220.4c2dc.40af@mx.google.com>
Date: Thu, 14 Dec 2023 15:04:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7593030763093027179=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v6,1/6] bap: Allow setup of multiple stream per endpoint
In-Reply-To: <20231214205556.1320286-1-luiz.dentz@gmail.com>
References: <20231214205556.1320286-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7593030763093027179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=810225

---Test result---

Test Summary:
CheckPatch                    PASS      3.44 seconds
GitLint                       FAIL      2.20 seconds
BuildEll                      PASS      25.97 seconds
BluezMake                     PASS      745.88 seconds
MakeCheck                     PASS      11.63 seconds
MakeDistcheck                 PASS      164.18 seconds
CheckValgrind                 PASS      223.44 seconds
CheckSmatch                   PASS      330.07 seconds
bluezmakeextell               PASS      104.38 seconds
IncrementalBuild              PASS      4102.15 seconds
ScanBuild                     WARNING   964.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v6,2/6] shared/bap: Make bt_bap_select match the channel map

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	  0000a0201030202010304280001020206000000000a020103020201030428"
14: B3 Line contains hard tab characters (\t): "	  0002020206000000000a02010302020103042800"
[BlueZ,v6,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v6,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties"
[BlueZ,v6,6/6] client/player: Use ChannelAllocation given on SelectProperties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	  6020206000000001002010302020103042800050302000000010202060000"
14: B3 Line contains hard tab characters (\t): "	  0000100201030202010304280005030100000002020206000000001002010"
15: B3 Line contains hard tab characters (\t): "	  302020103042800050302000000"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:4768:23: warning: Access to field 'type' results in a dereference of a null pointer (loaded from variable 'lpac')
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


--===============7593030763093027179==--
