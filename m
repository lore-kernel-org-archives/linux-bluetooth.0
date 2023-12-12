Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmM0og+F"
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09CB98
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 14:59:48 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67adea83ea6so44200776d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 14:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702421987; x=1703026787; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tArFbelPd1qSn8VU4SdO67m5M7QVcp/pWN9LwN1C1GE=;
        b=QmM0og+FnOnoGMHfmqxxOhFgdyQp9LR62sSco3tLGPTETauv0UqHOKvX6OPrmDZN94
         lcQ9d58kvDVkDQ/qUGsIntMRAaDdFg2vANwH0KZbeQxdehY/JZskG7icGYmQaAwjedNH
         OWYDKowyziz1krlNkPULVMDhHqkqymVnk22fiuLOPs3oSBvIdFC4l8lkzD+kCrqgmgAQ
         Ea+wBceaQ8PHD6obvEDPZht5tf1EkL3gxA7NeNHEhbTLoMN1y246mcggiKY4Yh+s6chS
         9IFZSCnRFwouGPEWcUADYzCjf8vWdo6z1fN3VthQVp6/bRrcDR31x1EaM/TsT60d+1n2
         679w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702421987; x=1703026787;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tArFbelPd1qSn8VU4SdO67m5M7QVcp/pWN9LwN1C1GE=;
        b=Bv27QmEB8ZF7b4Lo4Xl2CJjxMLjMx4vHgIljsDB8Xj9NAXb0pJSckRmD1jY6Eel/ay
         JuV1iZE5OhPfC8l/p/cl/kB9husuCLu/MDQ7DHJ4lLXDxthCAeuZAKPbq6yM20iRe5KJ
         FQRbuAv83dwpTJBb1rGm/rRGrWd1fFYDLJRC8nXGo21awKtWsG/F5yIMoEbLA97riQzp
         HfDsCDfctCb4twBhrbpTNDFhScZPqlUU+kyZsc7sBOyZ9NvCEXKoUdhE0IT1wopgPg/j
         XtKoKMhab89hOqy1DK23jGx+kvfbliB6d1oeZ6rM4Y0fWEYsni5Vlvx9BrcqVBFGyqI+
         b+ZA==
X-Gm-Message-State: AOJu0YwV7ju4/26m1O5sF9zGmeeK7Ry3kaPdKsue5OJDRqkcP0vNaDA5
	KYj+NI824u954f5Zi4vMMFrcQIpEOBg=
X-Google-Smtp-Source: AGHT+IHj8ivpwbcStf4NfxXz6t6vinzjiSnTfBfuX91a1rDX2iqOHk/oZve0vsvwQrlguYwRsGCDow==
X-Received: by 2002:a0c:ef82:0:b0:67a:a4d8:babd with SMTP id w2-20020a0cef82000000b0067aa4d8babdmr8152952qvr.15.1702421987715;
        Tue, 12 Dec 2023 14:59:47 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.36])
        by smtp.gmail.com with ESMTPSA id rr17-20020a05620a679100b0077f0ae46fd5sm4095216qkn.16.2023.12.12.14.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:59:47 -0800 (PST)
Message-ID: <6578e5e3.050a0220.4f8fb.5484@mx.google.com>
Date: Tue, 12 Dec 2023 14:59:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0651306881984622032=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v5,1/6] bap: Allow setup of multiple stream per endpoint
In-Reply-To: <20231212205804.881265-1-luiz.dentz@gmail.com>
References: <20231212205804.881265-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0651306881984622032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=809401

---Test result---

Test Summary:
CheckPatch                    PASS      3.46 seconds
GitLint                       FAIL      2.15 seconds
BuildEll                      PASS      24.32 seconds
BluezMake                     PASS      700.29 seconds
MakeCheck                     PASS      11.69 seconds
MakeDistcheck                 PASS      157.46 seconds
CheckValgrind                 PASS      221.46 seconds
CheckSmatch                   PASS      319.14 seconds
bluezmakeextell               PASS      101.29 seconds
IncrementalBuild              PASS      3955.63 seconds
ScanBuild                     WARNING   904.73 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v5,2/6] shared/bap: Make bt_bap_select match the channel map

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	  0000a0201030202010304280001020206000000000a020103020201030428"
14: B3 Line contains hard tab characters (\t): "	  0002020206000000000a02010302020103042800"
[BlueZ,v5,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v5,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties"
[BlueZ,v5,6/6] client/player: Use ChannelAllocation given on SelectProperties

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


--===============0651306881984622032==--
