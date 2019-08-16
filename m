Return-Path: <SRS0=GHQ/=WM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D7BC3A59C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4161C2064A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 11:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0xmbR8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfHPLhN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:37:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35523 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfHPLhN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Aug 2019 07:37:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id g17so8507121otl.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8h+jZj0SlIXAcpjmiDPhfxgEwxDRfF67XgoBZjNCiSU=;
        b=X0xmbR8U6z7/X7k1O8+0PzjOi/AnIebNfVWcRhbnCqVRfSXzhP0uc4zzTOaK57NQ01
         zINduROEsZB5/N6buU7/R+qbQZrC922/AVLUTUnx2wcEPSwK2s2CPWmgBpDZvYaPdQRp
         lDczcwx9PNzSDc8R0RaCVGZiFTrEt2J/xXLMCqPTr+U7t6n20hWO2oDDERwSHlBs+4oB
         FZaP5se6E2hShmlEQQ7vUcKAZlw61gGZmv8JA17oz/R9ucoOeU6glzS1Ubtj2e6j5w7O
         Wr966GlfA2DvttxkMY+s62YTEknLqryrsZDMvLHjpsXss2YpqbKz+o9q3RaOASmp+bsA
         9GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8h+jZj0SlIXAcpjmiDPhfxgEwxDRfF67XgoBZjNCiSU=;
        b=lMNE8lo7Cgqzo5hdPIAITtjaSJrgUtJVoW7haofsk8lm0jfAOhaSLkigfg/WfMLVD1
         HsOTxgs2rM2X5XwrvKnYWJ5U0BK/7v2+KV0YXWzjsNK6394YEa7JzUGLjk2GGRyXCneb
         G62ra4z3h5/9ygf0OewAdGTaW0vd9ApaWJoivkbXiSrCyX2wrEtRUomNJ3PmyeE2f4tL
         DamhHrKF1D7Pn2oRiGtmYKHpZRIVubY5rLx6Px91CYtl5S7EY27X619ZxvTNAUKBWCYJ
         Xe9cKIyVN6wEb3TY3M+hzXb/tMzPmXKGy6H2QKFmcO5KAJijFa9u7pegQDrK3vYhu2dk
         ir/Q==
X-Gm-Message-State: APjAAAXGrU019b0WIt/PuZ9b6w9tFGqwyBr09chc7UAO4uZkRYcNfYua
        uUnnftI8UWmxBsQhmXt/IXWdzoqOxfeqUNvIJTc=
X-Google-Smtp-Source: APXvYqweMXfVdsS7YGkwObjdZU6vKYGK/DtpTKy4cMGpdya7KMSk8EWf8XSnufzQ9siIxxoDT+q5Wa8vm8/kdHigzgY=
X-Received: by 2002:a05:6830:2056:: with SMTP id f22mr6374395otp.177.1565955431998;
 Fri, 16 Aug 2019 04:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190816074333.24673-1-rpigott@berkeley.edu> <20190816074333.24673-3-rpigott@berkeley.edu>
In-Reply-To: <20190816074333.24673-3-rpigott@berkeley.edu>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 16 Aug 2019 14:36:59 +0300
Message-ID: <CABBYNZJ1XQB=0PCDTQ+jy1tOh5BveBVUPMka_z9m-3pQnX3GSw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] completion: add bluetoothctl zsh completions
To:     Ronan Pigott <rpigott314@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Ronan Pigott <rpigott@berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ronan,

On Fri, Aug 16, 2019 at 10:48 AM Ronan Pigott <rpigott314@gmail.com> wrote:
>
> From: Ronan Pigott <rpigott@berkeley.edu>
>
> ---
>  completion/zsh/_bluetoothctl | 131 +++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 completion/zsh/_bluetoothctl
>
> diff --git a/completion/zsh/_bluetoothctl b/completion/zsh/_bluetoothctl
> new file mode 100644
> index 000000000..c9c177a83
> --- /dev/null
> +++ b/completion/zsh/_bluetoothctl
> @@ -0,0 +1,131 @@
> +#compdef bluetoothctl
> +
> +_bluezcomp_controller() {
> +       local -a controllers
> +       bluetoothctl list |
> +       while read _ MAC NAME; do
> +               controllers+="${MAC//:/\\:}:${NAME//:/\\:}"
> +       done
> +       _describe -t controllers 'controller' controllers
> +}
> +
> +_bluezcomp_device() {
> +       local -a devices
> +       bluetoothctl devices |
> +       while read _ MAC NAME; do
> +               devices+="${MAC//:/\\:}:${NAME//:/\\:}"
> +       done
> +       _describe -t devices 'device' devices
> +}
> +
> +_bluetoothctl_agent() {
> +       local -a agent_options=(${(f)"$(bluetoothctl agent help)"})
> +       agent_options+=help
> +       compadd -a agent_options
> +}
> +
> +_bluetoothctl_agent_cap() {
> +       local -a agent_options=(${(f)"$(bluetoothctl agent help)"})
> +       agent_options=( "${(@)agent_options:#(on|off)}" )
> +       compadd -a agent_options
> +}
> +
> +_bluetoothctl_advertise() {
> +       local -a ad_options=(${(f)"$(bluetoothctl advertise help)"})
> +       ad_options+=help
> +       compadd -a ad_options
> +}
> +
> +_bluetoothctl() {
> +       local curcontext=$curcontext state line ret=1
> +
> +       local -a simple_commands=(
> +               "help:Display help"
> +               "version:Dispaly version"
> +               "list:List available controllers"
> +               "devices:List available devices"
> +               "paired-devices:List paired devices"
> +               "reset-alias:Reset controller alias"
> +               "default-agent:Set agent as the default one"
> +               "export:Print environment variables"
> +               "system-alias:Set controller alias"
> +               "set-alias:Set device alias"
> +       )
> +
> +       local -a toggle_commands=(
> +               "power:Set controller power"
> +               "pairable:Set controller pairable mode"
> +               "discoverable:Set controller discoverable mode"
> +               "scan:Scan for devices"
> +       )
> +
> +       local -a controller_commands=(
> +               "show:Controller information"
> +               "select:Select default controller"
> +       )
> +
> +       local -a device_commands=(
> +               "info:Device information"
> +               "pair:Pair with device"
> +               "trust:Trust device"
> +               "untrust:Untrust device"
> +               "block:Block device"
> +               "unblock:Unblock device"
> +               "remove:Remove device"
> +               "connect:Connect device"
> +               "disconnect:Disconnect device"
> +       )
> +
> +       local -a other_commands=(
> +               "agent:Enable/disable advertising with given type"
> +               "advertise:Enable/disable advertising with the given type"
> +       )
> +
> +       local -a all_commands=(
> +               $simple_commands
> +               $device_commands
> +               $toggle_commands
> +               $controller_commands
> +               $other_commands
> +       )
> +
> +       _arguments -C \
> +               + '(info)' \
> +               '--help[Show help message and exit]' \
> +               '--version[Show version info and exit]' \
> +               + 'mod' \
> +               '(info)--timeout[Timeout in seconds for non-interactive mode]' \
> +               '(info)--agent=[Register agent handler]:agent:_bluetoothctl_agent_cap' \
> +               + 'command' \
> +               '(info):command:->command' \
> +               '(info):: :->argument' \
> +               ': :_message "no more arguments"'
> +
> +       if [[ $state == "command" ]]; then
> +               _describe -t commands 'command' all_commands
> +       elif [[ $state == "argument" ]]; then
> +               curcontext=${curcontext%:*:*}:bluetoothctl-$line[1]
> +               case $line[1] in
> +                       (${(~j.|.)simple_commands%%:*})
> +                               _message "no more arguments"
> +                               ;;
> +                       (${(~j.|.)toggle_commands%%:*})
> +                               compadd on off
> +                               ;;
> +                       (${(~j.|.)device_commands%%:*})
> +                               _bluezcomp_device
> +                               ;;
> +                       (${(~j.|.)controller_commands%%:*})
> +                               _bluezcomp_controller
> +                               ;;
> +                       *)
> +                               if ! _call_function ret _bluetoothctl_$line[1]; then
> +                                       _message "Unknown bluetoothctl command: $line[1]"
> +                               fi
> +                               return ret
> +                               ;;
> +               esac
> +       fi
> +}
> +
> +_bluetoothctl
> --
> 2.22.1

Id love to see this being generated by bt_shell automatically instead
i.e ./bluetoothctl --zsh-complete/--bash-complete, that can then be
used by the auto complete script generate the commands, which seems to
be what you did with help that would print the arguments but done to
the commands as well.


-- 
Luiz Augusto von Dentz
