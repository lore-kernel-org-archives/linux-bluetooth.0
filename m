Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNMlp1mS"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B27CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 15:27:29 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77f524597c3so213168085a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 15:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702337248; x=1702942048; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=12Daig6eUVYoyJFwL+Hmq63RhPX2vHTl+dovtwt8d+c=;
        b=dNMlp1mSWO0iuWsfHf4NoU6fpGCm4OkCzn0+6raB/3Bw3i7ZR7ZktECrlPepugYAxd
         EjL612wjrqDa/W7itU4TE0UlYPifQNp34lpIybkZxAnuWPbpXByyqLgtvfEnz0K4lvaO
         N8KL5DS8frX4rJyvpsLCUrNBUNxhCFoLvY7yg/O6EqRz52nWQaReEW4ptEoktmF9ZcyW
         6fVJjbs41fW04MFDJWHa+rdV0PCBR2XWaQAX6UIvgHlmPN9FIu00FDUaVd6Tyh92e7m2
         dx6wV0fSli+hqcTl8KyG5rndvWdWwcKOflSdtpVJBrlNfzn5kpj4y/Gqz+Gx4/Q2h9gP
         dh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702337248; x=1702942048;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12Daig6eUVYoyJFwL+Hmq63RhPX2vHTl+dovtwt8d+c=;
        b=TtmfeOdSg1+1vz0wt7nazAqfYGUPPHGd6UaBQv2usZ57MOilK1XYXVr4oCw3RES7lY
         mt43PVK97NpX6TJ9+TtEKPvYrc0Z2L6J/P+QVbBMVw9LzafKrLTCginVotRXasMLi+jC
         FnnWCmJHkMPPCWpStTUnpkpsf8aGLo0l7TKFtITtlaK+n1UFv6jWPq6Tu3UBrl28XK9+
         das3sjOyiZ9Cc8rnfewzGJOhF3tHDjo1/kMxmlVan9e4QQ37A4ucRKmYeYXfgVAYOMHr
         1J0udwZpMZnutwTG52WAovaAH3WDXQ0n1gFJusR7zt8QM5umF3M309AO+wvLmGlnmckB
         CG+g==
X-Gm-Message-State: AOJu0YyNDda3W5yWq4IDPOgnmWwgjjGsCr/fWisKvFHh1wRHhfMWPv4Y
	ymJHuw1qb2hujXGWmie5tOKwuwp7IpQ=
X-Google-Smtp-Source: AGHT+IGFgvCCBln9Uav4fsCD+TqmgNddFgj9CjRJ5i+94UCXroC6pJdGZ+PXOuuz2tPqCQ59UmpJSA==
X-Received: by 2002:a05:620a:84c5:b0:76e:889d:855d with SMTP id pq5-20020a05620a84c500b0076e889d855dmr6754938qkn.67.1702337248060;
        Mon, 11 Dec 2023 15:27:28 -0800 (PST)
Received: from [172.17.0.2] ([74.249.21.241])
        by smtp.gmail.com with ESMTPSA id ov11-20020a05620a628b00b0077d7e9a134bsm3290816qkn.129.2023.12.11.15.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:27:27 -0800 (PST)
Message-ID: <65779adf.050a0220.d374b.f80f@mx.google.com>
Date: Mon, 11 Dec 2023 15:27:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0236276963366477419=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/6] bap: Allow setup of multiple stream per endpoint
In-Reply-To: <20231211210429.530964-1-luiz.dentz@gmail.com>
References: <20231211210429.530964-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0236276963366477419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808934

---Test result---

Test Summary:
CheckPatch                    PASS      3.53 seconds
GitLint                       FAIL      2.29 seconds
BuildEll                      PASS      24.07 seconds
BluezMake                     PASS      735.54 seconds
MakeCheck                     PASS      12.14 seconds
MakeDistcheck                 PASS      155.58 seconds
CheckValgrind                 PASS      217.04 seconds
CheckSmatch                   PASS      323.41 seconds
bluezmakeextell               PASS      103.73 seconds
IncrementalBuild              PASS      4076.60 seconds
ScanBuild                     WARNING   937.33 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,2/6] shared/bap: Make bt_bap_select match the channel map

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	  0000a0201030202010304280001020206000000000a020103020201030428"
14: B3 Line contains hard tab characters (\t): "	  0002020206000000000a02010302020103042800"
[BlueZ,v3,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v3,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties"
[BlueZ,v3,6/6] client/player: Use ChannelAllocation given on SelectProperties

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


--===============0236276963366477419==--
