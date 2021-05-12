Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB2CC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 20:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B47C613C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 20:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbhELUNe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 16:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbhELSIW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 14:08:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BDFC061346
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 11:07:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i4so31825084ybe.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StgMOM2aJoOotcvuvd3nW8o/zcxB8fNh/5i+86/JCcg=;
        b=lXtHpORTX9RLwQuAK1QlgWk74RuyauZY62E3lsWIGZqoofrnhugc8OCJHupvR1awfv
         FRUDJRGyUel/C3zSF8KfaZt+DniZFzxvzsbbUCNISzMmw50HW0SVbacF1dwzVlFfry67
         /EkPa/Xu3pDTc0YQ7IQ8NJJjiWeBS8ylsJ1MVCAP4Iha86HRTv7uC4gb/ShzumvVUemE
         gUDWLI6Ngz9+xOkF39IPedu0JpqjlZMyLjlgSOHQ0ph+apc5d+9RB1+lNqOZHBAoKxBa
         QswOIS+NSv0e+/qNS0dL9XUfWxOZ4qGbHuiLy8TkPKwJSd6ZTLpzpwAdNSndWwZK4HD3
         aN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StgMOM2aJoOotcvuvd3nW8o/zcxB8fNh/5i+86/JCcg=;
        b=P6ELfqMCYPEPdQ4lzlN2emefhdNGI/Owj7wCEk0DCO3cwGOl+rLeQrUSQK5XtqLL0h
         N7OB1zW/R956pS9udIewIoON/8CFUH1ukvUOcSLpfsd9BiQ1ogE6wcVmyLDWbSTGo+nK
         uEFWaftl0MeHaT7aFniQ6UGaw8IjckcF/jyy+DELbq1j7hN28Cs4F46NrhIqWr+2EsTp
         QjIIV8eyRIYY12rGGRGzYo18zmWPL31d/2iHSyUkCoMJsulF3pvkn9xN5R7J86wzICjW
         eMLJ4x5LEFyusC3uhndobmOp0NQBgxbpNXZPaNomSazY2CHSxJCxH72ReqbDlvob1C1u
         FZgQ==
X-Gm-Message-State: AOAM532YINxOXM3AOVgYQnhz0C8EmbfIIkNJyWfwfux88w+Y/i6DQq6A
        6f9aUFNlNwXArlP3xAN45VxAx7JNcJ8W1HjP38I=
X-Google-Smtp-Source: ABdhPJwjBgIOHitxSefE/lDjs1+fe7aojDbDgf7T5x1T+U9aR3ZeeOGLWmK7Slnwk/wKGYrbuLFjc/IXTnfUa78jPyk=
X-Received: by 2002:a25:ad8b:: with SMTP id z11mr22352762ybi.91.1620842829039;
 Wed, 12 May 2021 11:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210512133932.4e2b4bd0@ivy-bridge>
In-Reply-To: <20210512133932.4e2b4bd0@ivy-bridge>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 May 2021 11:06:58 -0700
Message-ID: <CABBYNZ+SpNTkGriGfAdKYo1+H3-2+SAmv7dMDW4=LWqNGnDnhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix various memory leaks
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steve,

On Wed, May 12, 2021 at 10:58 AM Steve Grubb <sgrubb@redhat.com> wrote:
>
> Hello,
>
> I was checking the code via static analysis and found a number of
> leaks throughout the code. This patch should address most of what
> was discovered.

Could you please split these changes into mesh, obex, etc, this should
make it easier to bisect if we found there is some problem introduced
by these changes.

> Signed-off-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  mesh/rpl.c                     |  4 +++-
>  obexd/plugins/filesystem.c     |  2 +-
>  obexd/plugins/ftp.c            |  8 ++++++--
>  obexd/plugins/messages-dummy.c |  1 +
>  plugins/hostname.c             |  3 +--
>  profiles/audio/avrcp.c         |  4 +++-
>  src/main.c                     |  1 +
>  src/shared/shell.c             |  1 +
>  tools/mesh-cfgclient.c         |  2 +-
>  tools/mesh-gatt/gatt.c         |  1 +
>  tools/mesh-gatt/node.c         | 12 +++++++++---
>  11 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/mesh/rpl.c b/mesh/rpl.c
> index ac0f6b6f2..c53c6fbfd 100644
> --- a/mesh/rpl.c
> +++ b/mesh/rpl.c
> @@ -143,8 +143,10 @@ static void get_entries(const char *iv_path, struct l_queue *rpl_list)
>                 return;
>
>         iv_txt = basename(iv_path);
> -       if (sscanf(iv_txt, "%08x", &iv_index) != 1)
> +       if (sscanf(iv_txt, "%08x", &iv_index) != 1) {
> +               closedir(dir);
>                 return;
> +       }
>
>         memset(seq_txt, 0, sizeof(seq_txt));
>
> diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
> index 09bff8ad0..44e3cf3d2 100644
> --- a/obexd/plugins/filesystem.c
> +++ b/obexd/plugins/filesystem.c
> @@ -415,7 +415,7 @@ static void *capability_open(const char *name, int oflag, mode_t mode,
>                         goto fail;
>                 }
>
> -               object->buffer = g_string_new(buf);
> +               object->buffer = buf;
>
>                 if (size)
>                         *size = object->buffer->len;
> diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
> index 259bfcae2..4b04bab06 100644
> --- a/obexd/plugins/ftp.c
> +++ b/obexd/plugins/ftp.c
> @@ -386,8 +386,10 @@ static int ftp_copy(struct ftp_session *ftp, const char *name,
>         ret = verify_path(destdir);
>         g_free(destdir);
>
> -       if (ret < 0)
> +       if (ret < 0) {
> +               g_free(destination);
>                 return ret;
> +       }
>
>         source = g_build_filename(ftp->folder, name, NULL);
>
> @@ -424,8 +426,10 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
>         ret = verify_path(destdir);
>         g_free(destdir);
>
> -       if (ret < 0)
> +       if (ret < 0) {
> +               g_free(destination);
>                 return ret;
> +       }
>
>         source = g_build_filename(ftp->folder, name, NULL);
>
> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
> index 34199fa05..e37b52df6 100644
> --- a/obexd/plugins/messages-dummy.c
> +++ b/obexd/plugins/messages-dummy.c
> @@ -488,6 +488,7 @@ int messages_get_messages_listing(void *session, const char *name,
>                         int err = -errno;
>                         DBG("fopen(): %d, %s", -err, strerror(-err));
>                         g_free(path);
> +                       g_free(mld);
>                         return -EBADR;
>                 }
>         }
> diff --git a/plugins/hostname.c b/plugins/hostname.c
> index f7ab9e8bc..1a9513adb 100644
> --- a/plugins/hostname.c
> +++ b/plugins/hostname.c
> @@ -213,11 +213,10 @@ static void read_dmi_fallback(void)
>                 return;
>
>         type = atoi(contents);
> +       g_free(contents);
>         if (type < 0 || type > 0x1D)
>                 return;
>
> -       g_free(contents);
> -
>         /* from systemd hostname chassis list */
>         switch (type) {
>         case 0x3:
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index c6a342ee3..58d30b24d 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3508,8 +3508,10 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
>         path = device_get_path(session->dev);
>
>         mp = media_player_controller_create(path, id);
> -       if (mp == NULL)
> +       if (mp == NULL) {
> +               g_free(player);
>                 return NULL;
> +       }
>
>         media_player_set_callbacks(mp, &ct_cbs, player);
>         player->user_data = mp;
> diff --git a/src/main.c b/src/main.c
> index c32bda7d4..94141b1e4 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -795,6 +795,7 @@ static void parse_config(GKeyFile *config)
>
>         parse_br_config(config);
>         parse_le_config(config);
> +       g_free(str);
>  }
>
>  static void init_defaults(void)
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index c0de1640d..f05fb2820 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -611,6 +611,7 @@ void bt_shell_prompt_input(const char *label, const char *msg,
>                 prompt->user_data = user_data;
>
>                 queue_push_tail(data.prompts, prompt);
> +               g_free(str);
>
>                 return;
>         }
> diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
> index 1eeed2a1a..49069674f 100644
> --- a/tools/mesh-cfgclient.c
> +++ b/tools/mesh-cfgclient.c
> @@ -914,7 +914,7 @@ static void cmd_import_node(int argc, char *argv[])
>
>         /* Number of elements */
>         if (sscanf(argv[4], "%u", &req->arg3) != 1)
> -               return;
> +               goto fail;
>
>         /* DevKey */
>         req->data2 = l_util_from_hexstring(argv[5], &sz);
> diff --git a/tools/mesh-gatt/gatt.c b/tools/mesh-gatt/gatt.c
> index b99234f91..c8a8123fb 100644
> --- a/tools/mesh-gatt/gatt.c
> +++ b/tools/mesh-gatt/gatt.c
> @@ -525,6 +525,7 @@ bool mesh_gatt_notify(GDBusProxy *proxy, bool enable, GDBusReturnFunction cb,
>                         notify_io_destroy();
>                         if (cb)
>                                 cb(NULL, user_data);
> +                       g_free(data);
>                         return true;
>                 } else {
>                         method = "StopNotify";
> diff --git a/tools/mesh-gatt/node.c b/tools/mesh-gatt/node.c
> index 6afda3387..356e1cd1a 100644
> --- a/tools/mesh-gatt/node.c
> +++ b/tools/mesh-gatt/node.c
> @@ -396,8 +396,10 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
>                 uint16_t vendor_id;
>                 struct mesh_element *ele;
>                 ele = g_malloc0(sizeof(struct mesh_element));
> -               if (!ele)
> +               if (!ele) {
> +                       g_free(comp);
>                         return false;
> +               }
>
>                 ele->index = i;
>                 ele->loc = get_le16(data);
> @@ -412,8 +414,10 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
>                         mod_id = get_le16(data);
>                         /* initialize uppper 16 bits to 0xffff for SIG models */
>                         mod_id |= 0xffff0000;
> -                       if (!node_set_model(node, ele->index, mod_id))
> +                       if (!node_set_model(node, ele->index, mod_id)) {
> +                               g_free(comp);
>                                 return false;
> +                       }
>                         data += 2;
>                         len -= 2;
>                 }
> @@ -421,8 +425,10 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
>                         mod_id = get_le16(data + 2);
>                         vendor_id = get_le16(data);
>                         mod_id |= (vendor_id << 16);
> -                       if (!node_set_model(node, ele->index, mod_id))
> +                       if (!node_set_model(node, ele->index, mod_id)) {
> +                               g_free(comp);
>                                 return false;
> +                       }
>                         data += 4;
>                         len -= 4;
>                 }
> --
> 2.31.1
>


-- 
Luiz Augusto von Dentz
