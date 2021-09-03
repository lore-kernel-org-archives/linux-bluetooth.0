Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0944C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 23:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9073C6108E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 23:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350427AbhICXNA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 19:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349369AbhICXM7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 19:12:59 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BDC061575
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Sep 2021 16:11:58 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id g16so431413uam.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sd594KvbZ1dG6SEsLOz7bokZYP96xYNBscQY44YRHJc=;
        b=Xpam+Sawzwi4OdxS2lQE6q6bPbJCKGZ7WwpsAEdKy3Sq0s0Yh/giVt/VAOdg2oWBcV
         bXdMBvB8sAoF8+8o2Mzk7+pz2p3FaBCzRa3NL9BGxkw1olWc40YYkNxkycCiNOZ8IqHD
         x/9TRPwbWO+Uxo53LJoEqE7HpOSDDeYSQ0NW+mLckqaKnnXPpmxv36c1Ru3ZYyQETNjM
         fUDx0p6rqiooDN0n+ZJWOOMcEvz+X+Y56Ro/ax0BsT8xZOM4kuJ+ZXIhihp7l6iGMQn4
         7NGGfu90tOJ47ohuzywixg+jjqjhYz+BWXrc98u+VdzTCiG5dKdRC4WFaX0oHSopa2cO
         EDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sd594KvbZ1dG6SEsLOz7bokZYP96xYNBscQY44YRHJc=;
        b=jbKJn2L1Hud5dOZYqc3BlGbD1X59Bj3010XJyOY55XQbH2eYveYIXfzdi3VG4e4rFx
         wH0DBPOCcDxS2PYwczBWe2ariosKKjaSt/803JaUlV+NoATI87r9P5Xof+v68U/IMBNq
         7R+g9HtsWT6pJUyTRI6GHlYjnu2Ru8YHCEFdGkvTNMVlO1gysS5EJ+3ga2E8JFBM8Tsn
         eIMHkllwd2RyhYkG6hqrRhJwfRTOc/R4BAMLHKYJF+Y9BPzNXqHyD7whFQDHvw9rkIWA
         mG1JVgLL0OjFEa6BNbPD2iMCDhrWcGxY34IO7MVO0AwAZ+quAGstrOqojr3oDBjiqmki
         N8Kw==
X-Gm-Message-State: AOAM530HQx/jhPJOIs0Q98hveJf/C2Q9bB78PbclrM63Gtln4jewyd6M
        HMzl+u07rQQ1Ti6Z7mIF2kHWnMOfOSioLsWl5KxhzS1Lbqg=
X-Google-Smtp-Source: ABdhPJwjdQ7HxeqtmZujVK/NYMaMKKcEue3qALg6NrsD1kZ6wEnRF2cnIKxEH7yGVTeJLqBI6O0gVUYqq6vynJLK0cU=
X-Received: by 2002:ab0:71d8:: with SMTP id n24mr785225uao.129.1630710717634;
 Fri, 03 Sep 2021 16:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210902120509.Bluez.v2.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
 <61305652.1c69fb81.afbf6.43ab@mx.google.com>
In-Reply-To: <61305652.1c69fb81.afbf6.43ab@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Sep 2021 16:11:46 -0700
Message-ID: <CABBYNZ+Sv3O67MSngcNisyxAv11x5Ks3jnFo3nqaRu8hpevTFA@mail.gmail.com>
Subject: Re: Inclusive language changes
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@google.com>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie, Tedd,

On Wed, Sep 1, 2021 at 9:51 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D540=
975
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      4.45 seconds
> GitLint                       FAIL      1.28 seconds
> Prep - Setup ELL              PASS      39.55 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      6.94 seconds
> Build - Make                  PASS      171.01 seconds
> Make Check                    PASS      8.97 seconds
> Make Distcheck                PASS      207.59 seconds
> Build w/ext ELL - Configure   PASS      7.26 seconds
> Build w/ext ELL - Make        PASS      160.39 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> lib: Inclusive language changes
> ERROR:SPACING: space required after that ',' (ctx:VxV)
> #146: FILE: lib/hci.c:739:
> +               { "<AFH class. perip.>",LMP_AFH_CLS_PRP },      /* Bit 4 =
*/
>                                        ^
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute_=
_((packed))
> #296: FILE: lib/hci.h:427:
> +} __attribute__ ((packed)) central_link_key_cp;
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute_=
_((packed))
> #312: FILE: lib/hci.h:1568:
> +} __attribute__ ((packed)) le_read_accept_list_size_rp;
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute_=
_((packed))
> #325: FILE: lib/hci.h:1577:
> +} __attribute__ ((packed)) le_add_device_to_accept_list_cp;
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute_=
_((packed))
> #335: FILE: lib/hci.h:1584:
> +} __attribute__ ((packed)) le_remove_device_from_accept_list_cp;
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute_=
_((packed))
> #352: FILE: lib/hci.h:1812:
> +} __attribute__ ((packed)) evt_central_link_key_complete;

@Tedd we should probably shut down warnings like above, since that
only apply to the kernel tree.

> WARNING:LONG_LINE: line length of 81 exceeds 80 columns
> #378: FILE: lib/hci_lib.h:120:
> +int hci_le_add_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t type,=
 int to);
>
> - total: 1 errors, 6 warnings, 531 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> "[PATCH] lib: Inclusive language changes" has style problems, please revi=
ew.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> monitor: Inclusive language changes
> WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
> #1147: FILE: monitor/packet.c:3681:
> +                       print_field("Peripheral Conn. Interval: 0x%4.4x -=
 0x%4.4x",
>
> ERROR:TRAILING_WHITESPACE: trailing whitespace
> #1388: FILE: monitor/packet.c:8075:
> +^Iprint_field("Central to Peripheral Maximum SDU: 0x%4.4x", $
>
> WARNING:LONG_LINE: line length of 84 exceeds 80 columns
> #1538: FILE: monitor/packet.c:10261:
> +       const struct bt_hci_evt_peripheral_broadcast_channel_map_change *=
evt =3D data;

@Archie Pusaka you will need to fix these long lines going past 80
columns, also maybe it would have been better to cut
peripheral_broadcast from the struct name above since channel_map
should be enough to distinct from other events.

> - total: 1 errors, 2 warnings, 1635 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> NOTE: Whitespace errors detected.
>       You may wish to use scripts/cleanpatch or scripts/cleanfile
>
> "[PATCH] monitor: Inclusive language changes" has style problems, please =
review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> emulator: Inclusive language changes
> WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
> #130: FILE: emulator/btdev.c:3609:
> +        * =E2=80=A2 any advertising filter policy uses the Accept List a=
nd advertising
>
> WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
> #177: FILE: emulator/btdev.c:3646:
> +        * =E2=80=A2 any advertising filter policy uses the Accept List a=
nd advertising
>
> WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
> #232: FILE: emulator/btdev.c:3697:
> +        * =E2=80=A2 any advertising filter policy uses the Accept List a=
nd advertising
>
> WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
> #383: FILE: emulator/btdev.c:6188:
> +       btdev->le_features[0] |=3D 0x08;  /* Peripheral-initiated Feature=
s Exchange */
>
> WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
> #607: FILE: emulator/le.c:346:
> +       //hci->le_features[0] |=3D 0x08;  /* Peripheral-initiated Feature=
s Exchange */
>
> WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
> #628: FILE: emulator/le.c:402:
> +       hci->le_states[0] |=3D 0x40;      /* Initiating + Connection (Cen=
tral Role) */
>
> - total: 0 errors, 6 warnings, 894 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> "[PATCH] emulator: Inclusive language changes" has style problems, please=
 review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> tools: Inclusive language changes
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (pref=
er a maximum 75 chars per line)
> #10:
> https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Lang=
uage_Mapping_Table.pdf
>
> WARNING:LONG_LINE: line length of 92 exceeds 80 columns
> #340: FILE: tools/hciconfig.c:1925:
> +       { "block",      cmd_block,      "<bdaddr>",     "Add a device to =
the reject list" },
>
> WARNING:LONG_LINE: line length of 97 exceeds 80 columns
> #341: FILE: tools/hciconfig.c:1926:
> +       { "unblock",    cmd_unblock,    "<bdaddr>",     "Remove a device =
from the reject list" },
>
> ERROR:INITIALISED_STATIC: do not initialise statics to 0
> #861: FILE: tools/l2test.c:113:
> +static int central =3D 0;
>
> WARNING:MISSING_SPACE: break quoted strings at a space character
> #906: FILE: tools/l2test.c:1340:
>         while ((opt =3D getopt(argc, argv, "a:b:cde:g:i:mnpqrstuwxyz"
> +               "AB:CD:EF:GH:I:J:K:L:M:N:O:P:Q:RSTUV:W:X:Y:Z:")) !=3D EOF=
) {
>
> ERROR:FUNCTION_WITHOUT_ARGS: Bad function definition - void setup_accept_=
list() should probably be void setup_accept_list(void)
> #1033: FILE: tools/mesh-gatt/net.c:944:
> +static void setup_accept_list()
>
> WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
> #1657: FILE: tools/mgmt-tester.c:11605:
> +       test_bredrle50_full("Ext Adv. connectable & connected (peripheral=
) - Success",
>
> WARNING:LONG_LINE_STRING: line length of 90 exceeds 80 columns
> #1664: FILE: tools/mgmt-tester.c:11610:
> +       test_bredrle50_full("Ext Adv. non-connectable & connected (periph=
eral) - Success",
>
> WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
> #1671: FILE: tools/mgmt-tester.c:11615:
> +       test_bredrle50_full("Ext Adv. connectable & connected (central) -=
 Success",
>
> WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
> #1678: FILE: tools/mgmt-tester.c:11620:
> +       test_bredrle50_full("Ext Adv. non-connectable & connected (centra=
l) - Success",
>
> WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
> #1725: FILE: tools/parser/avdtp.c:662:
> +               printf("AVDTP(c): ver %d %s%scc %d %spt %d seqn %d time %=
d ssrc %d\n",
>
> WARNING:LONG_LINE: line length of 81 exceeds 80 columns
> #1874: FILE: tools/parser/hci.c:1643:
> +                       (cp->filter =3D=3D 0x01 ? "accept list only" : "r=
eserved")));
>
> ERROR:INITIALISED_STATIC: do not initialise statics to 0
> #2196: FILE: tools/rctest.c:79:
> +static int central =3D 0;
>
> WARNING:LONG_LINE: line length of 90 exceeds 80 columns
> #2239: FILE: tools/rctest.c:700:
> +       while ((opt=3Dgetopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W:M=
:D:Y:T")) !=3D EOF) {
>
> ERROR:SPACING: spaces required around that '=3D' (ctx:VxV)
> #2239: FILE: tools/rctest.c:700:
> +       while ((opt=3Dgetopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W:M=
:D:Y:T")) !=3D EOF) {
>                    ^
>
> ERROR:SPACING: space required after that ',' (ctx:VxV)
> #2239: FILE: tools/rctest.c:700:
> +       while ((opt=3Dgetopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W:M=
:D:Y:T")) !=3D EOF) {
>                                ^
>
> ERROR:SPACING: space required after that ',' (ctx:VxV)
> #2239: FILE: tools/rctest.c:700:
> +       while ((opt=3Dgetopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W:M=
:D:Y:T")) !=3D EOF) {
>                                     ^
>
> ERROR:INITIALISED_STATIC: do not initialise statics to 0
> #2347: FILE: tools/rfcomm.c:40:
> +static int central =3D 0;
>
> WARNING:LONG_LINE: line length of 91 exceeds 80 columns
> #2383: FILE: tools/rfcomm.c:683:
> +       while ((opt =3D getopt_long(argc, argv, "+i:rahAESCL:", main_opti=
ons, NULL)) !=3D -1) {
>
> - total: 7 errors, 12 warnings, 2159 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> "[PATCH] tools: Inclusive language changes" has style problems, please re=
view.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> profiles: Inclusive language changes
> WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
> #87: FILE: profiles/health/mcap.c:56:
> +       guint           remote_caps;    /* CSP-Peripheral: remote central=
 got caps */
>
> WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
> #88: FILE: profiles/health/mcap.c:57:
> +       guint           rem_req_acc;    /* CSP-Peripheral: accuracy requi=
red by central */
>
> WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
> #94: FILE: profiles/health/mcap.c:63:
> +       void            *csp_priv_data; /* CSP-Central: In-flight request=
 data */
>
> WARNING:LONG_LINE_COMMENT: line length of 100 exceeds 80 columns
> #116: FILE: profiles/health/mcap.h:273:
> +       mcap_info_ind_event_cb  mcl_sync_infoind_cb;    /* (CSP Central) =
Received info indication */
>
> - total: 0 errors, 4 warnings, 87 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> "[PATCH] profiles: Inclusive language changes" has style problems, please=
 review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> src: Inclusive language changes
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (pref=
er a maximum 75 chars per line)
> #10:
> https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Lang=
uage_Mapping_Table.pdf
>
> ERROR:INITIALISED_STATIC: do not initialise statics to NULL
> #36: FILE: src/adapter.c:115:
> +static struct mgmt *mgmt_primary =3D NULL;
>
> - total: 1 errors, 1 warnings, 478 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> "[PATCH] src: Inclusive language changes" has style problems, please revi=
ew.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> mesh: Inclusive language changes
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (pref=
er a maximum 75 chars per line)
> #7:
> https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Lang=
uage_Mapping_Table.pdf
>
> ERROR:INITIALISED_STATIC: do not initialise statics to 0
> #28: FILE: mesh/net-keys.c:56:
> +static uint32_t last_flooding_id =3D 0;
>
> - total: 1 errors, 1 warnings, 146 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> "[PATCH] mesh: Inclusive language changes" has style problems, please rev=
iew.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> unit/mesh: Inclusive language changes
> WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (pref=
er a maximum 75 chars per line)
> #7:
> https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Lang=
uage_Mapping_Table.pdf
>
> - total: 0 errors, 1 warnings, 16 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> "[PATCH] unit/mesh: Inclusive language changes" has style problems, pleas=
e review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.

You should probably add a hook like the following

cat .git/hooks/pre-commit
exec git diff --cached | <pathto:checkpatch.pl> -q --no-signoff
--ignore CAMELCASE,NEW_TYPEDEFS,INITIALISED_STATIC,GLOBAL_INITIALISERS,PREF=
ER_PACKED,SPACING,FSF_MAILING_ADDRESS,TRAILING_STATEMENTS,RETURN_VOID,FILE_=
PATH_CHANGES,COMPLEX_MACRO,SPLIT_STRING,OPEN_BRACE,MISSING_SPACE,STATIC_CON=
ST_CHAR_ARRAY,LINE_SPACING,SYMBOLIC_PERMS,SPDX_LICENSE_TAG,SUSPECT_CODE_IND=
ENT,SSCANF_TO_KSTRTO,EXECUTE_PERMISSIONS
--show-types -

I should probably add something like this to HACKING so I don't have
to remind contributors how to use checkpatch locally.

>
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint with rule in .gitlint
> Output:
> tools: Inclusive language changes
> 7: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetoo=
th.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"
>
> src: Inclusive language changes
> 7: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetoo=
th.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"
>
> mesh: Inclusive language changes
> 4: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetoo=
th.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"
>
> unit/mesh: Inclusive language changes
> 4: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetoo=
th.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"
>
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
