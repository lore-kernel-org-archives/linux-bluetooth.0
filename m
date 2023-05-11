Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE98C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 02:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEKCOM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 22:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKCOL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 22:14:11 -0400
X-Greylist: delayed 6649 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 19:14:06 PDT
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [IPv6:2001:41d0:203:375::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F42D43
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 19:14:05 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ayaya.dev; s=key1;
        t=1683771242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqKN1cS2QlxWN/cYO0zudZW7Jcy73Z/ICAy261GUDtI=;
        b=R/q99eZYqDG/c+JTSmTEB4f9BcXi4zXpkJaZPkFXKPMGMsCT2gzTsxrQv6siVo1LhVmPgR
        coOliJDx3OV0a2Me8TVzf60XkXXcnt1WwKi46BMAhWx5C5ihTWHMDnQc1rF7PriAN8UHiY
        9X0+e97S8o8P104PgHf1qzNCZuPJ9KQ=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 04:14:01 +0200
Message-Id: <CSJ339OH9S7S.3J2B7M1ZDBWC0@sumire>
Subject: Re: [BlueZ,1/3] build: set _FILE_OFFSET_BITS and _TIME_BITS to 64
 universally
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "alice" <alice@ayaya.dev>
To:     <linux-bluetooth@vger.kernel.org>
References: <20230511002252.30868-1-alice@ayaya.dev>
 <645c47f7.050a0220.31033.9ba1@mx.google.com>
In-Reply-To: <645c47f7.050a0220.31033.9ba1@mx.google.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu May 11, 2023 at 3:42 AM CEST,  wrote:
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D746=
597
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.66 seconds
> GitLint                       PASS      1.03 seconds
> BuildEll                      PASS      26.33 seconds
> BluezMake                     FAIL      37.82 seconds
> MakeCheck                     FAIL      6.89 seconds
> MakeDistcheck                 PASS      153.74 seconds
> CheckValgrind                 FAIL      29.19 seconds
> CheckSmatch                   FAIL      43.51 seconds
> bluezmakeextell               FAIL      21.79 seconds
> IncrementalBuild              FAIL      1235.52 seconds
> ScanBuild                     FAIL      717.65 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script
> Output:
> [BlueZ,3/3] tools/parser: use long long for time_t print
> WARNING:LONG_LINE: line length of 84 exceeds 80 columns
> #75: FILE: tools/parser/parser.h:127:
> +				printf("%8lu.%06llu ", f->ts.tv_sec, f->ts.tv_usec);
>
> /github/workspace/src/src/13237389.patch total: 0 errors, 1 warnings, 13 =
lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> /github/workspace/src/src/13237389.patch has style problems, please revie=
w.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: BluezMake - FAIL
> Desc: Build BlueZ
> Output:
>
> In file included from tools/hcidump.c:30:
> tools/parser/parser.h: In function =E2=80=98p_indent=E2=80=99:
> tools/parser/parser.h:123:48: error: format =E2=80=98%llu=E2=80=99 expect=
s argument of type =E2=80=98long long unsigned int=E2=80=99, but argument 8=
 has type =E2=80=98__suseconds_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} =
[-Werror=3Dformat=3D]
>   123 |     printf("%04d-%02d-%02d %02d:%02d:%02d.%06llu ",
>       |                                           ~~~~~^
>       |                                                |
>       |                                                long long unsigned=
 int

ugh, right.

two things:

- i typo'd that, and it's off by one (should be lld on the time_t not the
  suseconds_t. same below.)
- glibc only supports _TIME_BITS=3D64 on 2.34 or newer. debian bullseye (11=
)
  has 2.31, meaning that this would not work there anyway. iirc we could do
  some sort of ifdef stuff and use autoconf (assuming a new enough autoconf=
),
  but i'll just abandon this for now, and perhaps revisit this when '2.34' =
is
  considered new enough for nobody to care about. not a huge fan of adding =
macro
  checks..

sorry for the noise.

>       |                                           %06lu
>   124 |      tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>   125 |      tm.tm_hour, tm.tm_min, tm.tm_sec, f->ts.tv_usec);
>       |                                        ~~~~~~~~~~~~~
>       |                                             |
>       |                                             __suseconds_t {aka lo=
ng int}
> tools/parser/parser.h:127:23: error: format =E2=80=98%llu=E2=80=99 expect=
s argument of type =E2=80=98long long unsigned int=E2=80=99, but argument 3=
 has type =E2=80=98__suseconds_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} =
[-Werror=3Dformat=3D]
>   127 |     printf("%8lu.%06llu ", f->ts.tv_sec, f->ts.tv_usec);
>       |                  ~~~~~^                  ~~~~~~~~~~~~~
>       |                       |                       |
>       |                       long long unsigned int  __suseconds_t {aka =
long int}
>       |                  %06lu
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:7616: tools/hcidump.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:4518: all] Error 2
> ##############################
> Test: MakeCheck - FAIL
> Desc: Run Bluez Make Check
> Output:
>
> client/player.c: In function =E2=80=98transport_send_seq=E2=80=99:
> client/player.c:3581:45: error: format =E2=80=98%lld=E2=80=99 expects arg=
ument of type =E2=80=98long long int=E2=80=99, but argument 5 has type =E2=
=80=98off_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=3D]
>  3581 |   bt_shell_echo("[seq %d %d.%03ds] send: %lld/%lld bytes",
>       |                                          ~~~^
>       |                                             |
>       |                                             long long int
>       |                                          %ld
> ......
>  3584 |     offset, transport->stat.st_size);
>       |     ~~~~~~                                  =20
>       |     |
>       |     off_t {aka long int}
> client/player.c:3581:50: error: format =E2=80=98%lld=E2=80=99 expects arg=
ument of type =E2=80=98long long int=E2=80=99, but argument 6 has type =E2=
=80=98__off_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=
=3D]
>  3581 |   bt_shell_echo("[seq %d %d.%03ds] send: %lld/%lld bytes",
>       |                                               ~~~^
>       |                                                  |
>       |                                                  long long int
>       |                                               %ld
> ......
>  3584 |     offset, transport->stat.st_size);
>       |             ~~~~~~~~~~~~~~~~~~~~~~~              =20
>       |                            |
>       |                            __off_t {aka long int}
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:7616: client/player.o] Error 1
> make: *** [Makefile:11839: check] Error 2
> ##############################
> Test: CheckValgrind - FAIL
> Desc: Run Bluez Make Check with Valgrind
> Output:
>
> In file included from tools/hcidump.c:30:
> tools/parser/parser.h: In function =E2=80=98p_indent=E2=80=99:
> tools/parser/parser.h:123:48: error: format =E2=80=98%llu=E2=80=99 expect=
s argument of type =E2=80=98long long unsigned int=E2=80=99, but argument 8=
 has type =E2=80=98__suseconds_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} =
[-Werror=3Dformat=3D]
>   123 |     printf("%04d-%02d-%02d %02d:%02d:%02d.%06llu ",
>       |                                           ~~~~~^
>       |                                                |
>       |                                                long long unsigned=
 int
>       |                                           %06lu
>   124 |      tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>   125 |      tm.tm_hour, tm.tm_min, tm.tm_sec, f->ts.tv_usec);
>       |                                        ~~~~~~~~~~~~~
>       |                                             |
>       |                                             __suseconds_t {aka lo=
ng int}
> tools/parser/parser.h:127:23: error: format =E2=80=98%llu=E2=80=99 expect=
s argument of type =E2=80=98long long unsigned int=E2=80=99, but argument 3=
 has type =E2=80=98__suseconds_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} =
[-Werror=3Dformat=3D]
>   127 |     printf("%8lu.%06llu ", f->ts.tv_sec, f->ts.tv_usec);
>       |                  ~~~~~^                  ~~~~~~~~~~~~~
>       |                       |                       |
>       |                       long long unsigned int  __suseconds_t {aka =
long int}
>       |                  %06lu
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:7616: tools/hcidump.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:11839: check] Error 2
> ##############################
> Test: CheckSmatch - FAIL
> Desc: Run smatch tool with source
> Output:
>
> src/shared/crypto.c:271:21: warning: Variable length array is used.
> src/shared/crypto.c:272:23: warning: Variable length array is used.
> src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.
> src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.
> src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used=
.
> src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used=
.
> src/shared/gatt-server.c:275:25: warning: Variable length array is used.
> src/shared/gatt-server.c:618:25: warning: Variable length array is used.
> src/shared/gatt-server.c:717:25: warning: Variable length array is used.
> src/shared/shell.c: note: in included file (through /usr/include/readline=
/readline.h):
> /usr/include/readline/rltypedefs.h:35:23: warning: non-ANSI function decl=
aration of function 'Function'
> /usr/include/readline/rltypedefs.h:36:25: warning: non-ANSI function decl=
aration of function 'VFunction'
> /usr/include/readline/rltypedefs.h:37:27: warning: non-ANSI function decl=
aration of function 'CPFunction'
> /usr/include/readline/rltypedefs.h:38:29: warning: non-ANSI function decl=
aration of function 'CPPFunction'
> src/shared/crypto.c:271:21: warning: Variable length array is used.
> src/shared/crypto.c:272:23: warning: Variable length array is used.
> src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.
> src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.
> src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used=
.
> src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used=
.
> src/shared/gatt-server.c:275:25: warning: Variable length array is used.
> src/shared/gatt-server.c:618:25: warning: Variable length array is used.
> src/shared/gatt-server.c:717:25: warning: Variable length array is used.
> src/shared/shell.c: note: in included file (through /usr/include/readline=
/readline.h):
> /usr/include/readline/rltypedefs.h:35:23: warning: non-ANSI function decl=
aration of function 'Function'
> /usr/include/readline/rltypedefs.h:36:25: warning: non-ANSI function decl=
aration of function 'VFunction'
> /usr/include/readline/rltypedefs.h:37:27: warning: non-ANSI function decl=
aration of function 'CPFunction'
> /usr/include/readline/rltypedefs.h:38:29: warning: non-ANSI function decl=
aration of function 'CPPFunction'
> tools/mesh-cfgtest.c:1453:17: warning: unknown escape sequence: '\%'
> In file included from tools/hcidump.c:30:
> tools/parser/parser.h: In function =E2=80=98p_indent=E2=80=99:
> tools/parser/parser.h:123:48: error: format =E2=80=98%llu=E2=80=99 expect=
s argument of type =E2=80=98long long unsigned int=E2=80=99, but argument 8=
 has type =E2=80=98__suseconds_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} =
[-Werror=3Dformat=3D]
>   123 |     printf("%04d-%02d-%02d %02d:%02d:%02d.%06llu ",
>       |                                           ~~~~~^
>       |                                                |
>       |                                                long long unsigned=
 int
>       |                                           %06lu
>   124 |      tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>   125 |      tm.tm_hour, tm.tm_min, tm.tm_sec, f->ts.tv_usec);
>       |                                        ~~~~~~~~~~~~~
>       |                                             |
>       |                                             __suseconds_t {aka lo=
ng int}
> tools/parser/parser.h:127:23: error: format =E2=80=98%llu=E2=80=99 expect=
s argument of type =E2=80=98long long unsigned int=E2=80=99, but argument 3=
 has type =E2=80=98__suseconds_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} =
[-Werror=3Dformat=3D]
>   127 |     printf("%8lu.%06llu ", f->ts.tv_sec, f->ts.tv_usec);
>       |                  ~~~~~^                  ~~~~~~~~~~~~~
>       |                       |                       |
>       |                       long long unsigned int  __suseconds_t {aka =
long int}
>       |                  %06lu
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:7616: tools/hcidump.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:4518: all] Error 2
> ##############################
> Test: bluezmakeextell - FAIL
> Desc: Build Bluez with External ELL
> Output:
>
> In file included from tools/hcidump.c:30:
> tools/parser/parser.h: In function =E2=80=98p_indent=E2=80=99:
> tools/parser/parser.h:123:48: error: format =E2=80=98%llu=E2=80=99 expect=
s argument of type =E2=80=98long long unsigned int=E2=80=99, but argument 8=
 has type =E2=80=98__suseconds_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} =
[-Werror=3Dformat=3D]
>   123 |     printf("%04d-%02d-%02d %02d:%02d:%02d.%06llu ",
>       |                                           ~~~~~^
>       |                                                |
>       |                                                long long unsigned=
 int
>       |                                           %06lu
>   124 |      tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>   125 |      tm.tm_hour, tm.tm_min, tm.tm_sec, f->ts.tv_usec);
>       |                                        ~~~~~~~~~~~~~
>       |                                             |
>       |                                             __suseconds_t {aka lo=
ng int}
> tools/parser/parser.h:127:23: error: format =E2=80=98%llu=E2=80=99 expect=
s argument of type =E2=80=98long long unsigned int=E2=80=99, but argument 3=
 has type =E2=80=98__suseconds_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} =
[-Werror=3Dformat=3D]
>   127 |     printf("%8lu.%06llu ", f->ts.tv_sec, f->ts.tv_usec);
>       |                  ~~~~~^                  ~~~~~~~~~~~~~
>       |                       |                       |
>       |                       long long unsigned int  __suseconds_t {aka =
long int}
>       |                  %06lu
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:7616: tools/hcidump.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:4518: all] Error 2
> ##############################
> Test: IncrementalBuild - FAIL
> Desc: Incremental build with the patches in the series
> Output:
> [BlueZ,2/3] client/player: use long long for off_t print
>
> tools/mgmt-tester.c: In function =E2=80=98main=E2=80=99:
> tools/mgmt-tester.c:12655:5: note: variable tracking size limit exceeded =
with =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
> 12655 | int main(int argc, char *argv[])
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
> client/player.c: In function =E2=80=98transport_send_seq=E2=80=99:
> client/player.c:3581:45: error: format =E2=80=98%lld=E2=80=99 expects arg=
ument of type =E2=80=98long long int=E2=80=99, but argument 5 has type =E2=
=80=98off_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=3D]
>  3581 |   bt_shell_echo("[seq %d %d.%03ds] send: %lld/%lld bytes",
>       |                                          ~~~^
>       |                                             |
>       |                                             long long int
>       |                                          %ld
> ......
>  3584 |     offset, transport->stat.st_size);
>       |     ~~~~~~                                  =20
>       |     |
>       |     off_t {aka long int}
> client/player.c:3581:50: error: format =E2=80=98%lld=E2=80=99 expects arg=
ument of type =E2=80=98long long int=E2=80=99, but argument 6 has type =E2=
=80=98__off_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=
=3D]
>  3581 |   bt_shell_echo("[seq %d %d.%03ds] send: %lld/%lld bytes",
>       |                                               ~~~^
>       |                                                  |
>       |                                                  long long int
>       |                                               %ld
> ......
>  3584 |     offset, transport->stat.st_size);
>       |             ~~~~~~~~~~~~~~~~~~~~~~~              =20
>       |                            |
>       |                            __off_t {aka long int}
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:7616: client/player.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:4518: all] Error 2
> ##############################
> Test: ScanBuild - FAIL
> Desc: Run Scan Build
> Output:
>
> src/shared/ad.c:369:19: warning: Use of zero-allocated memory
>                                 buf[(*pos)++] =3D ad_type;
>                                               ^
> 1 warning generated.
> src/shared/gatt-client.c:451:21: warning: Use of memory after it is freed
>         gatt_db_unregister(op->client->db, op->db_id);
>                            ^~~~~~~~~~
> src/shared/gatt-client.c:696:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, false, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:993:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1099:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1291:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1356:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1631:6: warning: Use of memory after it is freed
>         if (read_db_hash(op)) {
>             ^~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1636:2: warning: Use of memory after it is freed
>         discover_all(op);
>         ^~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:2140:6: warning: Use of memory after it is freed
>         if (read_db_hash(op)) {
>             ^~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:2148:8: warning: Use of memory after it is freed
>                                                         discovery_op_ref(=
op),
>                                                         ^~~~~~~~~~~~~~~~~=
~~~
> src/shared/gatt-client.c:3236:2: warning: Use of memory after it is freed
>         complete_write_long_op(req, success, 0, false);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:3258:2: warning: Use of memory after it is freed
>         request_unref(req);
>         ^~~~~~~~~~~~~~~~~~
> 12 warnings generated.
> src/shared/shell.c:1228:13: warning: Access to field 'options' results in=
 a dereference of a null pointer (loaded from variable 'opt')
>                         if (c !=3D opt->options[index - offset].val) {
>                                  ^~~~~~~~~~~~
> 1 warning generated.
> src/shared/ad.c:369:19: warning: Use of zero-allocated memory
>                                 buf[(*pos)++] =3D ad_type;
>                                               ^
> 1 warning generated.
> src/shared/gatt-client.c:451:21: warning: Use of memory after it is freed
>         gatt_db_unregister(op->client->db, op->db_id);
>                            ^~~~~~~~~~
> src/shared/gatt-client.c:696:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, false, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:993:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1099:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1291:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1356:2: warning: Use of memory after it is freed
>         discovery_op_complete(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1631:6: warning: Use of memory after it is freed
>         if (read_db_hash(op)) {
>             ^~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:1636:2: warning: Use of memory after it is freed
>         discover_all(op);
>         ^~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:2140:6: warning: Use of memory after it is freed
>         if (read_db_hash(op)) {
>             ^~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:2148:8: warning: Use of memory after it is freed
>                                                         discovery_op_ref(=
op),
>                                                         ^~~~~~~~~~~~~~~~~=
~~~
> src/shared/gatt-client.c:3236:2: warning: Use of memory after it is freed
>         complete_write_long_op(req, success, 0, false);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:3258:2: warning: Use of memory after it is freed
>         request_unref(req);
>         ^~~~~~~~~~~~~~~~~~
> 12 warnings generated.
> src/shared/shell.c:1228:13: warning: Access to field 'options' results in=
 a dereference of a null pointer (loaded from variable 'opt')
>                         if (c !=3D opt->options[index - offset].val) {
>                                  ^~~~~~~~~~~~
> 1 warning generated.
> tools/hciattach.c:816:7: warning: Although the value stored to 'n' is use=
d in the enclosing expression, the value is never actually read from 'n'
>         if ((n =3D read_hci_event(fd, resp, 10)) < 0) {
>              ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/hciattach.c:864:7: warning: Although the value stored to 'n' is use=
d in the enclosing expression, the value is never actually read from 'n'
>         if ((n =3D read_hci_event(fd, resp, 4)) < 0) {
>              ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/hciattach.c:886:8: warning: Although the value stored to 'n' is use=
d in the enclosing expression, the value is never actually read from 'n'
>                 if ((n =3D read_hci_event(fd, resp, 10)) < 0) {
>                      ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/hciattach.c:908:7: warning: Although the value stored to 'n' is use=
d in the enclosing expression, the value is never actually read from 'n'
>         if ((n =3D read_hci_event(fd, resp, 4)) < 0) {
>              ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/hciattach.c:929:7: warning: Although the value stored to 'n' is use=
d in the enclosing expression, the value is never actually read from 'n'
>         if ((n =3D read_hci_event(fd, resp, 4)) < 0) {
>              ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/hciattach.c:973:7: warning: Although the value stored to 'n' is use=
d in the enclosing expression, the value is never actually read from 'n'
>         if ((n =3D read_hci_event(fd, resp, 6)) < 0) {
>              ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 6 warnings generated.
> src/oui.c:50:2: warning: Value stored to 'hwdb' is never read
>         hwdb =3D udev_hwdb_unref(hwdb);
>         ^      ~~~~~~~~~~~~~~~~~~~~~
> src/oui.c:53:2: warning: Value stored to 'udev' is never read
>         udev =3D udev_unref(udev);
>         ^      ~~~~~~~~~~~~~~~~
> 2 warnings generated.
> tools/hcidump.c:180:9: warning: Potential leak of memory pointed to by 'd=
p'
>                                 if (fds[i].fd =3D=3D sock)
>                                     ^~~
> tools/hcidump.c:248:17: warning: Assigned value is garbage or undefined
>                                 dh->ts_sec  =3D htobl(frm.ts.tv_sec);
>                                             ^ ~~~~~~~~~~~~~~~~~~~~
> tools/hcidump.c:326:9: warning: 1st function call argument is an uninitia=
lized value
>                                 if (be32toh(dp.flags) & 0x02) {
>                                     ^~~~~~~~~~~~~~~~~
> /usr/include/endian.h:46:22: note: expanded from macro 'be32toh'
> #  define be32toh(x) __bswap_32 (x)
>                      ^~~~~~~~~~~~~~
> tools/hcidump.c:341:20: warning: 1st function call argument is an uniniti=
alized value
>                                 frm.data_len =3D be32toh(dp.len);
>                                                ^~~~~~~~~~~~~~~
> /usr/include/endian.h:46:22: note: expanded from macro 'be32toh'
> #  define be32toh(x) __bswap_32 (x)
>                      ^~~~~~~~~~~~~~
> tools/hcidump.c:346:14: warning: 1st function call argument is an uniniti=
alized value
>                                 opcode =3D be32toh(dp.flags) & 0xffff;
>                                          ^~~~~~~~~~~~~~~~~
> /usr/include/endian.h:46:22: note: expanded from macro 'be32toh'
> #  define be32toh(x) __bswap_32 (x)
>                      ^~~~~~~~~~~~~~
> tools/hcidump.c:384:17: warning: Assigned value is garbage or undefined
>                         frm.data_len =3D btohs(dh.len);
>                                      ^ ~~~~~~~~~~~~~
> tools/hcidump.c:394:11: warning: Assigned value is garbage or undefined
>                 frm.len =3D frm.data_len;
>                         ^ ~~~~~~~~~~~~
> tools/hcidump.c:398:9: warning: 1st function call argument is an uninitia=
lized value
>                         ts =3D be64toh(ph.ts);
>                              ^~~~~~~~~~~~~~
> /usr/include/endian.h:51:22: note: expanded from macro 'be64toh'
> #  define be64toh(x) __bswap_64 (x)
>                      ^~~~~~~~~~~~~~
> tools/hcidump.c:403:13: warning: 1st function call argument is an uniniti=
alized value
>                         frm.in =3D be32toh(dp.flags) & 0x01;
>                                  ^~~~~~~~~~~~~~~~~
> /usr/include/endian.h:46:22: note: expanded from macro 'be32toh'
> #  define be32toh(x) __bswap_32 (x)
>                      ^~~~~~~~~~~~~~
> tools/hcidump.c:408:11: warning: Assigned value is garbage or undefined
>                         frm.in =3D dh.in;
>                                ^ ~~~~~
> tools/hcidump.c:437:7: warning: Null pointer passed to 1st parameter expe=
cting 'nonnull'
>         fd =3D open(file, open_flags, 0644);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 11 warnings generated.
> tools/rfcomm.c:228:3: warning: Value stored to 'i' is never read
>                 i =3D execvp(cmdargv[0], cmdargv);
>                 ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/rfcomm.c:228:7: warning: Null pointer passed to 1st parameter expec=
ting 'nonnull'
>                 i =3D execvp(cmdargv[0], cmdargv);
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/rfcomm.c:348:8: warning: Although the value stored to 'fd' is used =
in the enclosing expression, the value is never actually read from 'fd'
>                 if ((fd =3D open(devname, O_RDONLY | O_NOCTTY)) < 0) {
>                      ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/rfcomm.c:491:14: warning: Assigned value is garbage or undefined
>         req.channel =3D raddr.rc_channel;
>                     ^ ~~~~~~~~~~~~~~~~
> tools/rfcomm.c:509:8: warning: Although the value stored to 'fd' is used =
in the enclosing expression, the value is never actually read from 'fd'
>                 if ((fd =3D open(devname, O_RDONLY | O_NOCTTY)) < 0) {
>                      ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 5 warnings generated.
> src/sdp-xml.c:126:10: warning: Assigned value is garbage or undefined
>                 buf[1] =3D data[i + 1];
>                        ^ ~~~~~~~~~~~
> src/sdp-xml.c:300:11: warning: Assigned value is garbage or undefined
>                         buf[1] =3D data[i + 1];
>                                ^ ~~~~~~~~~~~
> src/sdp-xml.c:338:11: warning: Assigned value is garbage or undefined
>                         buf[1] =3D data[i + 1];
>                                ^ ~~~~~~~~~~~
> 3 warnings generated.
> tools/ciptool.c:350:7: warning: 5th function call argument is an uninitia=
lized value
>         sk =3D do_connect(ctl, dev_id, &src, &dst, psm, (1 << CMTP_LOOPBA=
CK));
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> 1 warning generated.
> tools/sdptool.c:941:26: warning: Result of 'malloc' is converted to a poi=
nter of type 'uint32_t', which is incompatible with sizeof operand type 'in=
t'
>                         uint32_t *value_int =3D malloc(sizeof(int));
>                         ~~~~~~~~~~            ^~~~~~ ~~~~~~~~~~~
> tools/sdptool.c:980:4: warning: 1st function call argument is an uninitia=
lized value
>                         free(allocArray[i]);
>                         ^~~~~~~~~~~~~~~~~~~
> tools/sdptool.c:3777:2: warning: Potential leak of memory pointed to by '=
si.name'
>         return add_service(0, &si);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/sdptool.c:4112:4: warning: Potential leak of memory pointed to by '=
context.svc'
>                         return -1;
>                         ^~~~~~~~~
> 4 warnings generated.
> tools/avtest.c:224:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 3);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:234:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 4);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:243:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 3);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:257:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf,
>                                 ^     ~~~~~~~~~~~~~~
> tools/avtest.c:264:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf,
>                                 ^     ~~~~~~~~~~~~~~
> tools/avtest.c:271:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf,
>                                 ^     ~~~~~~~~~~~~~~
> tools/avtest.c:278:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf,
>                                 ^     ~~~~~~~~~~~~~~
> tools/avtest.c:289:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 4);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:293:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 2);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:302:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 3);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:306:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 2);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:315:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 3);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:322:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 2);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:344:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 4);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:348:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 2);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:357:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 3);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:361:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 2);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:374:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 4);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:378:5: warning: Value stored to 'len' is never read
>                                 len =3D write(sk, buf, 2);
>                                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:385:4: warning: Value stored to 'len' is never read
>                         len =3D write(sk, buf, 2);
>                         ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:395:4: warning: Value stored to 'len' is never read
>                         len =3D write(sk, buf, 2);
>                         ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:559:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, 2);
>                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:567:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, invalid ? 2 : 3);
>                 ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/avtest.c:581:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, 4 + sizeof(media_transport));
>                 ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/avtest.c:594:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, 3);
>                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:604:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, 3);
>                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:616:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, 3);
>                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:631:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, 3);
>                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:643:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, 3);
>                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:652:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, 3);
>                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:659:3: warning: Value stored to 'len' is never read
>                 len =3D write(sk, buf, 2);
>                 ^     ~~~~~~~~~~~~~~~~~
> tools/avtest.c:695:2: warning: Value stored to 'len' is never read
>         len =3D write(sk, buf, AVCTP_HEADER_LENGTH + sizeof(play_pressed)=
);
>         ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 32 warnings generated.
> tools/btproxy.c:836:15: warning: Null pointer passed to 1st parameter exp=
ecting 'nonnull'
>                         tcp_port =3D atoi(optarg);
>                                    ^~~~~~~~~~~~
> tools/btproxy.c:839:8: warning: Null pointer passed to 1st parameter expe=
cting 'nonnull'
>                         if (strlen(optarg) > 3 && !strncmp(optarg, "hci",=
 3))
>                             ^~~~~~~~~~~~~~
> 2 warnings generated.
> tools/create-image.c:76:3: warning: Value stored to 'fd' is never read
>                 fd =3D -1;
>                 ^    ~~
> tools/create-image.c:84:3: warning: Value stored to 'fd' is never read
>                 fd =3D -1;
>                 ^    ~~
> tools/create-image.c:92:3: warning: Value stored to 'fd' is never read
>                 fd =3D -1;
>                 ^    ~~
> tools/create-image.c:105:2: warning: Value stored to 'fd' is never read
>         fd =3D -1;
>         ^    ~~
> 4 warnings generated.
> tools/btgatt-client.c:1597:2: warning: Value stored to 'argv' is never re=
ad
>         argv +=3D optind;
>         ^       ~~~~~~
> 1 warning generated.
> tools/btgatt-server.c:1212:2: warning: Value stored to 'argv' is never re=
ad
>         argv -=3D optind;
>         ^       ~~~~~~
> 1 warning generated.
> tools/check-selftest.c:42:3: warning: Value stored to 'ptr' is never read
>                 ptr =3D fgets(result, sizeof(result), fp);
>                 ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> tools/gatt-service.c:294:2: warning: 2nd function call argument is an uni=
nitialized value
>         chr_write(chr, value, len);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> tools/obex-server-tool.c:133:13: warning: Null pointer passed to 1st para=
meter expecting 'nonnull'
>         data->fd =3D open(name, O_WRONLY | O_CREAT | O_NOCTTY, 0600);
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/obex-server-tool.c:192:13: warning: Null pointer passed to 1st para=
meter expecting 'nonnull'
>         data->fd =3D open(name, O_RDONLY | O_NOCTTY, 0);
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 2 warnings generated.
> tools/btpclientctl.c:402:3: warning: Value stored to 'bit' is never read
>                 bit =3D 0;
>                 ^     ~
> tools/btpclientctl.c:1655:2: warning: Null pointer passed to 2nd paramete=
r expecting 'nonnull'
>         memcpy(cp->data, ad_data, ad_len);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 2 warnings generated.
> src/sdpd-request.c:211:13: warning: Result of 'malloc' is converted to a =
pointer of type 'char', which is incompatible with sizeof operand type 'uin=
t16_t'
>                                 pElem =3D malloc(sizeof(uint16_t));
>                                         ^~~~~~ ~~~~~~~~~~~~~~~~
> src/sdpd-request.c:239:13: warning: Result of 'malloc' is converted to a =
pointer of type 'char', which is incompatible with sizeof operand type 'uin=
t32_t'
>                                 pElem =3D malloc(sizeof(uint32_t));
>                                         ^~~~~~ ~~~~~~~~~~~~~~~~
> 2 warnings generated.
> android/avrcp-lib.c:1968:3: warning: 1st function call argument is an uni=
nitialized value
>                 g_free(text[i]);
>                 ^~~~~~~~~~~~~~~
> 1 warning generated.
> unit/test-midi.c:541:82: error: function definition is not allowed here
>         void compare_events_cb(const struct midi_write_parser *parser, vo=
id *user_data) {
>                                                                          =
               ^
> unit/test-midi.c:587:17: error: use of undeclared identifier 'compare_eve=
nts_cb'; did you mean 'compare_events'?
>                                      compare_events_cb, &midi_data);
>                                      ^~~~~~~~~~~~~~~~~
>                                      compare_events
> unit/test-midi.c:237:13: note: 'compare_events' declared here
> static void compare_events(const snd_seq_event_t *ev1,
>             ^
> 2 errors generated.
> profiles/health/hdp.c:644:3: warning: Use of memory after it is freed
>                 hdp_tmp_dc_data_unref(dc_data);
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> profiles/health/hdp.c:800:19: warning: Use of memory after it is freed
>                 path =3D g_strdup(chan->path);
>                                 ^~~~~~~~~~
> profiles/health/hdp.c:1779:6: warning: Use of memory after it is freed
>                                         hdp_tmp_dc_data_ref(hdp_conn),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> profiles/health/hdp.c:1836:30: warning: Use of memory after it is freed
>         reply =3D g_dbus_create_error(data->msg, ERROR_INTERFACE ".Health=
Error",
>                                     ^~~~~~~~~
> 4 warnings generated.
> profiles/health/hdp_util.c:1053:2: warning: Use of memory after it is fre=
ed
>         conn_data->func(conn_data->data, gerr);
>         ^~~~~~~~~~~~~~~
> 1 warning generated.
> profiles/midi/midi.c:61:75: error: function definition is not allowed her=
e
>         void foreach_cb(const struct midi_write_parser *parser, void *use=
r_data) {
>                                                                          =
        ^
> profiles/midi/midi.c:78:40: error: use of undeclared identifier 'foreach_=
cb'
>                 midi_read_ev(&midi->midi_out, event, foreach_cb, midi);
>                                                      ^
> 2 errors generated.
> attrib/gatt.c:970:2: warning: Potential leak of memory pointed to by 'lon=
g_write'
>         return prepare_write(long_write);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> src/sdpd-request.c:211:13: warning: Result of 'malloc' is converted to a =
pointer of type 'char', which is incompatible with sizeof operand type 'uin=
t16_t'
>                                 pElem =3D malloc(sizeof(uint16_t));
>                                         ^~~~~~ ~~~~~~~~~~~~~~~~
> src/sdpd-request.c:239:13: warning: Result of 'malloc' is converted to a =
pointer of type 'char', which is incompatible with sizeof operand type 'uin=
t32_t'
>                                 pElem =3D malloc(sizeof(uint32_t));
>                                         ^~~~~~ ~~~~~~~~~~~~~~~~
> 2 warnings generated.
> src/sdp-xml.c:126:10: warning: Assigned value is garbage or undefined
>                 buf[1] =3D data[i + 1];
>                        ^ ~~~~~~~~~~~
> src/sdp-xml.c:300:11: warning: Assigned value is garbage or undefined
>                         buf[1] =3D data[i + 1];
>                                ^ ~~~~~~~~~~~
> src/sdp-xml.c:338:11: warning: Assigned value is garbage or undefined
>                         buf[1] =3D data[i + 1];
>                                ^ ~~~~~~~~~~~
> 3 warnings generated.
> src/sdp-client.c:353:14: warning: Access to field 'cb' results in a deref=
erence of a null pointer
>         (*ctxt)->cb =3D cb;
>         ~~~~~~~~~~~~^~~~
> 1 warning generated.
> src/gatt-database.c:1138:10: warning: Value stored to 'bits' during its i=
nitialization is never read
>         uint8_t bits[] =3D { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
>                 ^~~~     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> src/advertising.c:942:2: warning: Null pointer passed to 2nd parameter ex=
pecting 'nonnull'
>         memcpy(cp->data + adv_data_len, scan_rsp, scan_rsp_len);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> gobex/gobex-header.c:67:2: warning: Null pointer passed to 2nd parameter =
expecting 'nonnull'
>         memcpy(to, from, count);
>         ^~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> gobex/gobex-transfer.c:423:7: warning: Use of memory after it is freed
>         if (!g_slist_find(transfers, transfer))
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> client/player.c: In function =E2=80=98transport_send_seq=E2=80=99:
> client/player.c:3581:45: error: format =E2=80=98%lld=E2=80=99 expects arg=
ument of type =E2=80=98long long int=E2=80=99, but argument 5 has type =E2=
=80=98off_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=3D]
>  3581 |   bt_shell_echo("[seq %d %d.%03ds] send: %lld/%lld bytes",
>       |                                          ~~~^
>       |                                             |
>       |                                             long long int
>       |                                          %ld
> ......
>  3584 |     offset, transport->stat.st_size);
>       |     ~~~~~~                                  =20
>       |     |
>       |     off_t {aka long int}
> client/player.c:3581:50: error: format =E2=80=98%lld=E2=80=99 expects arg=
ument of type =E2=80=98long long int=E2=80=99, but argument 6 has type =E2=
=80=98__off_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=
=3D]
>  3581 |   bt_shell_echo("[seq %d %d.%03ds] send: %lld/%lld bytes",
>       |                                               ~~~^
>       |                                                  |
>       |                                                  long long int
>       |                                               %ld
> ......
>  3584 |     offset, transport->stat.st_size);
>       |             ~~~~~~~~~~~~~~~~~~~~~~~              =20
>       |                            |
>       |                            __off_t {aka long int}
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:7616: client/player.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:4518: all] Error 2
>
>
> ---
> Regards,
> Linux Bluetooth

