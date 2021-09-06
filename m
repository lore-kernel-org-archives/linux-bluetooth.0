Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE31C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7A961027
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbhIFIPQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhIFIPQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 04:15:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA74C061575
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 01:14:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n5so8484045wro.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 01:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RKMmjAZ4/uBn+QWO/nHhVXPsT5y/qUGB7x46KaKqlys=;
        b=FmIq/mn3RUcZklGWLioehTD+olD4O6BRHM5pU860kbbplQteTNVlJCf6Bvi+C3p0Bs
         z8qa1LuPGnASTD2d1iR3eK2IAhBxpPAzg/3IMNhg5kdrL9zZbs+eXkFjdEICiEIHC9Dw
         LuWBbyo4Q/0TsyX1W4AwpNLnN0vMBabrxmBOhwvzEA/82JepMKNWcHSDR7aqD/g5px+h
         qS3Ngs1aMpIz9SHysQNCGl4RM0I8a4ZJ8Quzscqk8NwZUlWQaC+5uNVIH+z28pLB/Mrs
         7BBkrHe9gDrgMqiaBbBmf4JTb/BW8t9uiqKYMI7GT6f1gEqv7+g8eA8iGnGz9AGewzKi
         1Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RKMmjAZ4/uBn+QWO/nHhVXPsT5y/qUGB7x46KaKqlys=;
        b=rrILvj8Fa78l7k+KXkd/r3OAh2M2CC2/RIlTePFI1TLFJceGPYSYI1WHwMO1NEfXvS
         FkNBSM7JfCR289JI3pnisnxODuwNudMXCWck+F9/jgSSP6Lb+SRAfwGG/0hSLW6dbXCX
         8RFtV4Kbr73r6NkxNkvWFmgxzNDTybYh3qN2kWO5BDcANIQ53x2mF0oShKBTLwLW9go8
         bOaqY/7o2IxAL91TQo1Ih91o9qqatdaBs+oJqsVxBfXl0QV5Wcl8XZA/+AO0B334KxWZ
         nsIRmQyh2QRTcuKZ+B6VXvFN8eBY8mS+faO2F2kGNxOS0Xmz0exOpGqNsP5iaZsxUA2l
         XAJw==
X-Gm-Message-State: AOAM530v83R+POY3e3xyN2Zcea+bp6gPTMSwxhyUfOpkId/eqBlfX6Rp
        xsCACbpuD9XX5bNFGVLoQ97ycS+jkzI4cXAXcRpNJ14+uGY=
X-Google-Smtp-Source: ABdhPJxEOVKDkQHeVosu3QcsRSl0r34835gdnQRUGCY4Tdri3UNHu3oiFb4En0lgl3cinexSrR61oGdyNsWC9dcdt/Y=
X-Received: by 2002:a5d:6352:: with SMTP id b18mr11619693wrw.116.1630916049779;
 Mon, 06 Sep 2021 01:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210902120509.Bluez.v2.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
 <61305652.1c69fb81.afbf6.43ab@mx.google.com> <CABBYNZ+Sv3O67MSngcNisyxAv11x5Ks3jnFo3nqaRu8hpevTFA@mail.gmail.com>
In-Reply-To: <CABBYNZ+Sv3O67MSngcNisyxAv11x5Ks3jnFo3nqaRu8hpevTFA@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 6 Sep 2021 16:13:58 +0800
Message-ID: <CAJQfnxGH0DQSDxHxiq7+jAg0Q0yEtbE+4CDgd_y7ViNxdaumGg@mail.gmail.com>
Subject: Re: Inclusive language changes
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks, patch series v4 is sent to address lines over 80 columns.

There's still one instance left though (in profiles/health/mcap.h)
which is much a hassle to fix. The code around seems to encourage
commenting over 80 lines and there is no good example on how we should
handle the situation. I decided to leave that as is.

Cheers,
Archie


On Sat, 4 Sept 2021 at 07:11, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie, Tedd,
>
> On Wed, Sep 1, 2021 at 9:51 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D5=
40975
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    FAIL      4.45 seconds
> > GitLint                       FAIL      1.28 seconds
> > Prep - Setup ELL              PASS      39.55 seconds
> > Build - Prep                  PASS      0.10 seconds
> > Build - Configure             PASS      6.94 seconds
> > Build - Make                  PASS      171.01 seconds
> > Make Check                    PASS      8.97 seconds
> > Make Distcheck                PASS      207.59 seconds
> > Build w/ext ELL - Configure   PASS      7.26 seconds
> > Build w/ext ELL - Make        PASS      160.39 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - FAIL
> > Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> > Output:
> > lib: Inclusive language changes
> > ERROR:SPACING: space required after that ',' (ctx:VxV)
> > #146: FILE: lib/hci.c:739:
> > +               { "<AFH class. perip.>",LMP_AFH_CLS_PRP },      /* Bit =
4 */
> >                                        ^
> >
> > WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribut=
e__((packed))
> > #296: FILE: lib/hci.h:427:
> > +} __attribute__ ((packed)) central_link_key_cp;
> >
> > WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribut=
e__((packed))
> > #312: FILE: lib/hci.h:1568:
> > +} __attribute__ ((packed)) le_read_accept_list_size_rp;
> >
> > WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribut=
e__((packed))
> > #325: FILE: lib/hci.h:1577:
> > +} __attribute__ ((packed)) le_add_device_to_accept_list_cp;
> >
> > WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribut=
e__((packed))
> > #335: FILE: lib/hci.h:1584:
> > +} __attribute__ ((packed)) le_remove_device_from_accept_list_cp;
> >
> > WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribut=
e__((packed))
> > #352: FILE: lib/hci.h:1812:
> > +} __attribute__ ((packed)) evt_central_link_key_complete;
>
> @Tedd we should probably shut down warnings like above, since that
> only apply to the kernel tree.
>
> > WARNING:LONG_LINE: line length of 81 exceeds 80 columns
> > #378: FILE: lib/hci_lib.h:120:
> > +int hci_le_add_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t typ=
e, int to);
> >
> > - total: 1 errors, 6 warnings, 531 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > "[PATCH] lib: Inclusive language changes" has style problems, please re=
view.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT =
FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STR=
ING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > monitor: Inclusive language changes
> > WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
> > #1147: FILE: monitor/packet.c:3681:
> > +                       print_field("Peripheral Conn. Interval: 0x%4.4x=
 - 0x%4.4x",
> >
> > ERROR:TRAILING_WHITESPACE: trailing whitespace
> > #1388: FILE: monitor/packet.c:8075:
> > +^Iprint_field("Central to Peripheral Maximum SDU: 0x%4.4x", $
> >
> > WARNING:LONG_LINE: line length of 84 exceeds 80 columns
> > #1538: FILE: monitor/packet.c:10261:
> > +       const struct bt_hci_evt_peripheral_broadcast_channel_map_change=
 *evt =3D data;
>
> @Archie Pusaka you will need to fix these long lines going past 80
> columns, also maybe it would have been better to cut
> peripheral_broadcast from the struct name above since channel_map
> should be enough to distinct from other events.
>
> > - total: 1 errors, 2 warnings, 1635 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > NOTE: Whitespace errors detected.
> >       You may wish to use scripts/cleanpatch or scripts/cleanfile
> >
> > "[PATCH] monitor: Inclusive language changes" has style problems, pleas=
e review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT =
FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STR=
ING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > emulator: Inclusive language changes
> > WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
> > #130: FILE: emulator/btdev.c:3609:
> > +        * =E2=80=A2 any advertising filter policy uses the Accept List=
 and advertising
> >
> > WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
> > #177: FILE: emulator/btdev.c:3646:
> > +        * =E2=80=A2 any advertising filter policy uses the Accept List=
 and advertising
> >
> > WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
> > #232: FILE: emulator/btdev.c:3697:
> > +        * =E2=80=A2 any advertising filter policy uses the Accept List=
 and advertising
> >
> > WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
> > #383: FILE: emulator/btdev.c:6188:
> > +       btdev->le_features[0] |=3D 0x08;  /* Peripheral-initiated Featu=
res Exchange */
> >
> > WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
> > #607: FILE: emulator/le.c:346:
> > +       //hci->le_features[0] |=3D 0x08;  /* Peripheral-initiated Featu=
res Exchange */
> >
> > WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
> > #628: FILE: emulator/le.c:402:
> > +       hci->le_states[0] |=3D 0x40;      /* Initiating + Connection (C=
entral Role) */
> >
> > - total: 0 errors, 6 warnings, 894 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > "[PATCH] emulator: Inclusive language changes" has style problems, plea=
se review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT =
FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STR=
ING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > tools: Inclusive language changes
> > WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (pr=
efer a maximum 75 chars per line)
> > #10:
> > https://specificationrefs.bluetooth.com/language-mapping/Appropriate_La=
nguage_Mapping_Table.pdf
> >
> > WARNING:LONG_LINE: line length of 92 exceeds 80 columns
> > #340: FILE: tools/hciconfig.c:1925:
> > +       { "block",      cmd_block,      "<bdaddr>",     "Add a device t=
o the reject list" },
> >
> > WARNING:LONG_LINE: line length of 97 exceeds 80 columns
> > #341: FILE: tools/hciconfig.c:1926:
> > +       { "unblock",    cmd_unblock,    "<bdaddr>",     "Remove a devic=
e from the reject list" },
> >
> > ERROR:INITIALISED_STATIC: do not initialise statics to 0
> > #861: FILE: tools/l2test.c:113:
> > +static int central =3D 0;
> >
> > WARNING:MISSING_SPACE: break quoted strings at a space character
> > #906: FILE: tools/l2test.c:1340:
> >         while ((opt =3D getopt(argc, argv, "a:b:cde:g:i:mnpqrstuwxyz"
> > +               "AB:CD:EF:GH:I:J:K:L:M:N:O:P:Q:RSTUV:W:X:Y:Z:")) !=3D E=
OF) {
> >
> > ERROR:FUNCTION_WITHOUT_ARGS: Bad function definition - void setup_accep=
t_list() should probably be void setup_accept_list(void)
> > #1033: FILE: tools/mesh-gatt/net.c:944:
> > +static void setup_accept_list()
> >
> > WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
> > #1657: FILE: tools/mgmt-tester.c:11605:
> > +       test_bredrle50_full("Ext Adv. connectable & connected (peripher=
al) - Success",
> >
> > WARNING:LONG_LINE_STRING: line length of 90 exceeds 80 columns
> > #1664: FILE: tools/mgmt-tester.c:11610:
> > +       test_bredrle50_full("Ext Adv. non-connectable & connected (peri=
pheral) - Success",
> >
> > WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
> > #1671: FILE: tools/mgmt-tester.c:11615:
> > +       test_bredrle50_full("Ext Adv. connectable & connected (central)=
 - Success",
> >
> > WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
> > #1678: FILE: tools/mgmt-tester.c:11620:
> > +       test_bredrle50_full("Ext Adv. non-connectable & connected (cent=
ral) - Success",
> >
> > WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
> > #1725: FILE: tools/parser/avdtp.c:662:
> > +               printf("AVDTP(c): ver %d %s%scc %d %spt %d seqn %d time=
 %d ssrc %d\n",
> >
> > WARNING:LONG_LINE: line length of 81 exceeds 80 columns
> > #1874: FILE: tools/parser/hci.c:1643:
> > +                       (cp->filter =3D=3D 0x01 ? "accept list only" : =
"reserved")));
> >
> > ERROR:INITIALISED_STATIC: do not initialise statics to 0
> > #2196: FILE: tools/rctest.c:79:
> > +static int central =3D 0;
> >
> > WARNING:LONG_LINE: line length of 90 exceeds 80 columns
> > #2239: FILE: tools/rctest.c:700:
> > +       while ((opt=3Dgetopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W=
:M:D:Y:T")) !=3D EOF) {
> >
> > ERROR:SPACING: spaces required around that '=3D' (ctx:VxV)
> > #2239: FILE: tools/rctest.c:700:
> > +       while ((opt=3Dgetopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W=
:M:D:Y:T")) !=3D EOF) {
> >                    ^
> >
> > ERROR:SPACING: space required after that ',' (ctx:VxV)
> > #2239: FILE: tools/rctest.c:700:
> > +       while ((opt=3Dgetopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W=
:M:D:Y:T")) !=3D EOF) {
> >                                ^
> >
> > ERROR:SPACING: space required after that ',' (ctx:VxV)
> > #2239: FILE: tools/rctest.c:700:
> > +       while ((opt=3Dgetopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W=
:M:D:Y:T")) !=3D EOF) {
> >                                     ^
> >
> > ERROR:INITIALISED_STATIC: do not initialise statics to 0
> > #2347: FILE: tools/rfcomm.c:40:
> > +static int central =3D 0;
> >
> > WARNING:LONG_LINE: line length of 91 exceeds 80 columns
> > #2383: FILE: tools/rfcomm.c:683:
> > +       while ((opt =3D getopt_long(argc, argv, "+i:rahAESCL:", main_op=
tions, NULL)) !=3D -1) {
> >
> > - total: 7 errors, 12 warnings, 2159 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > "[PATCH] tools: Inclusive language changes" has style problems, please =
review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT =
FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STR=
ING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > profiles: Inclusive language changes
> > WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
> > #87: FILE: profiles/health/mcap.c:56:
> > +       guint           remote_caps;    /* CSP-Peripheral: remote centr=
al got caps */
> >
> > WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
> > #88: FILE: profiles/health/mcap.c:57:
> > +       guint           rem_req_acc;    /* CSP-Peripheral: accuracy req=
uired by central */
> >
> > WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
> > #94: FILE: profiles/health/mcap.c:63:
> > +       void            *csp_priv_data; /* CSP-Central: In-flight reque=
st data */
> >
> > WARNING:LONG_LINE_COMMENT: line length of 100 exceeds 80 columns
> > #116: FILE: profiles/health/mcap.h:273:
> > +       mcap_info_ind_event_cb  mcl_sync_infoind_cb;    /* (CSP Central=
) Received info indication */
> >
> > - total: 0 errors, 4 warnings, 87 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > "[PATCH] profiles: Inclusive language changes" has style problems, plea=
se review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT =
FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STR=
ING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > src: Inclusive language changes
> > WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (pr=
efer a maximum 75 chars per line)
> > #10:
> > https://specificationrefs.bluetooth.com/language-mapping/Appropriate_La=
nguage_Mapping_Table.pdf
> >
> > ERROR:INITIALISED_STATIC: do not initialise statics to NULL
> > #36: FILE: src/adapter.c:115:
> > +static struct mgmt *mgmt_primary =3D NULL;
> >
> > - total: 1 errors, 1 warnings, 478 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > "[PATCH] src: Inclusive language changes" has style problems, please re=
view.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT =
FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STR=
ING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > mesh: Inclusive language changes
> > WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (pr=
efer a maximum 75 chars per line)
> > #7:
> > https://specificationrefs.bluetooth.com/language-mapping/Appropriate_La=
nguage_Mapping_Table.pdf
> >
> > ERROR:INITIALISED_STATIC: do not initialise statics to 0
> > #28: FILE: mesh/net-keys.c:56:
> > +static uint32_t last_flooding_id =3D 0;
> >
> > - total: 1 errors, 1 warnings, 146 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > "[PATCH] mesh: Inclusive language changes" has style problems, please r=
eview.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT =
FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STR=
ING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > unit/mesh: Inclusive language changes
> > WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (pr=
efer a maximum 75 chars per line)
> > #7:
> > https://specificationrefs.bluetooth.com/language-mapping/Appropriate_La=
nguage_Mapping_Table.pdf
> >
> > - total: 0 errors, 1 warnings, 16 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-in=
place.
> >
> > "[PATCH] unit/mesh: Inclusive language changes" has style problems, ple=
ase review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT =
FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STR=
ING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> You should probably add a hook like the following
>
> cat .git/hooks/pre-commit
> exec git diff --cached | <pathto:checkpatch.pl> -q --no-signoff
> --ignore CAMELCASE,NEW_TYPEDEFS,INITIALISED_STATIC,GLOBAL_INITIALISERS,PR=
EFER_PACKED,SPACING,FSF_MAILING_ADDRESS,TRAILING_STATEMENTS,RETURN_VOID,FIL=
E_PATH_CHANGES,COMPLEX_MACRO,SPLIT_STRING,OPEN_BRACE,MISSING_SPACE,STATIC_C=
ONST_CHAR_ARRAY,LINE_SPACING,SYMBOLIC_PERMS,SPDX_LICENSE_TAG,SUSPECT_CODE_I=
NDENT,SSCANF_TO_KSTRTO,EXECUTE_PERMISSIONS
> --show-types -
>
> I should probably add something like this to HACKING so I don't have
> to remind contributors how to use checkpatch locally.
>
> >
> > ##############################
> > Test: GitLint - FAIL
> > Desc: Run gitlint with rule in .gitlint
> > Output:
> > tools: Inclusive language changes
> > 7: B1 Line exceeds max length (95>80): "https://specificationrefs.bluet=
ooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"
> >
> > src: Inclusive language changes
> > 7: B1 Line exceeds max length (95>80): "https://specificationrefs.bluet=
ooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"
> >
> > mesh: Inclusive language changes
> > 4: B1 Line exceeds max length (95>80): "https://specificationrefs.bluet=
ooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"
> >
> > unit/mesh: Inclusive language changes
> > 4: B1 Line exceeds max length (95>80): "https://specificationrefs.bluet=
ooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"
> >
> >
> > ##############################
> > Test: Prep - Setup ELL - PASS
> > Desc: Clone, build, and install ELL
> >
> > ##############################
> > Test: Build - Prep - PASS
> > Desc: Prepare environment for build
> >
> > ##############################
> > Test: Build - Configure - PASS
> > Desc: Configure the BlueZ source tree
> >
> > ##############################
> > Test: Build - Make - PASS
> > Desc: Build the BlueZ source tree
> >
> > ##############################
> > Test: Make Check - PASS
> > Desc: Run 'make check'
> >
> > ##############################
> > Test: Make Distcheck - PASS
> > Desc: Run distcheck to check the distribution
> >
> > ##############################
> > Test: Build w/ext ELL - Configure - PASS
> > Desc: Configure BlueZ source with '--enable-external-ell' configuration
> >
> > ##############################
> > Test: Build w/ext ELL - Make - PASS
> > Desc: Build BlueZ source with '--enable-external-ell' configuration
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
>
>
> --
> Luiz Augusto von Dentz
