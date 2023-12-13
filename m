Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhwbgDev"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A9B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 08:08:02 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2cc259392a6so43395781fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 08:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702483681; x=1703088481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RleaIatk1x4byXqF3Rxf5uDgNq4a0Bz2EL9HSkrFats=;
        b=VhwbgDevDaoXpv1rbqCcsI4KlKLk4OxfxRssZr7V8qDkyc9z0lkLBUemw5zFL4qt3k
         GRGzWqcNVEVutznqRazXSXCNxGWN87jk2Gm1AoNzj/Eqw9Cq2fzdPCnNe+2xWIwr+Np+
         ti3r7GaSSQxqqy1xofr4uIIK/MlVeVuNQ87tbzcZVSbbfyOwIIKGyv7Sd182S/yQ4ZYG
         vNyO8pzvJUJQvG/K4E20Dsszc5vjqyM3qlQ0MmQg/PbjZKp4TCCKFAz3ufUW8k8c0UyR
         Twzz8dkfLFjaBLXMURWh9JPrzQtQtgBVWpsqYK8uVBTb+UT8JvYNZNLpe9V7WBJNNQnW
         sNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483681; x=1703088481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RleaIatk1x4byXqF3Rxf5uDgNq4a0Bz2EL9HSkrFats=;
        b=DUHnD3g3NYuoA5+F6e0sSC4rk6QInsi/ppioEhL5+hOLz6kZUuTJbeXwQCf1cB/xLl
         JXKNvUsuI29LtV/sCjnYsNfoYoKHtVNqdGzcTg5SbXx3Bu9+kyok3YL3OO/eFa+5Wsz0
         7t8TqSPATTzMRg4DJx6FBx0rT9t77qmg8ZKxeDDZDz2sNC4iv2zN3bUjPtZJBkXhTrKh
         RctM+WQ/r2oYfZ4nyvIKtQEfzDj1fLkPXuo77CuxvUywq5tFqwqoJEgqyjYOK9KCXAt4
         Sv2ySgTauH4kmygNQqtwBB605Qqnc7nlHf4caoB8Bm52iYQtkREz/jg15MWDHcbX7/B7
         yfAw==
X-Gm-Message-State: AOJu0Yxj2mUgwdG/cKvmOAOUyidaHordY+m9AjVKDJiyhEFgiZ4uNFDW
	mncdNYH7cdKorwIJKPNRvarpMLMHfOr52ziTxye1g+El
X-Google-Smtp-Source: AGHT+IFpTSzhmV7Agq6j9W34VA8E3qluLO6zuzSJqC6lgDZgsYAU2ugEHOkytYd94LPHT2vzOYIfwA9cQZOfP8gZJ2U=
X-Received: by 2002:a2e:a805:0:b0:2cc:1e83:65ee with SMTP id
 l5-20020a2ea805000000b002cc1e8365eemr4703897ljq.56.1702483680374; Wed, 13 Dec
 2023 08:08:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+17-4r5XGnGkV5Mnd_ZzsKL0xNwhHbS0tdri9D7=U-1A@mail.gmail.com>
 <20231213155606.3610-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231213155606.3610-1-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Dec 2023 11:07:47 -0500
Message-ID: <CABBYNZKCnpr3D-nbZwMZDzuMz7CAOa_6e3+etjTiAfJTCKiU+w@mail.gmail.com>
Subject: Re: [BlueZ,v4,1/6] bap: Allow setup of multiple stream per endpoint
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: claudia.rosu@nxp.com, linux-bluetooth@vger.kernel.org, 
	silviu.barbulescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Wed, Dec 13, 2023 at 10:56=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Tuesday, December 12, 2023 7:54 PM
> > To: linux-bluetooth@vger.kernel.org
> > Cc: Iulia Tanasescu <iulia.tanasescu@nxp.com>; Silviu Florian Barbulesc=
u
> > <silviu.barbulescu@nxp.com>; Claudia Cristina Draghicescu
> > <claudia.rosu@nxp.com>
> > Subject: Re: [BlueZ,v4,1/6] bap: Allow setup of multiple stream per
> > endpoint
> >
> > Hi,
> >
> > On Mon, Dec 11, 2023 at 6:31 PM <bluez.test.bot@gmail.com> wrote:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing l=
ist.
> > > This is a CI test results with your patch series:
> > > PW
> > > Link:https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2
> > >
> > Fpatchwork.kernel.org%2Fproject%2Fbluetooth%2Flist%2F%3Fseries%3D808
> > 93
> > >
> > 8&data=3D05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447dbe67
> > d08dbf
> > >
> > b3b5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383800
> > 0462083582
> > >
> > 0%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> > CJBTiI6
> > >
> > Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DaKuHEA2BNmk3B%
> > 2BztdPJ2Mhl
> > > X1443Ki34d5537bCZuhE%3D&reserved=3D0
> >
> > Could one of you guys please verify that this set doesn't break anythin=
g
> > related to broadcast.
> >
>
> I tested this patch series for broadcast and I found two issues:
>
> First, in bap_find_setup_by_stream, for the BT_BAP_STREAM_TYPE_BCAST
> case, the function returns a pointer to an endpoint, although it's
> expected to return a pointer to the setup matching the stream.
> So it should be something similar to the unicast case:
>
> ep =3D queue_find(data->bcast, match_ep_stream, stream);
> if (ep)
>    return queue_find(ep->setups, match_setup_stream,
>                        stream);

Ok, I will fix that.

> Second, in set_configuration, after allocating a setup using
> setup_new, you should also allocate setup->base:
>
> setup->base =3D new0(struct iovec, 1).

Doesn't the base use util_iov_dup? Perhaps we need an update to code
to start using that.

> Otherwise, the configuration will not be parsed correctly for
> broadcast.
>
> We have also prepared a patch series for broadcast multiple BISes
> support, but we will have to update our implementation based on
> these patches.

While at it, perhaps it would be great to create a sample script to
test broadcast with bluetoothctl.

> > > ---Test result---
> > >
> > > Test Summary:
> > > CheckPatch                    PASS      2.70 seconds
> > > GitLint                       FAIL      1.73 seconds
> > > BuildEll                      PASS      24.71 seconds
> > > BluezMake                     PASS      780.94 seconds
> > > MakeCheck                     PASS      12.60 seconds
> > > MakeDistcheck                 PASS      164.82 seconds
> > > CheckValgrind                 PASS      225.11 seconds
> > > CheckSmatch                   PASS      330.30 seconds
> > > bluezmakeextell               PASS      103.81 seconds
> > > IncrementalBuild              PASS      4181.08 seconds
> > > ScanBuild                     WARNING   990.81 seconds
> > >
> > > Details
> > > ##############################
> > > Test: GitLint - FAIL
> > > Desc: Run gitlint
> > > Output:
> > > [BlueZ,v4,2/6] shared/bap: Make bt_bap_select match the channel map
> > >
> > > WARNING: I3 - ignore-body-lines: gitlint will be switching from using=
 Python
> > regex 'match' (match beginning) to 'search' (match anywhere) semantics.
> > Please review your ignore-body-lines.regex option accordingly. To remov=
e
> > this warning, set general.regex-style-search=3DTrue. More details:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fjor=
isro
> > overs.github.io%2Fgitlint%2Fconfiguration%2F%23regex-style-
> > search&data=3D05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447d
> > be67d08dbfb3b5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %7C638380004620835820%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> > C%7C&sdata=3DGaHyvhsb4TOR1ksh3KcJ7f%2BLCN4JynFFoQdFs1cd2d8%3D&res
> > erved=3D0
> > > 13: B3 Line contains hard tab characters (\t): "
> > 0000a0201030202010304280001020206000000000a02010302020103042
> > 8"
> > > 14: B3 Line contains hard tab characters (\t): "
> > 0002020206000000000a02010302020103042800"
> > > [BlueZ,v4,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to
> > > SelectProperties
> > >
> > > WARNING: I3 - ignore-body-lines: gitlint will be switching from using
> > > Python regex 'match' (match beginning) to 'search' (match anywhere)
> > > semantics. Please review your ignore-body-lines.regex option
> > > accordingly. To remove this warning, set
> > > general.regex-style-search=3DTrue. More details:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fj=
ori
> > > sroovers.github.io%2Fgitlint%2Fconfiguration%2F%23regex-style-search&=
d
> > >
> > ata=3D05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447dbe67d08
> > dbfb3b
> > >
> > 5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383800046
> > 20835820%7
> > >
> > CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> > iI6Ik1
> > >
> > haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DGaHyvhsb4TOR1ksh3K
> > cJ7f%2BLCN
> > > 4JynFFoQdFs1cd2d8%3D&reserved=3D0
> > > 1: T1 Title exceeds max length (81>80): "[BlueZ,v4,3/6]
> > org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties"
> > > [BlueZ,v4,6/6] client/player: Use ChannelAllocation given on
> > > SelectProperties
> > >
> > > WARNING: I3 - ignore-body-lines: gitlint will be switching from using=
 Python
> > regex 'match' (match beginning) to 'search' (match anywhere) semantics.
> > Please review your ignore-body-lines.regex option accordingly. To remov=
e
> > this warning, set general.regex-style-search=3DTrue. More details:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fjor=
isro
> > overs.github.io%2Fgitlint%2Fconfiguration%2F%23regex-style-
> > search&data=3D05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447d
> > be67d08dbfb3b5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %7C638380004620835820%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> > C%7C&sdata=3DGaHyvhsb4TOR1ksh3KcJ7f%2BLCN4JynFFoQdFs1cd2d8%3D&res
> > erved=3D0
> > > 13: B3 Line contains hard tab characters (\t): "
> > 602020600000000100201030202010304280005030200000001020206000
> > 0"
> > > 14: B3 Line contains hard tab characters (\t): "
> > 000010020103020201030428000503010000000202020600000000100201
> > 0"
> > > 15: B3 Line contains hard tab characters (\t): "
> > 302020103042800050302000000"
> > > ##############################
> > > Test: ScanBuild - WARNING
> > > Desc: Run Scan Build
> > > Output:
> > > src/shared/bap.c:4766:23: warning: Access to field 'type' results in =
a
> > dereference of a null pointer (loaded from variable 'lpac')
> > >                 if (!match.rpac && (lpac->type !=3D BT_BAP_BCAST_SOUR=
CE))
> > >                                     ^~~~~~~~~~
> > > 1 warning generated.
> > > In file included from tools/mesh-gatt/crypto.c:32:
> > > ./src/shared/util.h:228:9: warning: 1st function call argument is an
> > uninitialized value
> > >         return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
> > >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > ./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
> > > #define be32_to_cpu(val) bswap_32(val)
> > >                          ^~~~~~~~~~~~~
> > > /usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
> > > #define bswap_32(x) __bswap_32 (x)
> > >                     ^~~~~~~~~~~~~~
> > > In file included from tools/mesh-gatt/crypto.c:32:
> > > ./src/shared/util.h:238:9: warning: 1st function call argument is an
> > uninitialized value
> > >         return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
> > >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > ./src/shared/util.h:34:26: note: expanded from macro 'be64_to_cpu'
> > > #define be64_to_cpu(val) bswap_64(val)
> > >                          ^~~~~~~~~~~~~
> > > /usr/include/byteswap.h:37:21: note: expanded from macro 'bswap_64'
> > > #define bswap_64(x) __bswap_64 (x)
> > >                     ^~~~~~~~~~~~~~
> > > 2 warnings generated.
> > >
> > >
> > >
> > > ---
> > > Regards,
> > > Linux Bluetooth
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
> Regards,
> Iulia
>


--=20
Luiz Augusto von Dentz
