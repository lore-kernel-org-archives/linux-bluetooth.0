Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5033E378
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426588; cv=pass; b=QxNRyf1UJ3UMSlA2sgTWNuDalctHsMawejNwBSFxObECJTYBsWum0WsIzghzix8+1h4/T4ywXdDVvLZzM4h7QXiINgTsQfdAi4ePtdw/WARpxQ5IIz6/cXiSw4TCRk2xCUd4zwEBFh2h8DBuc/jLbPGkdrhffIgMvvHx1lfalQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426588; c=relaxed/simple;
	bh=/L8AcVJyJYS4zu15Wb4kQlGQP8iuImpdopX0+NglLzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXlZQlCYf+hxS7yywwjDFH4je+4dHfR/RozmniXkkp0W3Ahhe6LJzJvcJVCsbfmLtyrELaU5xy1/KkLBY3sAsTxLB8xiNzSxARVKPSyKG+sO3dV2+gJ7jZ9epmWXJJgptGFrY2baabBi0eXOa5QlsAul0QURCmAn1GPOtbCuGVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HI2scq0I; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI2scq0I"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-649c070ef3bso5317523d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 06:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771426586; cv=none;
        d=google.com; s=arc-20240605;
        b=K5mbvw02LsukgKl3EB4z/Wc04OAiJ1zfmoxLzux0MOFtfauPB+FQpxd5FzEWJt34TE
         AjYu+Zitv1nrTTgSsG4oVWrmenQXDLUYhjg6Bm/5iLb7N9DQSoQAnJOZme2FdSoZw32l
         UaSz7TbBKhkE0nhkQBKGyPiWRjwzNQfrMNn/1SvOwpOKrpXhafi6uW6awlNWxhuUxS0y
         RRi5B3EIDXjmTa7gLcgT4XlikkkxIU5YbJwozqXHGAT92uuqNr/piC/8jRI9CdoGB3x2
         o3YfRV4glS3zLdxF3+UNpBIBPjJKaJ1SiZx+tQcgPDSf5wI+MiphShz7eS/iqA5fKWaI
         OajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M5rAeXuUikt0No+wrccjqQh7DtMW4hd6T6Br2KsKL7o=;
        fh=rmteJgQOrgLpzpZaGd/VFvWTOpwsG1FBlQ5jhGNsQFM=;
        b=iJ6d8lT6kY9QGEZLBOGl/4omkx87jx7vEHosDsYXVRiKgEJXK9X36JbpWtThOJWxY8
         z5B/LUzPIYmIdgEDsMqo/zRqzgBlqlMH9KQqb8muL7ASa/oNUC1KiZoB2bdl0XXoPVJt
         zKWYcgX+7PDpLp5Tf5n8mN9KNW3q3rX5OlymkG+Ul/DMrdCdSES2TfYaaM9oPhv9qEKU
         gMOw1FtRB6x7AplrQND9FcvWN1DQwex5m7o0cnynpJO3LpUi+4t+ZEHlhfPHpdBKfCJ0
         tmpGxwNZR98cJ8Dz3+d92U0w22jL7n6RD/26Emy1ad5ZPZxaXo74jg9O/VplN2NBeN+N
         Fxdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771426586; x=1772031386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5rAeXuUikt0No+wrccjqQh7DtMW4hd6T6Br2KsKL7o=;
        b=HI2scq0IzUIuv0FlipnQh+n/O9PH0yAOiPAa07SwF2atggmmLaMRfUEKOlXo+fai6w
         B2lXFw678TUsugmMFPb9mo9FGh6yxdiZ0g77osmAOzzt2uYwlZBUUsVlXTYNl56LmQHc
         Z2K8z6esMh5uhvDqn4zHtZbB8Sy8TlAhaYhq9x/dmGbYUps8CC6pijZM7kpyhBpMJzIa
         JwsV5Hp5Cs1ufCOMDIowIC4ZoAL+pOD0datVgjhf783QJcZ7S4pac2Yyg88Gli5e9P/H
         4HkJv9pEM5/s6NRTqoIxjXK1oyYGEymbQ5iVmFFz1lIgRTrMPTl3IORoA4y1UFMb7eLA
         caeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771426586; x=1772031386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5rAeXuUikt0No+wrccjqQh7DtMW4hd6T6Br2KsKL7o=;
        b=lK/TbTjDksWdgZ14bTnZudCr2IX/Mt12+SellZ3UF6AO8i1hBht30PKvyy4YLsSQCy
         Sz+qB5agQC/S3R/tLpFRpS5itIQfH+vKrx+QiTN8IeF38ktk4cWLHpELnR2E2CqyfEBR
         2ZAIDF3Jy2BnozwhKY7Vixo+gce34lkPqCyouaZKgv3ok0HFiFcjS788e55+CYQRqqUR
         2AxkByAtunhWTvqqHkb3ULeexMpL108tBA/vYecM1HMbuvxNOz/j7N8da7HTIcXR5kPv
         KrUbFI80xHo5uB0QXwos1BnuoYtLyBHQikT1vMnKhjGTev4JIXQFS8AkECrBSeMGJF/Y
         Lmgw==
X-Gm-Message-State: AOJu0Yw8v8NrgK4E4Au9tqngB8nrvKx4agfuqbc9TQklMUZIZ4X1bIr8
	Ca91GyZak8gMmOqftWR7mnemvhFN2/ZRCRbW4PPuXuHhyAFvItbk+AWe1wN2hH/j2475l8f179j
	gib0G3QXlAfnfNQbxjLvIE1sIN0U05ruL7jlV
X-Gm-Gg: AZuq6aINPyzrCyfSI4H2tmqURj8m/lM63hVmIPv/bEfEdmleeRo/71QZ5OqwZ3UwyHs
	f//zSC/UD80AqN5WdIrdLWz0vAhZ9BuQk1AtVL88VqCreDzN4puJv8r/9Zijb0pJ+9q/ML20Ia1
	qPdMXF2FZF59sc/J8usm69RLl/BzH8hVcK7ak66MTZZF2IRf45K3eM4KeJRDtIAXF02qfHrb5zr
	n0ghjB7lKsx/hNS9Yg1WlkN8sgS6pekPeU0xFiyvq283ez74b19QeCfHDkdBZjconOVedGw2mpy
	10GyE4aGRMxZIccAFiyp7Hr0LDGnKxuQCf0nnNzMxpLHt9MwRz9u0whhKdXWlosw2Vs=
X-Received: by 2002:a53:b74f:0:b0:64a:dbb5:2849 with SMTP id
 956f58d0204a3-64c19b7b686mr8998944d50.97.1771426585978; Wed, 18 Feb 2026
 06:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218024605.70890-1-ronan@rjp.ie> <20260218024605.70890-2-ronan@rjp.ie>
In-Reply-To: <20260218024605.70890-2-ronan@rjp.ie>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Feb 2026 09:56:14 -0500
X-Gm-Features: AZwV_QiZMzIH7SVpUcUAMvIYp6XmvOvTToG5uV1iAl-6v1UWf_BOnLwvX_SY02k
Message-ID: <CABBYNZK+WswMuKEC5_dopMEsey9ab=ywkiUgKyDeDBiJOZ3vhA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] zsh: amend completions
To: Ronan Pigott <ronan@rjp.ie>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ronan,

On Tue, Feb 17, 2026 at 9:46=E2=80=AFPM Ronan Pigott <ronan@rjp.ie> wrote:
>
> First, use the correct completion return value.
>
> The return value of a completion function is significant, if we fail to
> return success additional completers may be invoked when they otherwise
> should not be.
>
> Also cleanup up the zsh completion, removing the redundant definition of
> _bluetoothctl and using the _call_program helper where appropriate.
>
> Finally, update the bluetoothctl command invocations to account for the
> media lines printed after some of the non-interactive commands.
> ---
>  completion/zsh/_bluetoothctl | 133 ++++++++++++++++-------------------
>  src/shared/shell.c           |   4 ++
>  2 files changed, 66 insertions(+), 71 deletions(-)
>
> diff --git a/completion/zsh/_bluetoothctl b/completion/zsh/_bluetoothctl
> index 610ca2b8d59c..b6f513376532 100644
> --- a/completion/zsh/_bluetoothctl
> +++ b/completion/zsh/_bluetoothctl
> @@ -1,97 +1,88 @@
>  #compdef bluetoothctl
>
> -__bluetoothctl() {
> -       bluetoothctl "$@" 2>/dev/null
> -}
> -
>  _bluezcomp_controller() {
>         local -a controllers
> -       bluetoothctl list |
> -       while read _ MAC NAME; do
> -               controllers+=3D"${MAC//:/\\:}:${NAME//:/\\:}"
> +       _call_program bluez-controller bluetoothctl list |
> +       while read KIND MAC NAME FLAG; do
> +               [[ $KIND =3D=3D Controller ]] &&
> +                       controllers+=3D("${MAC//:/\\:}:${NAME//:/\\:}")
>         done
>         _describe -t controllers 'controller' controllers
>  }
>
>  _bluezcomp_device() {
>         local -a devices
> -       bluetoothctl devices |
> -       while read _ MAC NAME; do
> -               devices+=3D"${MAC//:/\\:}:${NAME//:/\\:}"
> +       _call_program bluez-device bluetoothctl devices |
> +       while read KIND MAC NAME; do
> +               [[ $KIND =3D=3D Device ]] &&
> +                       devices+=3D("${MAC//:/\\:}:${NAME//:/\\:}")
>         done
>         _describe -t devices 'device' devices
>  }
>
>  _bluezcomp_agentcap() {
> -       local -a agent_options=3D(${(f)"$(__bluetoothctl agent help)"})
> -       agent_options=3D( "${(@)agent_options:#(on|off)}" )
> -       compadd -a agent_options
> +       local -a agent_options=3D(${${(@f)"$(_call_program bluez-agent bl=
uetoothctl agent help)"}:#(on|off)})
> +       compadd "$@" - -a agent_options
>  }
>
>  _bluetoothctl_agent() {
> -       local -a agent_options=3D(${(f)"$(__bluetoothctl agent help)"})
> -       agent_options+=3Dhelp
> -       compadd -a agent_options
> +       local -a agent_options=3D(help ${(@f)"$(_call_program bluez-agent=
 bluetoothctl agent help)"})
> +       compadd "$@" - -a agent_options
>  }
>
> -_bluetoothctl_advertise() {
> -       local -a ad_options=3D(${(f)"$(__bluetoothctl advertise help)"})
> -       ad_options+=3Dhelp
> -       compadd -a ad_options
> -}
> +local -a toggle_commands=3D(
> +       "discoverable" "pairable" "power" "scan"
> +)
>
> -_bluetoothctl() {
> -       local -a toggle_commands=3D(
> -               "discoverable" "pairable" "power" "scan"
> -       )
> +local -a controller_commands=3D(
> +       "select" "show"
> +)
>
> -       local -a controller_commands=3D(
> -               "select" "show"
> -       )
> +local -a device_commands=3D(
> +       "block" "connect" "disconnect" "info"
> +       "pair" "remove" "trust" "unblock" "untrust"
> +)
>
> -       local -a device_commands=3D(
> -               "block" "connect" "disconnect" "info"
> -               "pair" "remove" "trust" "unblock" "untrust"
> -       )
> +# Other commands may be handled by _bluetoothctl_$command
> +local -a all_commands=3D( "${(@f)$(_call_program bluetoothctl bluetoothc=
tl --zsh-complete help)}" )
>
> -       # Other commands may be handled by _bluetoothctl_$command
> -       local -a all_commands=3D( "${(@f)$(__bluetoothctl --zsh-complete =
help)}" )
> +local curcontext=3D$curcontext state line ret=3D1
> +_arguments -C \
> +       + '(info)' \
> +       {-h,--help}'[Show help message and exit]' \
> +       {-v,--version}'--version[Show version info and exit]' \
> +       + 'mod' \
> +       '(info)'{-a+,--agent=3D}'[Register agent handler]:agent:_bluezcom=
p_agentcap' \
> +       '(info)'{-t,--timeout}'[Timeout in seconds for non-interactive mo=
de]' \
> +       '(info)'{-m,--monitor}'[Enable monitor output]' \
> +       + 'command' \
> +       '(info):command:->command' \
> +       '(info):: :->argument'
>
> -       local curcontext=3D$curcontext state line ret=3D1
> -       _arguments -C \
> -               + '(info)' \
> -               {-h,--help}'[Show help message and exit]' \
> -               {-v,--version}'--version[Show version info and exit]' \
> -               + 'mod' \
> -               '(info)'{-a+,--agent=3D}'[Register agent handler]:agent:_=
bluezcomp_agentcap' \
> -               '(info)'{-t,--timeout}'[Timeout in seconds for non-intera=
ctive mode]' \
> -               '(info)'{-m,--monitor}'[Enable monitor output]' \
> -               + 'command' \
> -               '(info):command:->command' \
> -               '(info):: :->argument'
> -
> -       if [[ $state =3D=3D "command" ]]; then
> -               _describe -t commands 'command' all_commands
> -       elif [[ $state =3D=3D "argument" ]]; then
> -               if (( ! ${"${(@)all_commands%%:*}"[(I)${line[1]}]} )); th=
en
> -                       _message "Unknown bluetoothctl command: $line[1]"
> -                       return 1;
> -               fi
> -
> -               curcontext=3D"${curcontext%:*:*}:bluetoothctl-$line[1]:"
> -               if ! _call_function ret _bluetoothctl_$line[1]; then
> -                       case $line[1] in
> -                               (${(~j.|.)toggle_commands})
> -                                       compadd on off
> -                                       ;;
> -                               (${(~j.|.)device_commands})
> -                                       _bluezcomp_device
> -                                       ;;
> -                               (${(~j.|.)controller_commands})
> -                                       _bluezcomp_controller
> -                                       ;;
> -                       esac
> -               fi
> -               return ret
> +if [[ $state =3D=3D "command" ]]; then
> +       _describe -t commands 'command' all_commands
> +elif [[ $state =3D=3D "argument" ]]; then
> +       if (( ! ${"${(@)all_commands%%:*}"[(I)${line[1]}]} )); then
> +               _message "Unknown bluetoothctl command: $line[1]"
> +               return 1;
>         fi
> -} && _bluetoothctl
> +
> +       curcontext=3D"${curcontext%:*:*}:bluetoothctl-$line[1]:"
> +       if ! _call_function ret _bluetoothctl_$line[1]; then
> +               case $line[1] in
> +                       (advertise)
> +                               compadd - help on off type && ret=3D0
> +                               ;;
> +                       (${(~j.|.)toggle_commands})
> +                               compadd on off && ret=3D0
> +                               ;;
> +                       (${(~j.|.)device_commands})
> +                               _bluezcomp_device && ret=3D0
> +                               ;;
> +                       (${(~j.|.)controller_commands})
> +                               _bluezcomp_controller && ret=3D0
> +                               ;;
> +               esac
> +       fi
> +       return ret
> +fi
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index f014d8f7c2b2..873a14176af9 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1737,6 +1737,10 @@ int bt_shell_get_timeout(void)
>
>  void bt_shell_handle_non_interactive_help(void)
>  {
> +       if (data.zsh) {
> +               shell_print_menu_zsh_complete();
> +               exit(EXIT_SUCCESS);
> +       }

I suggest splitting these changes, so shared should go in its own
patch with a proper explanation why it has to be done this way.

>         if (!data.mode)
>                 return;
>         if (data.argv[0] !=3D cmplt)
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
