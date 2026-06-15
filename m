Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714F3AE1B1
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550553; cv=pass; b=XVkKhY2GUB629OF/Fmy8dcECkMBv12Y2eTUPrv1a7YqPQnQkaNxMSkbc+PghUjxN058u7uMd+jqC+T89UcVtkJ+/ipZls/fChZzPfYq5+wP1AB4ZvB+ff3C+zVkdQAAlHsl725E8RXGAD/fNpl5Gsgx0US4j9pUInOjhL9kFTmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550553; c=relaxed/simple;
	bh=NzSPpavrpnq1mVxZE5LuMK7CJRz9a0JW8Y+TIJ5Zlx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ds6GCBz4zmO3fcYgQNrCyMAQGr4NUdo2yTq5RRTNpaO3eYLDpVbSkKV9VBAhhHHD3ZNpMQwkkc8WvLVT97pYkpCub+Jx23Otv8rrkn5gbq0iKxAQmoqA2BEnrndwhbik2aAhKg+eIs5QSevS2ZggZCn06530EMPDv1wcWVysvX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcWkz0Aq; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcWkz0Aq"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66039d3efcbso3613936d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 12:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781550551; cv=none;
        d=google.com; s=arc-20240605;
        b=kqI1fH5M/+rgiDtH+SZy72N/sHPjjdG06gPVAwtnpU/TR+CGLxGw0wUbnfR8gvz6mu
         5ucBUJqg5ZndI4/Z2etOGZzzqxelMM9iH3kIhjVXbvqXIUcGENMB3HHwNy4dXo1aFwHk
         Z32gU4S4j8OcFnWGiYp/HZEa40FngIUAQADaudBR9fojJQKXw+Xu2JHlqYHED8kNvvK7
         aU6+0WWMH6kfPuF3npScV5mYa0toGJ+1txRVYrVedN5F1TqbhfTrTtqdQbjqMkN6HI3r
         i2BQR1TmplOpZ8rUlCyPonqk7cK7nq6nD+RFGm8m4hXtfufKwzhLsSHSZCKxKHopSrbk
         JbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y1ndsPcXJNoZ2ZTE7nQfZRPkP9u9y6vvUi+78RAcjqM=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=XXpESZlWTrN7tNUcr4Xlu9leE8XPXho+uYFKRTbTk2PikNVZKpTw1KjQaYvRHIT3Pz
         w7XtoR6dptc5izKCC/fwA2YOchJmzVyp4kY2gYrDeoh63IkmamIPqvjdkdBnSj7BBbOe
         ZAiBEB5f20DqRn8eajcngHMTZNB2jJhKw9Ina0ai6beZ5Oi77x3OL4q6cPK/RAPvSkt2
         W6yq0KbaMEyXTz58ahF3yDdNlBzsgYCrXa+AzBNzz31yGTyh5gt4dzvg/Sm5s24hcy7O
         RaHp68FbPdjO7yH2ebNvRfs2K/6pTQuCmGJ7KL9arvj0IJ0bjhdu9Xsyl/Euk84v4WR6
         m7dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781550551; x=1782155351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1ndsPcXJNoZ2ZTE7nQfZRPkP9u9y6vvUi+78RAcjqM=;
        b=mcWkz0Aqeyu29DeRLH6Qd/uEFWvtaqZRz98cYzj/IjV0NOlbpy6yNy7jcfbdjx93o/
         4Mf5ZMQuyLIkwL5J1Hl+25zRKsJHIbEjkH0qrHDZor6Cz+dw54AvvozRxbKTeQo06LLs
         DTrUJqjzOfNcf6ACHYOcsK2kSbsEVAIDiywuvtidmKVH8kviXE06lciuV58S59mdbxf0
         T+Vipm2np8SCqh69fkAq7zX+UK7bjeYRI9BxDlgJ3OuVBHBs+2jigCW8s+9/U/zbAuUN
         7hIu7pvh70jhQsX344ugSDZKTg9JZfjpshMscpz/+wzvhLwalAZ/wDWRHZpwGHFkdbBQ
         ZMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781550551; x=1782155351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1ndsPcXJNoZ2ZTE7nQfZRPkP9u9y6vvUi+78RAcjqM=;
        b=bjwMrgsg89blIJqk9CdXP40md3WYLjCGa1+tp34a2sVS7MbEBrzIRy1HH76lYo1HK0
         Ubt/ThnsWkVihvWXpVrd3olCO5i1FdgePp73LFW2dpKUzcG9uSURv3GgTd7XDze7K6kc
         EXWkx5wOv1cXpTnqxk8YnCJSWvjSxv/LBHgV1NZDzC+Pj9r0m87Obu/QOrn486cZlQTO
         CRwUdbII2P+wVmVUtSPltXE38Hz5R0+urgoSBTTC5TcVH/ffkP+HV/ozV+Osp28mp7de
         Yb045bMKEFifmO81cR0dT/L0rbdrekCgVFsBzxgZb6QPystvCKLeUq1mrGBtlSpIwcBN
         V0jQ==
X-Gm-Message-State: AOJu0YyFDqn2YUVtGs2TMBLA0Dup9xzKGNA1Wmrk2txfkVFS2fDrQVbm
	fIb8jo/alxlPfsM+otQx0bZemfiA5NqXmuj+KvWAQAsgMRaAwNqGOg2Y4G/1y5HDiMdZPe8yj4c
	6yqyGUj3y4KHBnQy/YLZRq1xKZ7paq7aa+wVRySQ=
X-Gm-Gg: Acq92OGjtdG8XBRl64qr5gnrL4mkmMfAkn7IZwe0ckogtRPXpdbVXcwKE+5dGgNnug0
	QuNH5b9UGIxXchF5pDmA3QfY4UzPU391zwK4hIsiYCfGtGvXkYXyvqycLo76bIDO71nO4GvYAav
	G4JLhhNafMsbaSyYCZi174lNR6sakdb6EvARyTM7Tsb62ykKq41VApLjPsgx6H6RgijmpAEop8m
	Bt1qHR+bKS4VYGlqAqVTOAnzUwwWBDEpNzsGncjPTNNUG1rIzTfelUY84DQcjejwzJIzTT7tfDs
	+kjsHi0lxISEoWHe9DUjxd4PfvFxBqllf/Ow8yLQNYv7tvUKKmWy2JXRrjO9HxNQndpHOQ==
X-Received: by 2002:a05:690e:418f:b0:658:e645:7736 with SMTP id
 956f58d0204a3-662b61908a5mr254617d50.39.1781550550937; Mon, 15 Jun 2026
 12:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781365708.git.pav@iki.fi> <199523aaa32d2be835216f583dfe9bf7d9eacf42.1781365708.git.pav@iki.fi>
In-Reply-To: <199523aaa32d2be835216f583dfe9bf7d9eacf42.1781365708.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Jun 2026 15:08:59 -0400
X-Gm-Features: AVVi8Cek8lkyb7BtbdnLzLqH8WQGGz1vWs46v54D9UxkKsmJk1CL2eo-3kOq-Ic
Message-ID: <CABBYNZ+6Bp6yV4kzB4Y53XD+6i0mbhNTFoU=qpXq4Qu5o3=6og@mail.gmail.com>
Subject: Re: [PATCH BlueZ v6 3/6] build: add functional testing target
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Jun 13, 2026 at 11:49=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> This adds check-functional: target that runs the functional test suite.
>
> Also add a --enable-functional-testing=3D<kernel-image> argument for
> configure that can be used to include it in the check: make target,
> possibly with a predefined kernel image.
> ---
>  Makefile.am  | 10 ++++++++++
>  configure.ac | 22 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/Makefile.am b/Makefile.am
> index 76c4ab5d4..7920cae68 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -812,6 +812,16 @@ endif
>  TESTS =3D $(unit_tests)
>  AM_TESTS_ENVIRONMENT =3D MALLOC_CHECK_=3D3 MALLOC_PERTURB_=3D69
>
> +check-functional: all
> +       python3 -m pytest "$(srcdir)/test/functional" -v \
> +               --kernel=3D"$(FUNCTIONAL_TESTING_KERNEL)" \
> +               --bluez-build-dir=3D"$(top_builddir)" \
> +               --bluez-src-dir=3D"$(srcdir)"
> +
> +if FUNCTIONAL_TESTING
> +check: check-functional
> +endif
> +
>  if DBUS_RUN_SESSION
>  AM_TESTS_ENVIRONMENT +=3D dbus-run-session --
>  endif
> diff --git a/configure.ac b/configure.ac
> index 1cdd551f6..f50d8c9b3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -407,6 +407,28 @@ if (test "${enable_testing}" =3D "yes"); then
>                 #include <linux/net_tstamp.h>]])
>  fi
>
> +AC_ARG_ENABLE(functional-testing, AS_HELP_STRING([--enable-functional-te=
sting],
> +                       [enable functional testing tools]),
> +                       [enable_functional_testing=3Dyes; functional_test=
ing_kernel=3D${enableval}],
> +                        [enable_functional_testing=3Dno])
> +AM_CONDITIONAL(FUNCTIONAL_TESTING, test "${enable_functional_testing}" =
=3D "yes")
> +AC_ARG_VAR(FUNCTIONAL_TESTING_KERNEL, [vmlinux image to use for function=
al testing])
> +FUNCTIONAL_TESTING_KERNEL=3D${functional_testing_kernel}
> +
> +if (test "${enable_functional_testing}" =3D "yes"); then
> +  if (test "${enable_client}" =3D "no" || \
> +      test "${enable_tools}" !=3D "yes" || \
> +      test "${enable_testing}" !=3D "yes"); then
> +    AC_MSG_ERROR([--enable-functional-testing requires --enable-client -=
-enable-tools --enable-testing])
> +  fi
> +  AC_MSG_CHECKING([pytest and dependencies])
> +  python3 -m pip install --dry-run --no-index -r "${srcdir}/test/functio=
nal/requirements.txt" >/dev/null
> +  if (test "$?" !=3D "0"); then
> +    AC_MSG_ERROR([pytest or dependencies missing])
> +  fi
> +  AC_MSG_RESULT([ok])
> +fi
> +
>  AC_ARG_ENABLE(experimental, AS_HELP_STRING([--enable-experimental],
>                         [enable experimental tools]),
>                                         [enable_experimental=3D${enableva=
l}])
> --
> 2.54.0

Seems to be working if I do ./bootstrap-configure
--enable-functional-testing=3D../linux:

platform linux -- Python 3.13.13, pytest-8.3.3, pluggy-1.5.0 -- /usr/bin/py=
thon3
cachedir: .pytest_cache
rootdir: /home/vudentz/git/bluez/test
configfile: pytest.ini
plugins: venv-0.3, anyio-4.8.0
collected 13 items

test/functional/test_tests.py::test_formatting SKIPPED (could not
import 'black': No module named 'black')


[  7%]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_show[hosts1-vm1]
PASSED

                                                             [ 15%]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_list[hosts1-vm1]
PASSED

                                                             [ 23%]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_script_show[host=
s1-vm1]
PASSED

                                                      [ 30%]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_script_list[host=
s1-vm1]
PASSED

                                                      [ 38%]
test/functional/test_btmgmt_vm.py::test_btmgmt_info[hosts4-vm1] PASSED


                                                                  [
46%]
test/functional/test_agent.py::test_agent_pair_bredr[accept-hosts0-vm2]
PASSED

                                                                 [
53%]
test/functional/test_agent.py::test_agent_pair_bredr[reject-hosts0-vm2]
PASSED

                                                                 [
61%]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair_bredr[hosts=
2-vm2]
PASSED

                                                       [ 69%]
test/functional/test_bluetoothctl_vm.py::test_bluetoothctl_pair_le[hosts3-v=
m2]
PASSED

                                                          [ 76%]
test/functional/test_obex.py::test_obex_ftp_list[hosts5-vm2] PASSED


                                                                  [
84%]
test/functional/test_obex.py::test_obex_ftp_get[hosts5-vm2] PASSED


                                                                  [
92%]
test/functional/test_obex.py::test_obexctl_list[hosts5-vm2] PASSED



[100%]

I wonder why the first one is being skipped though, since I did install:

python3 -mpip install -r test/functional/requirements.txt

That said maybe we could run it as part of a container that builds the
kernel environment, which would download and build bluetooth-next.
Even better, that could load a prebuilt kernel image (pushed by CI)
but it perhaps needs to detect if the prebuilt image needs updating;
if so, it builds it locally or something.

--=20
Luiz Augusto von Dentz
