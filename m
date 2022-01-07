Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 22:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiAGWsE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiAGWsD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 17:48:03 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF074C061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jan 2022 14:48:03 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id c6so18734009ybk.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jan 2022 14:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=icJ1gEsLILqefcD8wBqj6LtZVTrSzBxiVWzHObOZqo8=;
        b=YHJLXEfjpzltHax6Jc1roerWBthSp8aRV+Lfh+3uGN2exPi8mNGbyShW+11ORdwmd1
         80fkvB84p7HovA9YvqWeh2I4KpFyUzl/K8QtkPYNPBLZqY6g4+12Hy19aMC/NlgjygtP
         NFF7i7l91my3Pk7+942bcvNfscdoGDhyEaa8D8421uedioi6TQgl7alKUkDHNOlNzItj
         p0SMKOTvPrG4tQDtwVd6w971764eL/bqtivzb6b9PNh20nFWEax84eWACefGVLL+6HSZ
         DKtJyneix9w3TwEshRV6BIIFopTKlZg6tU8mrtI8d17eE0Lh7blqVg63nAXBJqwSZHBF
         iY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=icJ1gEsLILqefcD8wBqj6LtZVTrSzBxiVWzHObOZqo8=;
        b=aGtoKvlAtTIbLtnrXOpaW5GvmivENjSPWo9JaC8aLjHheow+bTrCba3XaKrXjBjIQn
         qpbf64zFfVEB00wgoQHS2IMK544Bub+zk/jkf2bmcRTgLiJOqcPLTFLdEejtWQXuJQl+
         H4tRgQ63GEJ2S10BvzENweVyxdPToBkrdQVidn7cY+uwsmZlMb/x725LJ2pxT+33FwL9
         1nQyI2hlLCXwyACeix9gRVR8GAftiBVQU5clSj6cqFS5MO+2HGbyH0RVamr4834KRn4E
         FYehlKcuW4/TJc3PgYoRkNAEHK2g68+C9bUcVgkTUqRJarRSAf9/mAzm9xD9dEWeWoSw
         /BYA==
X-Gm-Message-State: AOAM530/zkJCGKoRojPjZaw7W+TwkRYBnuqzhzLxeIOrc+ycWbNDU645
        yALdAiNZPIRhwQXBcB0b66tjLApcHtPRP/iiDN81SJQy
X-Google-Smtp-Source: ABdhPJz/9XtV7h7T6hh9znJu10I0+5C1DrRqASWJqWCmXnIBltNcVy9X5HgUN4BBeZewMIpLW4TRUPFBCNSxz4oTUNQ=
X-Received: by 2002:a05:6902:72a:: with SMTP id l10mr6034682ybt.293.1641595682740;
 Fri, 07 Jan 2022 14:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20220107213216.3754372-1-luiz.dentz@gmail.com> <61d8c001.1c69fb81.24621.10e4@mx.google.com>
In-Reply-To: <61d8c001.1c69fb81.24621.10e4@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jan 2022 14:47:52 -0800
Message-ID: <CABBYNZL5hh7+4B_2C4KsKZF-bd041CSSqK6MqPcc7BMCVKuBMA@mail.gmail.com>
Subject: Re: [BlueZ] avdtp: Fix runtime errors passing NULL to memcpy
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jan 7, 2022 at 2:34 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D603=
674
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.65 seconds
> GitLint                       PASS      0.99 seconds
> Prep - Setup ELL              PASS      42.29 seconds
> Build - Prep                  PASS      0.74 seconds
> Build - Configure             PASS      8.38 seconds
> Build - Make                  FAIL      1256.13 seconds
> Make Check                    FAIL      3.67 seconds
> Make Check w/Valgrind         FAIL      261.62 seconds
> Make Distcheck                FAIL      158.23 seconds
> Build w/ext ELL - Configure   PASS      8.46 seconds
> Build w/ext ELL - Make        FAIL      1230.37 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
> Details
> ##############################
> Test: Build - Make - FAIL
> Desc: Build the BlueZ source tree
> Output:
> tools/mgmt-tester.c: In function =E2=80=98main=E2=80=99:
> tools/mgmt-tester.c:12364:5: note: variable tracking size limit exceeded =
with =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
> 12364 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avdtp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avdtp.c:766:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   766 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avrcp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avrcp.c:989:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   989 | int main(int argc, char *argv[])
>       |     ^~~~
> profiles/audio/avdtp.c: In function =E2=80=98send_request=E2=80=99:
> profiles/audio/avdtp.c:2710:14: error: implicit declaration of function =
=E2=80=98util_memdup=E2=80=99; did you mean =E2=80=98util_hexdump=E2=80=99?=
 [-Werror=3Dimplicit-function-declaration]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |              ^~~~~~~~~~~
>       |              util_hexdump
> profiles/audio/avdtp.c:2710:12: error: assignment to =E2=80=98void *=E2=
=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a cast=
 [-Werror=3Dint-conversion]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |            ^
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:9445: profiles/audio/bluetoothd-avdtp.o] Error 1
> make: *** [Makefile:4302: all] Error 2
>
>
> ##############################
> Test: Make Check - FAIL
> Desc: Run 'make check'
> Output:
> profiles/audio/avdtp.c: In function =E2=80=98send_request=E2=80=99:
> profiles/audio/avdtp.c:2710:14: error: implicit declaration of function =
=E2=80=98util_memdup=E2=80=99; did you mean =E2=80=98util_hexdump=E2=80=99?=
 [-Werror=3Dimplicit-function-declaration]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |              ^~~~~~~~~~~
>       |              util_hexdump
> profiles/audio/avdtp.c:2710:12: error: assignment to =E2=80=98void *=E2=
=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a cast=
 [-Werror=3Dint-conversion]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |            ^
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:9445: profiles/audio/bluetoothd-avdtp.o] Error 1
> make: *** [Makefile:11306: check] Error 2
>
>
> ##############################
> Test: Make Check w/Valgrind - FAIL
> Desc: Run 'make check' with Valgrind
> Output:
> tools/mgmt-tester.c: In function =E2=80=98main=E2=80=99:
> tools/mgmt-tester.c:12364:5: note: variable tracking size limit exceeded =
with =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
> 12364 | int main(int argc, char *argv[])
>       |     ^~~~
> profiles/audio/avdtp.c: In function =E2=80=98send_request=E2=80=99:
> profiles/audio/avdtp.c:2710:14: error: implicit declaration of function =
=E2=80=98util_memdup=E2=80=99; did you mean =E2=80=98util_hexdump=E2=80=99?=
 [-Werror=3Dimplicit-function-declaration]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |              ^~~~~~~~~~~
>       |              util_hexdump
> profiles/audio/avdtp.c:2710:12: error: assignment to =E2=80=98void *=E2=
=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a cast=
 [-Werror=3Dint-conversion]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |            ^
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:9445: profiles/audio/bluetoothd-avdtp.o] Error 1
> make: *** [Makefile:4302: all] Error 2
>
>
> ##############################
> Test: Make Distcheck - FAIL
> Desc: Run distcheck to check the distribution
> Output:
> ../../profiles/audio/avdtp.c: In function =E2=80=98send_request=E2=80=99:
> ../../profiles/audio/avdtp.c:2710:14: warning: implicit declaration of fu=
nction =E2=80=98util_memdup=E2=80=99; did you mean =E2=80=98util_hexdump=E2=
=80=99? [-Wimplicit-function-declaration]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |              ^~~~~~~~~~~
>       |              util_hexdump
> ../../profiles/audio/avdtp.c:2710:12: warning: assignment to =E2=80=98voi=
d *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without =
a cast [-Wint-conversion]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |            ^
> /usr/bin/ld: profiles/audio/bluetoothd-avdtp.o: in function `send_request=
':
> /github/workspace/src/bluez-5.62/_build/sub/../../profiles/audio/avdtp.c:=
2710: undefined reference to `util_memdup'
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile:5877: src/bluetoothd] Error 1
> make[1]: *** [Makefile:4302: all] Error 2
> make: *** [Makefile:11227: distcheck] Error 1
>
>
> ##############################
> Test: Build w/ext ELL - Make - FAIL
> Desc: Build BlueZ source with '--enable-external-ell' configuration
> Output:
> tools/mgmt-tester.c: In function =E2=80=98main=E2=80=99:
> tools/mgmt-tester.c:12364:5: note: variable tracking size limit exceeded =
with =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
> 12364 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avdtp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avdtp.c:766:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   766 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avrcp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avrcp.c:989:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   989 | int main(int argc, char *argv[])
>       |     ^~~~
> profiles/audio/avdtp.c: In function =E2=80=98send_request=E2=80=99:
> profiles/audio/avdtp.c:2710:14: error: implicit declaration of function =
=E2=80=98util_memdup=E2=80=99; did you mean =E2=80=98util_hexdump=E2=80=99?=
 [-Werror=3Dimplicit-function-declaration]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |              ^~~~~~~~~~~
>       |              util_hexdump
> profiles/audio/avdtp.c:2710:12: error: assignment to =E2=80=98void *=E2=
=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a cast=
 [-Werror=3Dint-conversion]
>  2710 |  req->data =3D util_memdup(buffer, size);
>       |            ^
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:9445: profiles/audio/bluetoothd-avdtp.o] Error 1
> make: *** [Makefile:4302: all] Error 2
>
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.

--=20
Luiz Augusto von Dentz
