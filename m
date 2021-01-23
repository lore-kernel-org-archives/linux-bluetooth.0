Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE21AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Jan 2021 14:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE3923159
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Jan 2021 14:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbhAWOYJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Jan 2021 09:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbhAWOYI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Jan 2021 09:24:08 -0500
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Jan 2021 06:23:23 PST
Received: from mail.eh5.me (mail.eh5.me [IPv6:2001:19f0:7001:2deb:5400:2ff:fef8:7fd6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1224BC06174A
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Jan 2021 06:23:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A50D1349AD63;
        Sat, 23 Jan 2021 22:14:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sokka.cn; s=dkim;
        t=1611411258; h=from:subject:date:message-id:to:cc:mime-version:content-type;
        bh=WC/f4qpelNC7jbBTZZhBAQlOAKp4q7EH7vDdxLL1BSo=;
        b=WCHyMUw9MH2I5SO06tBcta0FXp2CqGOH1E7JWKdNzAiupb/qO8VvWcmo1OLahYz2y9sKD7
        wFYkSBVIgmatTr77uH83AcEZiOVbr75D7kOBF0TgFJ9idgpt4bK+d3YYx/KBN/UujDUbvU
        PapGM9BpEgdRTrsCJ51lODbY1F/YBSI=
From:   Huang-Huang Bao <eh5@sokka.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis@collabora.com>
Subject: Some headsets appear don't work when BlueZ connecting with both HSP
 AG and HFP AG.
Message-ID: <8b62372c-bb87-5dbe-200d-d32c7c94f50d@sokka.cn>
Date:   Sat, 23 Jan 2021 22:14:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6sAv2Sg2i98Sr8bNb3NvvBWcbpeQVfwJ3"
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6sAv2Sg2i98Sr8bNb3NvvBWcbpeQVfwJ3
Content-Type: multipart/mixed; boundary="7yoJUfDgnJiVBE5V3dlyGpFytgo1eGKCg";
 protected-headers="v1"
From: Huang-Huang Bao <eh5@sokka.cn>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis@collabora.com>
Message-ID: <8b62372c-bb87-5dbe-200d-d32c7c94f50d@sokka.cn>
Subject: Some headsets appear don't work when BlueZ connecting with both HSP
 AG and HFP AG.

--7yoJUfDgnJiVBE5V3dlyGpFytgo1eGKCg
Content-Type: multipart/mixed;
 boundary="------------9E72543E8E5A8434B01B65CF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9E72543E8E5A8434B01B65CF
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi linux-bluetooth,


PipeWire recently got HFP AG support,

its native headset backend registers both HSP AG profile and HFP AG=20
profile with `AutoConnect` enabled by default.

Hence, BlueZ would trying to connect headset with both HSP and HFP.=20
Seems it causes some headsets stop to work with HFP/HSP profile.

Discussions on PipeWire:=20
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/604#note_773590=


Fr=A8=A6d=A8=A6ric Danis says:
 >Currently it seems to me that there are at least 3 behaviours when=20
both native HSP and HFP are enabled, depending on the Headset/Speaker:
 >
 >    with Sony WH-1000XM3, iiuc:
 >        HFP is tried first, starting SLC process
 >        then a connection to HSP is rejected by the headset which=20
stops to send AT commands on the HFP RFComm channel
 >        Audio is not working
 >    with Sony WH-CH710N:
 >        HFP is tried first, starting SLC process
 >        then a connection to HSP is rejected by the headset, but the=20
headset keeps on sending AT commands on the HFP RFComm channel
 >        Audio is working
 >    with JBL GO 2 speaker:
 >        HFP is tried first, starting SLC process on a RFComm channel
 >        then HSP is connected on a second RFComm channel and following =

HFP AT commands are sent on this second channel
 >        Audio is not working (iirc)

Can it be fixed in BlueZ? For example, do not auto-connect HSP or HFP=20
profile if the other one has been connected. Maybe to add an extra=20
option "Conflicts" on "org.bluez.ProfileManager1.RegisterProfile()" to=20
indicate UUIDs which conflict with registered profile.

Regards,
Bao

--------------9E72543E8E5A8434B01B65CF
Content-Type: application/pgp-keys;
 name="OpenPGP_0x33C3271387A13D1B.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0x33C3271387A13D1B.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBF7ojvIBCACiWe/9ykeimw2DE152rsLJoAAetBxc9/D0ezCucAGi9o3p1aEm/tewgprmc=
IyW
r4HYA7YUVirLpPvaFBzj4z3VKEoarqjltZ8/NqHsWjmD3yOx//vDSAFJWKasnJ53LwM1UjBSP=
oNJ
fO4R6EVIaMYbfeOiQsm3sJ0iuQPz7Yyvmx/qKDYtnDfY3zRLowF7IR8D8rRpBRZVsI1o7lOa4=
UlD
4gjkNRgtOdBK70XfyQwvc2hAD0xvpskxL7eyiaWClT2tqA+iSjo4mtpPLAK29j7v6iNXZJatY=
SpL
Na90BT8hvGhDRk2AdbMjq7yyPXJcVqzcJC4wnp9ugq2RbGibFaiFABEBAAHNGkh1YW5nLUh1Y=
W5n
IEJhbyA8aUBlaDUubWU+wsCUBBMBCAA+FiEEBuXW2UEAaJ5CdDVHM8MnE4ehPRsFAl7okfoCG=
wMF
CQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQM8MnE4ehPRvEOwf/YcShzZXG2djjC=
cJp
8+vCaQLrZqe42VuwjaU57VHQaT8XxwUzxFA7Kqob5KUZyejt+CTdhHh8V8wiyGDXQS6upmv6P=
CuO
I5WXyKoG3+xBy7TtnWHKrRhR78Xegy7WYa0/xovQZR4cA4eowkxo346UPIgfydfCFhb1Twy35=
NzN
l1xXQcxnEwf4GSx7Kj7JgSYbR9rbU0Iy+dWGZr9OikfJnzuw47R1Bp1tjHm9CI3S5foa8n2bL=
H3a
x6jEiIIwcT7a0UoiX77+mfi+RGJT7Nn96igikpkmQ/z8l4XhH5t98QRJGleKRs0zncnE46vZW=
E/4
tE+i2f2gMbVz2S6LnAb2zcLA8wQQAQgAHRYhBHKYoaDXORsliPp1gjh9QFYLGYLIBQJe6JPDA=
AoJ
EDh9QFYLGYLIunUMAI/EcINbdqhFIsxbFI7GrUfRPCYX7F8346m9nk5etm51yWR04crGWpbJN=
myg
HWEZcMZTNpNl69CCuoaNTAABtawP0h1jcfzwtWuOWReMd6Z/SuqIFSBTcdI2+mRYgB2aeFwHC=
HEr
BBQhcQmtBIoeA7NE5I0SuAvOXPRegmgryNT1ABc6FbiDGeDMZFFTvQYX35fda3Px5LPznJd/T=
4C6
op6A6gyFCyHRaSsrv8EGe5MbWT4nbBTdsrhHKScrxEsoqHZj00EXXsl88I/kEZNwHdtY9RLYp=
WKR
6FrpF7HUPKY5vbEn6vGXsihsTwL9ooRHmpAoQOiNs18WYkOmnNmWI/6DFp+RqSPCjc+2IfFGE=
UYE
F311E574CdT5KvGy5OuXfG6Noh3+jJonxUNnozZoIiO9kCCpfVcPHhosTQVTTYJk4Sfnq7Ega=
cEX
DRnEIojp/b6bjqmxj2Zw6JKNLETfOSgLpHLYz8MV5BrzevCGsI/vHlNWecT0a8i1hWefmGEUI=
M0e
SHVhbmctSHVhbmcgQmFvIDxlaDVAc29ra2EuY24+wsCUBBMBCAA+FiEEBuXW2UEAaJ5CdDVHM=
8Mn
E4ehPRsFAl7ojvICGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQM8MnE4ehP=
RvW
Sgf/Ru7jw7NGjL/1/xu69Nc2ScKMZ9B4ykQTlKe+4n4xEwy2ClkSrtZRY7w7iNoB6/JqMS/9x=
DiI
YutuLUjkdyz9Ji6PQmbBJROhuO/GmXQzu41v7t49Dgd6uwb1lhNrNIYdGW8Ns73qM0Q2IbWba=
UwM
jQQN3uJ5BNuzJ+B11//Y0FrE+BBw4/30MMdbMQTwCkRZSE6yC34qSsCjcBtXH6APACzZV1ipP=
+FG
byA0OG+X/XTvJSka0n2IAofSIzdezZBKS3+6ouHUtdzGs9n6FsfMFBTrHuUhaXLfLrXHZZ5sY=
mf7
YDNSwt2jv0oXaLL2sgrzixip+fJPBnHcnXAQet6lN8LA8wQQAQgAHRYhBHKYoaDXORsliPp1g=
jh9
QFYLGYLIBQJe6I/SAAoJEDh9QFYLGYLIm8gMAKv0sfNpxFsMaibIykJq5AiEPNOmPA6yE16Ig=
4fW
EKhlWeQCaDyAIybEbiDWRmpPwlsii62wB8xFHOQFVjI5krXOOLeiWpCdOz9GTVc5ug1Tk1OW/=
rFl
DhsGG9Rtk6NtVtHLSzofZNBmUFgQQgEwNLbbcUM1iz+Xzpmn//WqKQOpHaqNJpYoZRYLRFaP4=
xRV
XewF76V8BZlO8K7lCoFqbrPEsUXR73lPOOwEgF/W1tnwJmCPcVay0Y9raWKWCg8FzxddtLGU+=
IPu
+VvP84++E/0FyFH/Z7zBXip6nH9zYQejnX92qM7uoMRJ9XWPt9EucBIbA+H5Izv5JE9IMernK=
KOv
cL9+P8u8Oag6dVsZOpgKklVBn4etd0ugzVv+DztnzFPRTCR4L0KJbfYQm6ag6V9iEHM5POnz+=
I5B
Wh6cXcc5xRDWepRcEwJKvj5HI41re4HBG38TwFgfvmf8xmE4s9ILdzz1YnTqYuRez3ROTHr/D=
ghD
6hxB0/gCRLyb/rWpxs7ATQRe6I7yAQgA7Lso1hlO8lRXWw/OKsa3uWNM9EhQmSQtwCZfAal1s=
pcV
ZGlRJj83oYJ4f4h4QiHhugOt2c5ZTEx+2Tzwi9gJ0InpC7L2i0WdhDHQQW8Sdw2UhLjsqzhXN=
yyY
oouhkZAGW3/4Urm3vbJNnv/ZKQxdAbLJ02vuhVmJILdi7Bm/yW+0t8i8OznFIN9+gwa9jyQrd=
dGe
l2AjQXp3LfLGS0j7gFYlUCkcCfhQ9NikljF/jrPLuMTTv4L46aNH3LiYeOEywktvXoDkisKfw=
4eI
rCZKtYRdh1bSHwz+cWO+A9rV8mxu1eOcRLdJtK8kHCWVECY8JkeNN7mRH8xU7VxGQUiogwARA=
QAB
wsB8BBgBCAAmFiEEBuXW2UEAaJ5CdDVHM8MnE4ehPRsFAl7ojvICGwwFCQPCZwAACgkQM8MnE=
4eh
PRt63wgAhImuq0K+9wV/tM9eixhremNm7Lhk+fRy611C+lXCHeZCxBMSHf6wBSN9X8VaakUO0=
8BP
CAKsux/2sbd0f3ePwd9jPEh65cFGfDKv7RLm6Sk3NYyRxK0ahxgOKdwShhqC5i6DyLY/zRHxX=
mXt
8SX+Yxeww7NlByTxUXPL9lwOqZTeK9wvPYF3n9e3YFiFTH865eLPzqsfEqfORPm1w6Fm3CMca=
oz+
6+dDoGVdwW1FHDC21xq4wD7M6NA7oNAP8VsLeISaFEUUftA5WXfGx75IW5ZxuUMOnJZm26lcp=
dfs
zOf1zy85CJsIxkZEum8dXWR7yOsS8rAWZnOGQjgS3XeRmQ=3D=3D
=3D/u99
-----END PGP PUBLIC KEY BLOCK-----

--------------9E72543E8E5A8434B01B65CF--

--7yoJUfDgnJiVBE5V3dlyGpFytgo1eGKCg--

--6sAv2Sg2i98Sr8bNb3NvvBWcbpeQVfwJ3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEBuXW2UEAaJ5CdDVHM8MnE4ehPRsFAmAMLykFAwAAAAAACgkQM8MnE4ehPRv4
+Af/dvjXgNIk8l5C3sVkqkiDJ01bvGstuN5w5Kn3azjvADu8oLiMFdKqebfMZg5yzIRaoX82C59+
5TFpuLND7XwKPZM2bNjmZhQ40c3tHUM+FhK8TrH/NLbSeQLsjAwLAt+xr4Ljg8+ihv0FOAIvi5J/
XTrKs289Oi+6pRWaBTH3B0k09shtaonAsQ9gA2nG9HxyCIgcG9ENVTKG5FHYYMZa+qBadcJWVegi
KhYkTzFe+eHSrL9GvAJTGlnBCgLCU2M0R8jJD3D2Mdxgj5aWKkVpDIFcHvZDQmoQgnakW3COtAPt
G8VMZ9j+hIE7mlL5ky5o4NPo916xP+qCLaRKwynj5A==
=Ei8B
-----END PGP SIGNATURE-----

--6sAv2Sg2i98Sr8bNb3NvvBWcbpeQVfwJ3--
