Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYTw61T0"
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38CBC
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 09:54:22 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so83184561fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 09:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702403660; x=1703008460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rczfddZBIFheBXAYiRr+LWrmy375TF8UcSojNZHbVe8=;
        b=IYTw61T010ZHcIQosPSQ57PHNhBsyRO1s+d2Gg45Eb63T+orOJ+8+k+GYMXDdKW81r
         LAFIaiCfPnXglk/KWuG4L4LLxQ6DJ5z8evqOGG8us/ktqZDSejhpjOSLmCvh67t47QVj
         kckyj3pBl9MCSyejScc2ITbIH0MXEbH23A2SKDArWHR0miXhP3ztUr3Hz/ZNUz5DNYRr
         Ti2PxRxMRt6c8DQaNDvWJMybmdW1v+98WrugxiOqP7UFXeAJ/ICorfndt78sefxelesJ
         /tMXKRYcRmmT6XZOhVptJRituBoIiaA4g8E4FHfdC/FCGGLboDZ16DLeKxIYDXttXSdf
         htEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403660; x=1703008460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rczfddZBIFheBXAYiRr+LWrmy375TF8UcSojNZHbVe8=;
        b=HOW5McC8Mn5bYYofQJMlxIJ36JtESYJdYqr+wuoArEGvwKRcPWsqFKgvH7ufwIJXD3
         HZad96Wv9w2SSoKiMcwN9XoVZvYF4pJGosHIZcoQNnjn2S+8aPe2qatMBxHJIp0Gx0qI
         BGRl/V+XGjg7Y8rIrpzm+aEuY7tIBOJZ3de259Ikqp7xgMGNj3SaAtaXr7osMZEBFz1k
         CcudJAws9nJ+fMf/kOjKajP4dpeT96QLVDCs3AzaxccIEAqFl9t2nW/yN8IoEWL+7Bgz
         Yxqz+yDyWGCrAqcy6WP0to3WEzmKzyV/a46gpkhhdQGw51mW7N/JhX+jNkqcwLB8tneY
         1ZqA==
X-Gm-Message-State: AOJu0YxyGWf0vMbkHqf2zSP77WnAu5QwkNOzQ3TZuzGduWqiIdgxt55V
	C4YP1FXU/TgQYCJsMPPvPsdcCc7fJzZQtoQ22kJLso2u
X-Google-Smtp-Source: AGHT+IF4v+w/zcbTBCj/g4E+2ucvi3yrRMkcAMCMeEjcaUqNoHgc2vXcRptv7AQfYt3g23NR2mS+0SAXeXq/X2SVRNE=
X-Received: by 2002:a05:651c:1a25:b0:2cc:2106:ee5c with SMTP id
 by37-20020a05651c1a2500b002cc2106ee5cmr1774021ljb.37.1702403659313; Tue, 12
 Dec 2023 09:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211212516.577426-1-luiz.dentz@gmail.com> <65779bca.a70a0220.e7968.5323@mx.google.com>
In-Reply-To: <65779bca.a70a0220.e7968.5323@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 Dec 2023 12:54:06 -0500
Message-ID: <CABBYNZ+17-4r5XGnGkV5Mnd_ZzsKL0xNwhHbS0tdri9D7=U-1A@mail.gmail.com>
Subject: Re: [BlueZ,v4,1/6] bap: Allow setup of multiple stream per endpoint
To: linux-bluetooth@vger.kernel.org
Cc: iulia-tanasescu <iulia.tanasescu@nxp.com>, 
	Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>, Claudia Draghicescu <claudia.rosu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 11, 2023 at 6:31=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D808=
938

Could one of you guys please verify that this set doesn't break
anything related to broadcast.

> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.70 seconds
> GitLint                       FAIL      1.73 seconds
> BuildEll                      PASS      24.71 seconds
> BluezMake                     PASS      780.94 seconds
> MakeCheck                     PASS      12.60 seconds
> MakeDistcheck                 PASS      164.82 seconds
> CheckValgrind                 PASS      225.11 seconds
> CheckSmatch                   PASS      330.30 seconds
> bluezmakeextell               PASS      103.81 seconds
> IncrementalBuild              PASS      4181.08 seconds
> ScanBuild                     WARNING   990.81 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [BlueZ,v4,2/6] shared/bap: Make bt_bap_select match the channel map
>
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 13: B3 Line contains hard tab characters (\t): "          0000a0201030202=
010304280001020206000000000a020103020201030428"
> 14: B3 Line contains hard tab characters (\t): "          000202020600000=
0000a02010302020103042800"
> [BlueZ,v4,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectPr=
operties
>
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 1: T1 Title exceeds max length (81>80): "[BlueZ,v4,3/6] org.bluez.MediaEn=
dpoint: Add ChannelAllocation to SelectProperties"
> [BlueZ,v4,6/6] client/player: Use ChannelAllocation given on SelectProper=
ties
>
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 13: B3 Line contains hard tab characters (\t): "          602020600000000=
1002010302020103042800050302000000010202060000"
> 14: B3 Line contains hard tab characters (\t): "          000010020103020=
2010304280005030100000002020206000000001002010"
> 15: B3 Line contains hard tab characters (\t): "          302020103042800=
050302000000"
> ##############################
> Test: ScanBuild - WARNING
> Desc: Run Scan Build
> Output:
> src/shared/bap.c:4766:23: warning: Access to field 'type' results in a de=
reference of a null pointer (loaded from variable 'lpac')
>                 if (!match.rpac && (lpac->type !=3D BT_BAP_BCAST_SOURCE))
>                                     ^~~~~~~~~~
> 1 warning generated.
> In file included from tools/mesh-gatt/crypto.c:32:
> ./src/shared/util.h:228:9: warning: 1st function call argument is an unin=
itialized value
>         return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
> #define be32_to_cpu(val) bswap_32(val)
>                          ^~~~~~~~~~~~~
> /usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
> #define bswap_32(x) __bswap_32 (x)
>                     ^~~~~~~~~~~~~~
> In file included from tools/mesh-gatt/crypto.c:32:
> ./src/shared/util.h:238:9: warning: 1st function call argument is an unin=
itialized value
>         return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./src/shared/util.h:34:26: note: expanded from macro 'be64_to_cpu'
> #define be64_to_cpu(val) bswap_64(val)
>                          ^~~~~~~~~~~~~
> /usr/include/byteswap.h:37:21: note: expanded from macro 'bswap_64'
> #define bswap_64(x) __bswap_64 (x)
>                     ^~~~~~~~~~~~~~
> 2 warnings generated.
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
