Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B59DEED619
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 17:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjIORNI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjIORMo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 13:12:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BCD2721
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 10:12:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso38155891fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694797944; x=1695402744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nOGdeIjlkxgJCMWDOrzuVoFHtWbGUqmh9LOKoPOHJ4=;
        b=JuJTHTQFAu0i2UxhD9AM0O52iCPdX4Xfzi1VsdW8mD9JbGEDVJxhVPs6BKEnzpW47H
         vIiny6RGBZA83O71dqggPp9kVmQ5CQl75DuL+w0CO0BJbmNONNJn1/Bfg6+atNeBTs+A
         KdPxQIjKoJ0VWfuPb6K/s67wVIg9aD8NBLqhyF2g4YkuYX5ABS4i38jGjobaUxgQ8ix9
         PR81f4xd7c42EoDXqFbpAea6Oyj64n4ntVRgP14sX7uEPolGFLAT9E7Dg7f7BITqflPU
         f30d3yJsXEWyhY6uIau8h8LUOFMxGm5FTHy4NF4u+aGQNn3SYsfmm9gpyi+mWpp1Dp2o
         4eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797944; x=1695402744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nOGdeIjlkxgJCMWDOrzuVoFHtWbGUqmh9LOKoPOHJ4=;
        b=ArmvQjIVYpDz1jx6hINJwFXshCb1COkDfFhyE2oq/Hc9nQ9h8FEw65alKEKu2QzIBg
         dFLUUMyz5nGCJwZwqUI0W+0FDZ7MnzbUGQ1gCQzIjSDFAPYmP+YRJGvSahAk/fTqWb/Z
         Xv1VK6fACIBnA74xcPnubVfuNvkR/EisPxKWCfFlawK81IMF8tPVt5eA3UXErEADLmoh
         PwdMyWuiPQK4yCMU670eFGJ2OGNJydbdsLLqIBdhfDVPkBxgJhXGwvZfQtYrLAwIRhYq
         MghbGAP1Sf0iHkzjTIkDhjfrHTECSUi8nMgBPVzPPG/EWMtGSpo4ZQ/2znoGuM+R2J//
         K12Q==
X-Gm-Message-State: AOJu0Yz5QT1U0M1Vmq3POOztzIb3zWo1U65G1Cdm55P7kC4yw1ngXDG/
        R/UzhdyEC2c291BE+1YOOzInsqtzOibAdTOKHJmyqb5PgfI=
X-Google-Smtp-Source: AGHT+IHuwQysoIt4AfR8eVesXEIFL8rnnSP5B68wVEP22yahjPs15GDSjFPdOtFfJtH6Tbs0jgbl1mfdwDpqqUJMON8=
X-Received: by 2002:a2e:8514:0:b0:2b9:dd5d:5d0c with SMTP id
 j20-20020a2e8514000000b002b9dd5d5d0cmr1843610lji.52.1694797943449; Fri, 15
 Sep 2023 10:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230915131831.119124-2-mahesh.talewad@nxp.com> <65046dbf.050a0220.8105c.1a03@mx.google.com>
In-Reply-To: <65046dbf.050a0220.8105c.1a03@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 15 Sep 2023 10:12:10 -0700
Message-ID: <CABBYNZKJLypxh25ZTUeWqr6oEFCzOzyPeD0rpMUkEO7Uds-pLA@mail.gmail.com>
Subject: Re: Implementation of MICP and MICS Unit Testcases
To:     linux-bluetooth@vger.kernel.org
Cc:     mahesh.talewad@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mahesh.

On Fri, Sep 15, 2023 at 7:46=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D784=
602
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.04 seconds
> GitLint                       PASS      0.30 seconds
> BuildEll                      PASS      28.66 seconds
> BluezMake                     PASS      1053.57 seconds
> MakeCheck                     FAIL      12.85 seconds
> MakeDistcheck                 FAIL      143.90 seconds
> CheckValgrind                 FAIL      268.91 seconds
> CheckSmatch                   PASS      366.65 seconds
> bluezmakeextell               PASS      112.59 seconds
> IncrementalBuild              PASS      894.39 seconds
> ScanBuild                     PASS      1115.57 seconds
>
> Details
> ##############################
> Test: MakeCheck - FAIL
> Desc: Run Bluez Make Check
> Output:
>
> ./test-driver: line 107: 31420 Aborted                 (core dumped) "$@"=
 > $log_file 2>&1
> make[3]: *** [Makefile:11433: test-suite.log] Error 1
> make[2]: *** [Makefile:11541: check-TESTS] Error 2
> make[1]: *** [Makefile:11963: check-am] Error 2
> make: *** [Makefile:11965: check] Error 2
> ##############################
> Test: MakeDistcheck - FAIL
> Desc: Run Bluez Make Distcheck
> Output:
>
> ../../test-driver: line 107: 53073 Aborted                 (core dumped) =
"$@" > $log_file 2>&1
> make[4]: *** [Makefile:11433: test-suite.log] Error 1
> make[3]: *** [Makefile:11541: check-TESTS] Error 2
> make[2]: *** [Makefile:11963: check-am] Error 2
> make[1]: *** [Makefile:11965: check] Error 2
> make: *** [Makefile:11886: distcheck] Error 1
> ##############################
> Test: CheckValgrind - FAIL
> Desc: Run Bluez Make Check with Valgrind
> Output:
>
> tools/mgmt-tester.c: In function =E2=80=98main=E2=80=99:
> tools/mgmt-tester.c:12763:5: note: variable tracking size limit exceeded =
with =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
> 12763 | int main(int argc, char *argv[])
>       |     ^~~~
> ./test-driver: line 107: 72497 Aborted                 (core dumped) "$@"=
 > $log_file 2>&1
> make[3]: *** [Makefile:11433: test-suite.log] Error 1
> make[2]: *** [Makefile:11541: check-TESTS] Error 2
> make[1]: *** [Makefile:11963: check-am] Error 2
> make: *** [Makefile:11965: check] Error 2
>
>
> ---
> Regards,
> Linux Bluetooth

# unit/test-micp -d
MICS/SR/SPE/BI-02-C - run
  test-micp: < 02 40 00                                         .@.
  bt_att:src/shared/att.c:can_read_data() (chan 0x5630a1de6460) ATT
PDU received: 0x02
  bt_gatt_server:src/shared/gatt-server.c:exchange_mtu_cb() MTU
exchange complete, with MTU: 64
  test-micp: > 03 40 00                                         .@.
  test-micp: < 10 01 00 ff ff 00 28                             ......(
  bt_att:src/shared/att.c:can_read_data() (chan 0x5630a1de6460) ATT
PDU received: 0x10
  bt_gatt_server:src/shared/gatt-server.c:read_by_grp_type_cb() Read
By Grp Type - start: 0x0001 end: 0xffff
  test-micp: > 11 06 01 00 04 00 4d 18                          ......M.
  test-micp: < 10 05 00 ff ff 00 28                             ......(
  bt_att:src/shared/att.c:can_read_data() (chan 0x5630a1de6460) ATT
PDU received: 0x10
  bt_gatt_server:src/shared/gatt-server.c:read_by_grp_type_cb() Read
By Grp Type - start: 0x0005 end: 0xffff
  test-micp: > 01 10 05 00 0a                                   .....
  test-micp: < 06 01 00 ff ff 00 28 4d 18                       ......(M.
  bt_att:src/shared/att.c:can_read_data() (chan 0x5630a1de6460) ATT
PDU received: 0x06
  bt_gatt_server:src/shared/gatt-server.c:find_by_type_val_cb() Find
By Type Value - start: 0x0001 end: 0xffff uuid: 0x2800
  test-micp: > 07 01 00 04 00                                   .....
  test-micp: < 06 05 00 ff ff 00 28 4d 18                       ......(M.
  bt_att:src/shared/att.c:can_read_data() (chan 0x5630a1de6460) ATT
PDU received: 0x06
  bt_gatt_server:src/shared/gatt-server.c:find_by_type_val_cb() Find
By Type Value - start: 0x0005 end: 0xffff uuid: 0x2800
  test-micp: > 01 06 05 00 0a                                   .....
  test-micp: < 0a 03 00                                         ...
  bt_att:src/shared/att.c:can_read_data() (chan 0x5630a1de6460) ATT
PDU received: 0x0a
  bt_gatt_server:src/shared/gatt-server.c:handle_read_req() Read Req -
handle: 0x0003
  bt_gatt_server:src/shared/gatt-server.c:read_complete_cb() Read
Complete: err 0
  test-micp: > 0b 01                                            ..
  test-micp: ! 0b 02                                            ..
**
ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) =3D=3D 0)
Bail out! ERROR:src/shared/tester.c:954:test_io_recv: assertion
failed: (memcmp(buf, iov->iov_base, len) =3D=3D 0)


--=20
Luiz Augusto von Dentz
