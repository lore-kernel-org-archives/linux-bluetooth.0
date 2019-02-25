Return-Path: <SRS0=0pTa=RA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD01EC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 12:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9842320842
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Feb 2019 12:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ59NXIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfBYMYx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:24:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38790 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfBYMYw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Feb 2019 07:24:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so7637900otf.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Feb 2019 04:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/XfLCEkXJwmbi3KFGENc7rb3HghQ9arLIs/77XmUf08=;
        b=UZ59NXIYj/Oj9S8Kim3WSTEYGTU1tfwN10ZfRpYJRmwBl7mFP7Ws41qT5gWMmu8l71
         LijygdZtWAbN/YE/lZkejQ+dJ8Y8lKzi9j4Y/qfsmftgdMKJUZd+ySvQeIAbNjit0yAB
         h0qDrYmn/1YT4qUCWdCW9JuDwTSP+YZP+uiD7oBpsCuA83ccpUVyzlSsY1waWpHPfxao
         7Iy2GHq9YtCVAzLX42prstFtr+26ZTIlkpNgqUGD92Ugvy2SqOZ0/ewpCDEMkNoczgcZ
         R77npxNjlsycOCnRO+BnSKjFa40hcEg8NwOFr4AY7Eh7mhYLDrZTWoZOXVq9F9EDsm2v
         FwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/XfLCEkXJwmbi3KFGENc7rb3HghQ9arLIs/77XmUf08=;
        b=J/btYGyjPple0LbmEEwZtQtkjmGSuJOSthnrU2ok4OmC/NJqfTN7Vbp+ZRZuEKTm+P
         jO/10B33wfq/r1kMMx8oghD+rVQRTlwK8/06ZBQg+mC3ysgMEqgOKw5Hh4CqxjurmzHZ
         dF7m8NeKAy73BHceNJCYODb5ACwaF0z+AKEHGsmm6v9NSX5w3DQubtCGj/IyrVduDe2Y
         veYYalOq3X706K372M7/F3HyygW3X8rAKIIwCnoNmAI8Kp/ugjavdDBwzwZTGsVk3ICJ
         eEudg7PqOssvWO/hooKH20DJSGQ4DP2MBR5A0+jDytJk+pMyokLVp1zRQuzQbR5afUKR
         0w8g==
X-Gm-Message-State: AHQUAuaYYiRWlK10icSP2ZayHyyQHoCgX+clZu4Ih3DQNO60Mvjs+rdl
        Q6C5eHU05KTNJbBlZdrQB3WhpM/c3rcV9m00ev6q0w0q
X-Google-Smtp-Source: AHgI3IZvDdXRYFH8JNkSQ5mj7ng0SCeqaMueW791hhk/JGEGlwRuqx0SqeiwzDF5P/rbshTyceOuV11DToHCjBTMAyM=
X-Received: by 2002:a9d:6c84:: with SMTP id c4mr348102otr.242.1551097491055;
 Mon, 25 Feb 2019 04:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20190222114254.21369-1-luiz.dentz@gmail.com>
In-Reply-To: <20190222114254.21369-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 25 Feb 2019 14:24:38 +0200
Message-ID: <CABBYNZK_BdC8GH8zynVnBz+XqWx__5bZzJUG3irKpkVCA2ugpg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shell: Allow multiple prompt inputs
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Fri, Feb 22, 2019 at 1:42 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This allow queueing input prompts so that the application don't have to
> queue themselves.
> ---
>  src/shared/shell.c | 66 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 709d20556..d7fbf46aa 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -66,6 +66,12 @@ struct bt_shell_env {
>
>  static char *cmplt = "help";
>
> +struct bt_shell_prompt_input {
> +       char *str;
> +       bt_shell_prompt_input_func func;
> +       void *user_data;
> +};
> +
>  static struct {
>         bool init;
>         char *name;
> @@ -81,6 +87,8 @@ static struct {
>         bt_shell_prompt_input_func saved_func;
>         void *saved_user_data;
>
> +       struct queue *prompts;
> +
>         const struct bt_shell_menu *menu;
>         const struct bt_shell_menu *main;
>         struct queue *submenus;
> @@ -560,6 +568,17 @@ void bt_shell_usage()
>                                         data.exec->arg ? data.exec->arg : "");
>  }
>
> +static void prompt_input(const char *str, bt_shell_prompt_input_func func,
> +                                                       void *user_data)
> +{
> +       data.saved_prompt = true;
> +       data.saved_func = func;
> +       data.saved_user_data = user_data;
> +
> +       rl_save_prompt();
> +       bt_shell_set_prompt(str);
> +}
> +
>  void bt_shell_prompt_input(const char *label, const char *msg,
>                         bt_shell_prompt_input_func func, void *user_data)
>  {
> @@ -568,25 +587,43 @@ void bt_shell_prompt_input(const char *label, const char *msg,
>         if (!data.init || data.mode)
>                 return;
>
> -       /* Normal use should not prompt for user input to the value a second
> -        * time before it releases the prompt, but we take a safe action. */
> -       if (data.saved_prompt)
> +       if (data.saved_prompt) {
> +               struct bt_shell_prompt_input *prompt;
> +
> +               prompt = new0(struct bt_shell_prompt_input, 1);
> +
> +               if (asprintf(&prompt->str, "[%s] %s ", label, msg) < 0) {
> +                       free(prompt);
> +                       return;
> +               }
> +
> +               prompt->func = func;
> +               prompt->user_data = user_data;
> +
> +               queue_push_tail(data.prompts, prompt);
> +
>                 return;
> +       }
>
>         if (asprintf(&str, "[%s] %s ", label, msg) < 0)
>                 return;
>
> -       data.saved_prompt = true;
> -       data.saved_func = func;
> -       data.saved_user_data = user_data;
> +       prompt_input(str, func, user_data);
>
> -       rl_save_prompt();
> -       bt_shell_set_prompt(str);
>         free(str);
>  }
>
> +static void prompt_free(void *data)
> +{
> +       struct bt_shell_prompt_input *prompt = data;
> +
> +       free(prompt->str);
> +       free(prompt);
> +}
> +
>  int bt_shell_release_prompt(const char *input)
>  {
> +       struct bt_shell_prompt_input *prompt;
>         bt_shell_prompt_input_func func;
>         void *user_data;
>
> @@ -600,11 +637,20 @@ int bt_shell_release_prompt(const char *input)
>         func = data.saved_func;
>         user_data = data.saved_user_data;
>
> +       prompt = queue_pop_head(data.prompts);
> +       if (prompt)
> +               data.saved_prompt = true;
> +
>         data.saved_func = NULL;
>         data.saved_user_data = NULL;
>
>         func(input, user_data);
>
> +       if (prompt) {
> +               prompt_input(prompt->str, prompt->func, prompt->user_data);
> +               prompt_free(prompt);
> +       }
> +
>         return 0;
>  }
>
> @@ -1070,6 +1116,7 @@ done:
>         rl_init();
>
>         data.init = true;
> +       data.prompts = queue_new();
>  }
>
>  static void rl_cleanup(void)
> @@ -1118,6 +1165,9 @@ void bt_shell_cleanup(void)
>
>         rl_cleanup();
>
> +       queue_destroy(data.prompts, prompt_free);
> +       data.prompts = NULL;
> +
>         data.init = false;
>         free(data.name);
>  }
> --
> 2.17.2

Applied.

-- 
Luiz Augusto von Dentz
