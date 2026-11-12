Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794497856;
	b=R8ZZfM+MfzEVBuSho15mk4nMyI/1DE/+iM9wCzGf1C+3N7YFelOowEbP3LkAfGFAOpMy
	 R6lx8fAirYUrdqxQQGRTr03y9glTCrUkXcRASBB752mYsMoWTNLe1xwVnStPQNUPe252Y
	 3aivAOUN7dC9bKquDNqil6I4Z4M3+AnyogA4EXmbGXe3iQtb9zXW+5CKhnqLAwYfZMM1G
	 dnFqy/RYw11VmM726YD8kxQ+DT6nR+9OfFy1De3S6Cefd12g3mkuKKVp1Axmo7NHfrihe
	 wdBFy97UW+i2juanveCGMbHBn056m3J/74ZM0grCoPak6RGqahRUVH3zX/7SAPCuczw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=zcmI3MZomg/7ti9HmssowlP/v5brU55Dy/pdlfuGz5c=;
	b=xUez8cuaHqe73rclNiUCOzHcsNyedcEFPFllmfLc1aosnqn0AabGQkXpwTG9uWlcP1gk
	 x3uT1gEPTgP1EYONtiZDukKGSh7T7HheVv5svzj7rUaY9X8dNvTUDCZQjk22pmfauq+4+
	 9kBjfQOA45zsfR+qqLC3ZLH8/fbb1Lysm1kYoRxhzCgHe8NNp7zU5lcKH1NWREdLE75zt
	 CY+vydi0xBIvc8lcHu0e8wE6fdTHukzX8ZCZDcfH/s4PO26S3o4lqwA5OyE8imQc6JDVV
	 ERflzcr9QDA9K9JRxWBdS0BD89jr3dkAaInTjX3QZ66keGpt5LgM5OaAieqlVdlRlUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hc/LT8EC";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B48606A32A
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 15:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B48606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hc/LT8EC
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0cf2c0785so47407357b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 07:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794497855; cv=none;
        d=google.com; s=arc-20260327;
        b=VCa/RdVh7qptymsHodMDuusdph4TXvJRapTC90Mu47nMZ+NvBPKmDdfk3wK3x0DIFa
         LVf0xKXVjM/7SomOUAN8BxBc8HFvIafruRm0IoUxeyzNPbsRzlXok8IFJ2zEu8TD19jE
         ut83RPWxAlqHf6q+xctUwl3Fx2SwU0RYt3FTn89HvYmUkwnbFJco5EpDJRljdOzZwwW9
         /uK+yk/AVu+Zxs6mD9Pp65lxx0vAfX7nqA0fYfI+XqMm+C9mXfbOFh5ueCgbEFnvKZI/
         4Xzo6If1peIT/6sLXxFwEnv9V9PMUXuO1XQxl+KMpg4vBbw8Yqu1vJdVzXG1Fu+iRoDA
         hkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zcmI3MZomg/7ti9HmssowlP/v5brU55Dy/pdlfuGz5c=;
        fh=UeUzDNEl7a5VMucsQdf0ffDI/PHd6R4+v7SDClo34+Y=;
        b=TWEtpgF/nLLJvnk150U7NdgnqKvfrx/5bKJz4KycFvKaCNTQXuFdS4n3cLW5eonWAJ
         BAZafxo3bL9cCUHMX0lWBESMveapzoSTYu4Gh6COesInssjeq0vdgTRE/ZbOxzck3rP1
         tlVqOGpavIt1eQUC0udjoIYbS04a4MN7GuQQwR6e+vSxCQoLaRhZYwvFCHl/MFIAp78i
         6JKmNB3+/5SXoLQnv8jRsabdlS1qjy5P8QpXI/IkB8bY0kNXe4Ga2RBgK2hjzl9Ryn92
         Z+gSXhWDA15f2lxU1B6U7Si/qM8Abj6CcVg1bgrtJcZ/hZ283doaBzikDAFU7xPNHjhO
         W2QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497855; x=1795102655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zcmI3MZomg/7ti9HmssowlP/v5brU55Dy/pdlfuGz5c=;
        b=hc/LT8ECWVpRJq+tKC30bAYqO2Dt3bAcHfuFEgLCM7lw6nUjxbUIU9xIFiYBeHOTgO
         596IoHHCfvGP04LV/HK4ewdVHR+IWFTzHOX21JMbQw0VpdiaSaaKZS5TQ7Pk8LECwSKh
         ert82+howERtMnSOSZbFTiWNXd07UopoNYg+ZaakYCulEACkoOOr0vFSwhJcuuDhHKtg
         mXmc86+pV/YHqvZfDIK/LC7XD0SLghlvwRC6alj2fx4YydafG7W2S63iyXHxST5PDde/
         jQdtyG32sDS4Yw6uCEz9ySFV+DUNQ7GXiGfZc2WAqKv/iYrPJ5d7RFgl20qh0nS5Y31N
         Os8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497855; x=1795102655;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zcmI3MZomg/7ti9HmssowlP/v5brU55Dy/pdlfuGz5c=;
        b=heciUMxGBRFFS7D2v4A+ASXs+aJjdKOVQVgQiLl9u1Pg+LgfhN56p7xV/TxIj00OJP
         /usxN859FmcQjRqLrvbjS8qs3TScodmwfNerGv+CnRg1kbptqtMH7dtMfTRERwBvNl9n
         hV3udaipMnDx5RYAO/bv0296REzAwlyTkhm24EZE6sK+/vsQ8n1BdolRwbVpn4vrD9SP
         +xUpRDXTI1sUOP2ntDNokX3kF5rR/3ELhYpg6OUDpzB29hZnL3qK1QcloHOn4gaCqyDg
         W5JuUTN+SiDaa+bYJQ5wtalfubQobEvzu6yzp2PVj1sVCDqcdG9IZaQTdFqnuK04Hubw
         7ksw==
X-Gm-Message-State: APuU4Z8TRY8CtRU+2iFvdozCbO5Q4JsYzh5NJQuOkGtYXhanwVC3Bu+3
	MUwc3zb0vRNK5SVD9o+2drWLOY2HHiWN69a8IrM4NsjVdbB7VK9RhEjxH9PR31bGk0JUHgZEFbb
	a0fGJeUBuRNn+aS3ufOYo5P/FHIEK1EZnmg==
X-Gm-Gg: AYBFou0p8NJuOgwZvZSaD5xQfrTKlxZa0pXQAsU2vJ6lyHpHrtnDJ3UHsGbESt8uuUA
	qv8KKPnDkptDemRL1kRunIrf5qt9ddTYtpBdjqp7XtX3Z8N4dzHJySyunhokdx4Dg9jz7Gt4CFL
	4CH/wa10OirbJcDLANMqin0D3E4DREswDp9PfbaTIQu6DDzE03wMSBdti0wSw8HWB/mf93qTtmP
	P4HyAvkn+ZYRcai0UG2TO3hzOJ6zIohmXBw8tmd52lUIk6xB7tpStJGBZULdcbYA971kBnR54Gg
	ZhTrokUPIWaVpNnjeUbZHNiWDoh5L4rBATVVFHrxs7WO6vaXwU5wcahtQkFOCJBLRbonx9F2xPY
	ocBPoajwR7rrN11KW489RNmF1525DnwCqk4UNq9kWyyUvUxmV8qMUj8JZYqwdqf2Wz2G0mnbKiW
	FQ/g3uD7MGQ3pp3/PJUN2bnpVaB82UWxjxcXJT1j5t/ORvsYs2cZ1umEKkYGI=
X-Received: by 2002:a05:690c:6601:b0:8b4:a39e:484a with SMTP id
 00721157ae682-8b4a39e6011mr5111987b3.3.1794497854792; Thu, 12 Nov 2026
 07:37:34 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111200705.3802779-2-luiz.dentz@gmail.com> <6af521d8.488c8742.26003.3592@mx.google.com>
In-Reply-To: <6af521d8.488c8742.26003.3592@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 10:37:22 -0500
X-Gm-Features: AclHuK-9595ZcUcS7qHfA83Ibk1z7NRN_XabIO4_ADXdMD3a1NhOh8Q8Gc-Nrg4
Message-ID: <CABBYNZ+dzizM9Lf1UfANaFSyiSkcOTjH6z1KRiGxKV+xvB+JfQ@mail.gmail.com>
Subject: Re: Add support for HDT and EKS
To: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Nov 11, 2026 at 9:18=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1208698/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      7.93 seconds
> GitLint                       PASS      2.40 seconds
> BuildEll                      PASS      18.26 seconds
> BluezMake                     PASS      273.68 seconds
> MakeCheck                     PASS      13.89 seconds
> MakeDistcheck                 PASS      139.39 seconds
> CheckValgrind                 PASS      329.80 seconds
> CheckSmatch                   WARNING   246.89 seconds
> bluezmakeextell               PASS      90.03 seconds
> TestFunctional                FAIL      3189.72 seconds
> IncrementalBuild              PASS      706.34 seconds
> ScanBuild                     PASS      935.86 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script
> Output:
> [BlueZ,v10,01/11] monitor: Use __packed in bt.h and its users
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute_=
_((packed))
> #229: FILE: monitor/bt.h:16:
> +#define __packed __attribute__((packed))
>
> /home/runner/work/bluez/bluez/src/patch/14973568.patch total: 0 errors, 1=
 warnings, 4719 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> /home/runner/work/bluez/bluez/src/patch/14973568.patch has style problems=
, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> [BlueZ,v10,10/11] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
> WARNING:MACRO_ARG_UNUSED: Argument 'name' is not used in function-like ma=
cro
> #417: FILE: tools/iso-tester.c:958:
> +#define test_iso_full(name, type, data, setup, func, num, reason) \
>         do { \
>                 struct test_data *user; \
>                 user =3D new0(struct test_data, 1); \
>                 if (!user) \
>                         break; \
> +               user->hciemu_type =3D type; \
>                 user->test_data =3D data; \
>                 user->client_num =3D num; \
>                 user->accept_reason =3D reason; \
>
> WARNING:MACRO_ARG_UNUSED: Argument 'setup' is not used in function-like m=
acro
> #417: FILE: tools/iso-tester.c:958:
> +#define test_iso_full(name, type, data, setup, func, num, reason) \
>         do { \
>                 struct test_data *user; \
>                 user =3D new0(struct test_data, 1); \
>                 if (!user) \
>                         break; \
> +               user->hciemu_type =3D type; \
>                 user->test_data =3D data; \
>                 user->client_num =3D num; \
>                 user->accept_reason =3D reason; \
>
> WARNING:MACRO_ARG_UNUSED: Argument 'func' is not used in function-like ma=
cro
> #417: FILE: tools/iso-tester.c:958:
> +#define test_iso_full(name, type, data, setup, func, num, reason) \
>         do { \
>                 struct test_data *user; \
>                 user =3D new0(struct test_data, 1); \
>                 if (!user) \
>                         break; \
> +               user->hciemu_type =3D type; \
>                 user->test_data =3D data; \
>                 user->client_num =3D num; \
>                 user->accept_reason =3D reason; \
>
> /home/runner/work/bluez/bluez/src/patch/14973576.patch total: 0 errors, 3=
 warnings, 3090 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> /home/runner/work/bluez/bluez/src/patch/14973576.patch has style problems=
, please review.
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
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> emulator/bthost.c:707:28: warning: Variable length array is used.emulator=
/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:=
961:28: warning: Variable length array is used.emulator/bthost.c:995:28: wa=
rning: Variable length array is used.emulator/bthost.c:996:32: warning: Var=
iable length array is used.monitor/packet.c:2292:26: warning: Variable leng=
th array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220=
:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: ar=
ray of flexible structuresmonitor/packet.c:2292:26: warning: Variable lengt=
h array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:=
52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: arr=
ay of flexible structuresemulator/bthost.c:707:28: warning: Variable length=
 array is used.emulator/bthost.c:708:32: warning: Variable length array is =
used.emulator/bthost.c:961:28: warning: Variable length array is used.emula=
tor/bthost.c:995:28: warning: Variable length array is used.emulator/bthost=
.c:996:32: warning: Variable length array is used.src/main.c: note: in incl=
uded file (through src/device.h):
> ##############################
> Test: TestFunctional - FAIL
> Desc: Run test-functional
> Output:
> FAIL functional.test_adv_monitor::test_adv_monitor_GHSA_hhgc_hfgf_8m4x[ho=
sts1-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load fail=
ed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_show[hosts16-vm1]: f=
ailed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_list[hosts16-vm1]: f=
ailed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_script_show[hosts16-=
vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_script_list[hosts16-=
vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_btmgmt::test_btmgmt_info[hosts19-vm1]: AssertionErro=
r: assert 'addr 00:00:00:00:00:00' in '\x1b[0;91mReading hci0 info failed w=
ith status 0x11 (Invalid Index)\n\x1b[0m'
>      +  where '\x1b[0;91mReading hci0 info failed with status 0x11 (Inval=
id Index)\n\x1b[0m' =3D CompletedProcess(args=3D['/home/runner/work/bluez/b=
luez/src/src/tools/btmgmt', '--index', '0', 'info'], returncode=3D0, stdout=
=3D'\x1b[0;91mReading hci0 info failed with status 0x11 (Invalid Index)\n\x=
1b[0m').stdout
> FAIL functional.test_a2dp::test_a2dp_transport_created[hosts0-vm2]: faile=
d on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_a2dp::test_a2dp_transport_acquire[hosts0-vm2]: faile=
d on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_a2dp::test_a2dp_disconnect_during_setconf[hosts0-vm2=
-accept]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load faile=
d
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_a2dp::test_a2dp_disconnect_during_setconf[hosts0-vm2=
-reject]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load faile=
d
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_a2dp::test_a2dp_reconnect_pending_disconnect[hosts0-=
vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bearer::test_bearer_le_connect[hosts12-vm2]: failed =
on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bearer::test_bearer_le_conn_params[hosts12-vm2]: fai=
led on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bearer::test_bearer_le_connectable[hosts12-vm2]: fai=
led on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bearer::test_bearer_le_pair[hosts12-vm2]: failed on =
setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bearer::test_bearer_bredr_pair[hosts13-vm2]: failed =
on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bearer::test_bearer_le_conn_update[hosts14-vm2]: fai=
led on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bearer::test_bearer_le_not_connectable[hosts15-vm2]:=
 failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts17-v=
m2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_le[hosts18-vm2]=
: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_agent::test_agent_pair_bredr[accept-hosts2-vm2]: fai=
led on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_agent::test_agent_pair_bredr[reject-hosts2-vm2]: fai=
led on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_hog::test_hog[no-sci-hosts20-vm2]: failed on setup w=
ith "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_hog::test_hog[sci-hosts20-vm2]: failed on setup with=
 "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_mpris_proxy::test_mpris_proxy_playback_control[bredr=
-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_mpris_proxy::test_mpris_proxy_track_control[bredr-vm=
2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_obex::test_obex_ftp_list[hosts24-vm2]: failed on set=
up with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_obex::test_obex_ftp_get[hosts24-vm2]: failed on setu=
p with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_obex::test_obexctl_list[hosts24-vm2]: failed on setu=
p with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_avrcp::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts3-vm2]: f=
ailed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_transport_created[hosts4-vm2]:=
 failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2]:=
 failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_transport_resume[0-hosts4-vm2]=
: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_transport_resume[0.1-hosts4-vm=
2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_transport_resume[1.0-hosts4-vm=
2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_reconfigure_metadata[empty-hos=
ts5-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load faile=
d
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_reconfigure_metadata[media-hos=
ts5-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load faile=
d
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_desync[hosts6-vm2]: failed on =
setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_duplex_enable_one[hosts6-vm2]:=
 failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_broadcast_transport_created[lc3-hosts7=
-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_broadcast_transport_created[pbp-hosts7=
-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_broadcast_transport_acquire[lc3-hosts7=
-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_broadcast_transport_acquire[pbp-hosts7=
-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bass_past_transport_acquire[hosts9-vm2]: f=
ailed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts10-=
vm3-sc]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts10-=
vm3-legacy]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load fa=
iled
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_unicast_set_transport_acquire[hosts10-=
vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts1=
1-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_broadcast_earbuds_transport_created[ho=
sts8-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load fail=
ed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_bap::test_bap_broadcast_earbuds_transport_acquire[ho=
sts8-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load fail=
ed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_mpris_proxy::test_mpris_proxy_playback_control[le-vm=
2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"
> FAIL functional.test_mpris_proxy::test_mpris_proxy_track_control[le-vm2]:=
 failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 238, in wait_load
>             raise RuntimeError("load failed")
>         RuntimeError: load failed"

This looks like a recurring problem we are hitting at github, I tried
investigating but it seems the controllers are not responding under
pytest_bluezenv, have you made any recent changes? I hope we are not
defaulting to UML mode since that is still experimental.

--=20
Luiz Augusto von Dentz
