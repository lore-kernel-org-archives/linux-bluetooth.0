Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGu2B8F/"
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AABCB
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 15:31:23 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58cecfb4412so2877774eaf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702337483; x=1702942283; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jjG+d2ZF8Q03+rHzNeB1wvLQQ8EQ42XbpWyNulYfJK8=;
        b=CGu2B8F/vRcGqyMqaKaxE4WJfvMMkaAkTT7pnEkt6hCJlSelkrcWeDssOYjG+tG+nw
         b0vtyL0vlWP9Z1RZp3eUNYNn1NmZNaY9Vti7Xnbu6OD90pY6a53E3gppsScZY96ZKo49
         o+qHKnMXmjJWbikYbJ7ZoqPOmPrX8I6wkMZGhGDI5cPP2XM8BpkubcGFH4X8Ywg5F7di
         QPxThD682oFbSTUbqaVf4tTGSG2qODaPg37VVNeRvuo/iGRi5rhpIjToEFubCQaSZfaJ
         ng31FjT7cYxFKd0EYITqlmRKuelx/k76/Ry+CkqadbYz/PzAT5ukj9RlQP2TCAs0wwGs
         0TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702337483; x=1702942283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjG+d2ZF8Q03+rHzNeB1wvLQQ8EQ42XbpWyNulYfJK8=;
        b=OfnHu7bcLJeHqdEISiys27wFLJVVlzQH17bW9o+8rgz3aZXtQGATQ3xw1SU34oMNM3
         GkA5G2jcVKe5q1OvS80ZbnloACxTgG2fvVn3DSn2hSMTOq7eSxwxLD/N9nYqO96VSERi
         y8fKGl+deA0OEmfjoNFRO6nRJKTnT5VyImdo/PQ3HnX6picBo+HaZ4O76olm3pPGTIGh
         R3W6/XJeFUxdJeRR9GP+DcymfVb1U0n1RBWVM3Ta07Eig8vCcg86VvnK35p2UR8Ml5Zg
         HsKck1JXQCMhFqEVDXsdv2fS5WR8GWe/NInTasaKAMeWQCoyfKkWrDY01YOw2cLwww0G
         A5Nw==
X-Gm-Message-State: AOJu0YweEfM+VVZK1uuiacgWWl3qASo0+l6CJ71KZiccY3834x1BTQ66
	otIdPnE7hs+km8TteGbRjiMEvXPoPwI=
X-Google-Smtp-Source: AGHT+IHo6fZvQzEFiqTImPwAFI/U97ZOQIBYT0luTgROEjZfFgnrSIFrP8zabfqlrbfJMeIDo1dI+Q==
X-Received: by 2002:a05:6358:9213:b0:170:6ed7:28f4 with SMTP id d19-20020a056358921300b001706ed728f4mr7976574rwb.8.1702337482653;
        Mon, 11 Dec 2023 15:31:22 -0800 (PST)
Received: from [172.17.0.2] ([4.227.114.190])
        by smtp.gmail.com with ESMTPSA id x20-20020aa784d4000000b0069346777241sm7014106pfn.97.2023.12.11.15.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:31:22 -0800 (PST)
Message-ID: <65779bca.a70a0220.e7968.5323@mx.google.com>
Date: Mon, 11 Dec 2023 15:31:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3143880335030056375=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/6] bap: Allow setup of multiple stream per endpoint
In-Reply-To: <20231211212516.577426-1-luiz.dentz@gmail.com>
References: <20231211212516.577426-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3143880335030056375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808938

---Test result---

Test Summary:
CheckPatch                    PASS      2.70 seconds
GitLint                       FAIL      1.73 seconds
BuildEll                      PASS      24.71 seconds
BluezMake                     PASS      780.94 seconds
MakeCheck                     PASS      12.60 seconds
MakeDistcheck                 PASS      164.82 seconds
CheckValgrind                 PASS      225.11 seconds
CheckSmatch                   PASS      330.30 seconds
bluezmakeextell               PASS      103.81 seconds
IncrementalBuild              PASS      4181.08 seconds
ScanBuild                     WARNING   990.81 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v4,2/6] shared/bap: Make bt_bap_select match the channel map

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	  0000a0201030202010304280001020206000000000a020103020201030428"
14: B3 Line contains hard tab characters (\t): "	  0002020206000000000a02010302020103042800"
[BlueZ,v4,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v4,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties"
[BlueZ,v4,6/6] client/player: Use ChannelAllocation given on SelectProperties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	  6020206000000001002010302020103042800050302000000010202060000"
14: B3 Line contains hard tab characters (\t): "	  0000100201030202010304280005030100000002020206000000001002010"
15: B3 Line contains hard tab characters (\t): "	  302020103042800050302000000"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:4766:23: warning: Access to field 'type' results in a dereference of a null pointer (loaded from variable 'lpac')
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


--===============3143880335030056375==--
