Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D968C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69F223105
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgLVLG7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 06:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLVLG6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 06:06:58 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6454DC0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 03:06:18 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:56802)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <marius@gnu.org>)
        id 1krfUb-0005uM-2L; Tue, 22 Dec 2020 06:06:13 -0500
Received: from host-37-191-236-253.lynet.no ([37.191.236.253]:35556 helo=localhost)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <marius@gnu.org>)
        id 1krfUZ-000799-Ha; Tue, 22 Dec 2020 06:06:12 -0500
From:   Marius Bakke <marius@gnu.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] sbc_primitives: Fix build on non-x86.
In-Reply-To: <CABBYNZJ1PGCTVEon28vBN0apNjne2r5NgHY8e1WDtDML+4aeEw@mail.gmail.com>
References: <PH0PR11MB51269918A2B84A3120EBD8E4D3C00@PH0PR11MB5126.namprd11.prod.outlook.com>
 <20201221184114.1300-1-marius@gnu.org>
 <CABBYNZJ1PGCTVEon28vBN0apNjne2r5NgHY8e1WDtDML+4aeEw@mail.gmail.com>
Date:   Tue, 22 Dec 2020 12:06:08 +0100
Message-ID: <87eeji6qxr.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Luiz Augusto von Dentz <luiz.dentz@gmail.com> skriver:

> Hi Marius,
>
> On Mon, Dec 21, 2020 at 10:45 AM <marius@gnu.org> wrote:
>>
>> From: Marius Bakke <marius@devup.no>
>>
>> Don't call __builtin_cpu_init unless targeting i386 or x86_64.
>> Otherwise we get an error at link time:
>>
>>   CC       sbc/sbc_primitives.lo
>> sbc/sbc_primitives.c: In function =E2=80=98sbc_init_primitives_x86=E2=80=
=99:
>> sbc/sbc_primitives.c:596:2: warning: implicit declaration of function =
=E2=80=98__builtin_cpu_init=E2=80=99; did you mean =E2=80=98__builtin_irint=
=E2=80=99? [-Wimplicit-function-declaration]
>> [...]
>>   CCLD     src/sbcdec
>> ld: sbc/.libs/libsbc-private.a(sbc_primitives.o): in function `sbc_init_=
primitives':
>> sbc_primitives.c:(.text+0x3a30): undefined reference to `__builtin_cpu_i=
nit'
>> ---
>>  sbc/sbc_primitives.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
>> index 97a75be..d8e166a 100644
>> --- a/sbc/sbc_primitives.c
>> +++ b/sbc/sbc_primitives.c
>> @@ -593,7 +593,9 @@ static int sbc_calc_scalefactors_j(
>>
>>  static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
>>  {
>> +#if defined(__x86_64__) || defined(__i386__)
>>         __builtin_cpu_init();
>
> I would probably have the entire function under the #if here.

That makes sense; v3 sent!

Thanks,
Marius

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFDBAEBCgAtFiEEu7At3yzq9qgNHeZDoqBt8qM6VPoFAl/h0yAPHG1hcml1c0Bn
bnUub3JnAAoJEKKgbfKjOlT6ZnQIAM0vgjULIDChvWam2tz/Ror6kjPWFwOCidXz
WJzaMe/upL1l9Olt1qiK/I5fCAEDg0gLLPfoXxvc+eIRTE4QD1+HACkUO0N2x0jR
cX2+P/o6BPZCsgHyhOALLao5tT8Q267vehpwmVTf4IG1NZ8dJl4teyaJKsSoRDxR
zJUfrgnn+WkKXjJT7HdDXbAEg9Q0d7csMMS1/sE+GtgM6zw8tEgHp597bxGtM9JG
T8S0yC16N1HOlxYq44GRYIJPiPw1MkTVH2JmJA0pi3NDLN9PC47uZlxvi9s5FqFV
xZe4obAi8jSqIUhCD+wu6TddqDp95BSXzQ7Niw1yK2YIjCMZPVY=
=hn3m
-----END PGP SIGNATURE-----
--=-=-=--
