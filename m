Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyHTU/uX"
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7982A1700
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 16:20:05 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77f3790a187so120071285a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 16:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081204; x=1702686004; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cfed34AIDObYxHLocWtol+I3DH8ae6GAa4vNAUjar2I=;
        b=FyHTU/uX9+HVXmQijXQBXNFUTosOtZ5N7GAz+9rDFMCehwQxnNO0e+5oUWZ/zGz/y/
         O22aev5YxRlzUXdlvGclQluMugmZNJfIvMvEQxxAMEL6phSNPeavCvXSYMpUK0fVgkH5
         7zp6TC6OJ998TIA6PNGwIHV1xufPqmp+lelQfhqsQcOdVn0oG2/UaTa8Dvwf21/hHn/1
         W91jjuECsn6buo66kZAbyPz1YvU6pe/uZk8xWw9Oag/BzRKQJWDolYuHE8y9ZyFPgKrv
         rqELr/cYzLDNxph3aqQoqWb1RD2kFkGGs18cNkZK2FwxA1u5enl5pMklpCBwkJQ6jHRe
         UeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081204; x=1702686004;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfed34AIDObYxHLocWtol+I3DH8ae6GAa4vNAUjar2I=;
        b=nKlu7QdliLkXHSOoSS+28pZVUoJvYjUDrzz/2XPZEIOt/hTSpocRSQF9V3BfBuV2Dx
         C7QmAB+eUu3DnmjCEr24MDzZwICrogyrbdWx5BqG0aXnMa+Dr1l4vWYQWQyM+9pbVB0i
         X33CW4QL1hpOJZ30k5EkwLXQ62FoH7s6tRy8uL6gTTilSoybsXd2HyEvewuGwqFu35KJ
         WW8L/9A1ox+CrD1JNBHCluTTfdG7Vkrs4YilCdBuQxZQHpb2le01xB7dz4qUA4e4+MVj
         FCSw3mOV3v2FvF467/0uhy+h4Iwr/nMvczYPBxHTOxFsJUmLQBZoZPWAvvyaBIlopV7m
         2Xkg==
X-Gm-Message-State: AOJu0Yx0UhAD4B9+zSF854HdHe1h8XffFeVPkXeFBL8JlAeycmXlWq2V
	YJAnvD3yqBuLxoOt2r0y1EDdm3JZi4I=
X-Google-Smtp-Source: AGHT+IFe8oVMTor44WoUjRoZxkuXokhMkDuK7umVlWOdiImYgJ+3xEWaVZ3AK+jV0QHtTpY9OF6S3Q==
X-Received: by 2002:a05:620a:1669:b0:77d:65d1:5ba5 with SMTP id d9-20020a05620a166900b0077d65d15ba5mr930714qko.56.1702081204458;
        Fri, 08 Dec 2023 16:20:04 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.177])
        by smtp.gmail.com with ESMTPSA id c22-20020a05620a165600b0077d5e1e4edesm1047396qko.57.2023.12.08.16.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:20:04 -0800 (PST)
Message-ID: <6573b2b4.050a0220.4b18f.60c3@mx.google.com>
Date: Fri, 08 Dec 2023 16:20:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6881577407402274913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bap: Don't attempt to release if old state was releasing
In-Reply-To: <20231208221219.54529-1-luiz.dentz@gmail.com>
References: <20231208221219.54529-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6881577407402274913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808403

---Test result---

Test Summary:
CheckPatch                    PASS      3.09 seconds
GitLint                       FAIL      2.18 seconds
BuildEll                      PASS      23.83 seconds
BluezMake                     PASS      677.05 seconds
MakeCheck                     PASS      15.96 seconds
MakeDistcheck                 PASS      153.08 seconds
CheckValgrind                 PASS      214.70 seconds
CheckSmatch                   PASS      318.00 seconds
bluezmakeextell               PASS      100.21 seconds
IncrementalBuild              PASS      3768.19 seconds
ScanBuild                     WARNING   897.51 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,2/6] shared/bap: Make bt_bap_select match the channel map

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	  0000a0201030202010304280001020206000000000a020103020201030428"
14: B3 Line contains hard tab characters (\t): "	  0002020206000000000a02010302020103042800"
[BlueZ,v2,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v2,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties"
[BlueZ,v2,6/6] client/player: Use ChannelAllocation given on SelectProperties

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


--===============6881577407402274913==--
