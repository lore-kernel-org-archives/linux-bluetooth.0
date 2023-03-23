Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8547C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 21:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCWVHi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWVHg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 17:07:36 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB440222FB
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:07:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e11so15282780lji.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679605651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9F6M4K3jaaOTIQFpBnVVDjqQSlq8ZL7/yXVu78OSzM=;
        b=omSPQXmQCX+zWwHBdt29VG/3DwwZVTpoT1V6ypcS6o58Lhq6p2efvAs9kMtAgunipR
         gVjmCtr+fOmM7n/xKTzUm43BdcjonNTldScbtfsTXw5g/32bznYSutF3rGdPwu9Ts7Sb
         o3HtuBTo9F7Utk+P11b9DbljBqW7ys/nuPAF5/unqLVu58iMEYYy3H8VXDD4LJDa2+ny
         cTVVFnM9pApfJV2DTtnaRIHY6eObfz47aIDYqpd9sddTWfVrY9VCootEZnTXREIv1uXB
         P9pAu3rA4HE4ry2nOCeBVRUX47GIxRHZChmVrbKBMvgjE9bJvNlwWoDGB5lFnVEyL4rV
         0OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679605651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9F6M4K3jaaOTIQFpBnVVDjqQSlq8ZL7/yXVu78OSzM=;
        b=Q4PGFM00NwxmXcuJK946iwtO1JlDZzfLXz8+legVhq9Eko7yr53SfM6Yn7CqWmn23s
         t2Bdygn/ukArMpihNuQwmWckKSdf2MsTpuSqIW3gobMbuezbRvvTnLKeIcjIuOY6KbwW
         otg/K7wUSqPYexubXZPxPVqewkSueSBXa32ydpolCoBQ7I3UWu2oNErg7eUSwhTtyDFG
         C8dzEIrynUbkSza4Wu2H4s12uL8f5qHgmymlDnkKOB+ttrygVEUB13jhnKh0da6bhIyc
         kRA4XQbeR+SCTRLxB0y5oTqA5Esl+mXUA4x7u5Wf409queBZdjZ0uhlO2DPfprnYPfyV
         yGSg==
X-Gm-Message-State: AAQBX9c4YIsE2pOyzqQJqljk1s9zYDu+rE8jNvUkb0iwYnUaXhyC8vP6
        fnCGhuwjd4y1MLDNCNwHhHb1oqbbLL5cxorqIbGpqbOjtn4=
X-Google-Smtp-Source: AKy350Ze10m4H27To+VQL2yGw2Fb0RZOKcGrDeT+8scM1B4qeduhAasfDE3gJDlfwFwAB0OQ6u/cJios7N5U9uicP0k=
X-Received: by 2002:a2e:a175:0:b0:299:ac68:4801 with SMTP id
 u21-20020a2ea175000000b00299ac684801mr206577ljl.0.1679605650054; Thu, 23 Mar
 2023 14:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com> <20230323103835.571037-5-simon.mikuda@streamunlimited.com>
In-Reply-To: <20230323103835.571037-5-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Mar 2023 14:07:17 -0700
Message-ID: <CABBYNZJV+0fuhmqVhpts_KXPuCg4q33atdvEUMr_M+9e4iS47w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/9] btgatt-client: Rewrite to use bt_shell
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Thu, Mar 23, 2023 at 3:44=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:

This is a pretty good idea, but make sure you cover each procedure
properly, also be aware that with introduction of the following series
you will probably be able to create scripts:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D732537

Also in theory much of btgatt-client is now supported in bluetoothctl,
so I wonder why you are not using the daemon to connect, etc?

> ---
>  Makefile.tools        |    2 +-
>  src/shared/shell.h    |    1 +
>  tools/btgatt-client.c | 1087 ++++++++++++++++-------------------------
>  3 files changed, 412 insertions(+), 678 deletions(-)
>
> diff --git a/Makefile.tools b/Makefile.tools
> index df4cad065..6125e57f7 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -315,7 +315,7 @@ tools_ibeacon_LDADD =3D src/libshared-mainloop.la
>
>  tools_btgatt_client_SOURCES =3D tools/btgatt-client.c src/uuid-helper.c
>  tools_btgatt_client_LDADD =3D src/libshared-mainloop.la \
> -                                               lib/libbluetooth-internal=
.la
> +                                               lib/libbluetooth-internal=
.la -lreadline
>
>  tools_btgatt_server_SOURCES =3D tools/btgatt-server.c src/uuid-helper.c
>  tools_btgatt_server_LDADD =3D src/libshared-mainloop.la \
> diff --git a/src/shared/shell.h b/src/shared/shell.h
> index 87fb5c415..8793835c0 100644
> --- a/src/shared/shell.h
> +++ b/src/shared/shell.h
> @@ -15,6 +15,7 @@
>  #define COLOR_GREEN    "\001\x1B[0;92m\002"
>  #define COLOR_YELLOW   "\001\x1B[0;93m\002"
>  #define COLOR_BLUE     "\001\x1B[0;94m\002"
> +#define COLOR_MAGENTA  "\x1B[0;95m"
>  #define COLOR_BOLDGRAY "\001\x1B[1;30m\002"
>  #define COLOR_BOLDWHITE        "\001\x1B[1;37m\002"
>  #define COLOR_HIGHLIGHT        "\001\x1B[1;39m\002"
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index 2a0cb5181..ecfe3f3f1 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -28,6 +28,7 @@
>  #include "lib/uuid.h"
>
>  #include "src/shared/mainloop.h"
> +#include "src/shared/shell.h"
>  #include "src/shared/util.h"
>  #include "src/shared/att.h"
>  #include "src/shared/queue.h"
> @@ -37,19 +38,29 @@
>  #define ATT_CID 4
>  #define ATT_PSM 31
>
> -#define PRLOG(...) \
> -       printf(__VA_ARGS__); print_prompt();
> -
> -#define COLOR_OFF      "\x1B[0m"
> -#define COLOR_RED      "\x1B[0;91m"
> -#define COLOR_GREEN    "\x1B[0;92m"
> -#define COLOR_YELLOW   "\x1B[0;93m"
> -#define COLOR_BLUE     "\x1B[0;94m"
> -#define COLOR_MAGENTA  "\x1B[0;95m"
> -#define COLOR_BOLDGRAY "\x1B[1;30m"
> -#define COLOR_BOLDWHITE        "\x1B[1;37m"
> +#define MAX_LEN_LINE 512
>
> +struct client *cli;
>  static bool verbose =3D false;
> +static bool shell_running =3D false;
> +
> +#define print(fmt, arg...) do { \
> +       if (shell_running) \
> +               bt_shell_printf(fmt "\n", ## arg); \
> +       else \
> +               printf(fmt "\n", ## arg); \
> +} while (0)
> +
> +#define error(fmt, arg...) do { \
> +       if (shell_running) \
> +               bt_shell_printf(COLOR_RED fmt "\n" COLOR_OFF, ## arg); \
> +       else \
> +               fprintf(stderr, COLOR_RED fmt "\n" COLOR_OFF, ## arg); \
> +} while (0)
> +
> +#define append(str, fmt, arg...) do { \
> +       sprintf(strchr(str, '\0'), fmt, ## arg); \
> +} while (0)
>
>  struct client {
>         int fd;
> @@ -60,10 +71,11 @@ struct client {
>         unsigned int reliable_session_id;
>  };
>
> -static void print_prompt(void)
> +static void update_prompt(void)
>  {
> -       printf(COLOR_BLUE "[GATT client]" COLOR_OFF "# ");
> -       fflush(stdout);
> +       char str[32];
> +       sprintf(str, COLOR_BLUE "[GATT client]" COLOR_OFF "# ");
> +       bt_shell_set_prompt(str);
>  }
>
>  static const char *ecode_to_string(uint8_t ecode)
> @@ -116,7 +128,7 @@ static const char *ecode_to_string(uint8_t ecode)
>
>  static void att_disconnect_cb(int err, void *user_data)
>  {
> -       printf("Device disconnected: %s\n", strerror(err));
> +       print("Device disconnected: %s", strerror(err));
>
>         mainloop_quit();
>  }
> @@ -125,14 +137,14 @@ static void att_debug_cb(const char *str, void *use=
r_data)
>  {
>         const char *prefix =3D user_data;
>
> -       PRLOG(COLOR_BOLDGRAY "%s" COLOR_BOLDWHITE "%s\n" COLOR_OFF, prefi=
x, str);
> +       print(COLOR_BOLDGRAY "%s" COLOR_BOLDWHITE "%s" COLOR_OFF, prefix,=
 str);
>  }
>
>  static void gatt_debug_cb(const char *str, void *user_data)
>  {
>         const char *prefix =3D user_data;
>
> -       PRLOG(COLOR_GREEN "%s%s\n" COLOR_OFF, prefix, str);
> +       print(COLOR_GREEN "%s%s" COLOR_OFF, prefix, str);
>  }
>
>  static void ready_cb(bool success, uint8_t att_ecode, void *user_data);
> @@ -150,7 +162,7 @@ static void log_service_event(struct gatt_db_attribut=
e *attr, const char *str)
>
>         gatt_db_attribute_get_service_handles(attr, &start, &end);
>
> -       PRLOG("%s - UUID: %s start: 0x%04x end: 0x%04x\n", str, uuid_str,
> +       print("%s - UUID: %s start: 0x%04x end: 0x%04x", str, uuid_str,
>                                                                 start, en=
d);
>  }
>
> @@ -170,20 +182,20 @@ static struct client *client_create(int fd, uint16_=
t mtu)
>
>         cli =3D new0(struct client, 1);
>         if (!cli) {
> -               fprintf(stderr, "Failed to allocate memory for client\n")=
;
> +               error("Failed to allocate memory for client");
>                 return NULL;
>         }
>
>         cli->att =3D bt_att_new(fd, false);
>         if (!cli->att) {
> -               fprintf(stderr, "Failed to initialze ATT transport layer\=
n");
> +               error("Failed to initialze ATT transport layer");
>                 bt_att_unref(cli->att);
>                 free(cli);
>                 return NULL;
>         }
>
>         if (!bt_att_set_close_on_unref(cli->att, true)) {
> -               fprintf(stderr, "Failed to set up ATT transport layer\n")=
;
> +               error("Failed to set up ATT transport layer");
>                 bt_att_unref(cli->att);
>                 free(cli);
>                 return NULL;
> @@ -191,7 +203,7 @@ static struct client *client_create(int fd, uint16_t =
mtu)
>
>         if (!bt_att_register_disconnect(cli->att, att_disconnect_cb, NULL=
,
>                                                                 NULL)) {
> -               fprintf(stderr, "Failed to set ATT disconnect handler\n")=
;
> +               error("Failed to set ATT disconnect handler");
>                 bt_att_unref(cli->att);
>                 free(cli);
>                 return NULL;
> @@ -200,7 +212,7 @@ static struct client *client_create(int fd, uint16_t =
mtu)
>         cli->fd =3D fd;
>         cli->db =3D gatt_db_new();
>         if (!cli->db) {
> -               fprintf(stderr, "Failed to create GATT database\n");
> +               error("Failed to create GATT database");
>                 bt_att_unref(cli->att);
>                 free(cli);
>                 return NULL;
> @@ -208,7 +220,7 @@ static struct client *client_create(int fd, uint16_t =
mtu)
>
>         cli->gatt =3D bt_gatt_client_new(cli->db, cli->att, mtu, 0);
>         if (!cli->gatt) {
> -               fprintf(stderr, "Failed to create GATT client\n");
> +               error("Failed to create GATT client");
>                 gatt_db_unref(cli->db);
>                 bt_att_unref(cli->att);
>                 free(cli);
> @@ -225,8 +237,8 @@ static struct client *client_create(int fd, uint16_t =
mtu)
>                                                                         N=
ULL);
>         }
>
> -       bt_gatt_client_ready_register(cli->gatt, ready_cb, cli, NULL);
> -       bt_gatt_client_set_service_changed(cli->gatt, service_changed_cb,=
 cli,
> +       bt_gatt_client_ready_register(cli->gatt, ready_cb, NULL, NULL);
> +       bt_gatt_client_set_service_changed(cli->gatt, service_changed_cb,=
 NULL,
>                                                                         N=
ULL);
>
>         /* bt_gatt_client already holds a reference */
> @@ -242,7 +254,7 @@ static void client_destroy(struct client *cli)
>         free(cli);
>  }
>
> -static void print_uuid(const bt_uuid_t *uuid)
> +static void append_uuid(char *str, const bt_uuid_t *uuid)
>  {
>         char uuid_str[MAX_LEN_UUID_STR];
>         bt_uuid_t uuid128;
> @@ -250,15 +262,15 @@ static void print_uuid(const bt_uuid_t *uuid)
>         bt_uuid_to_uuid128(uuid, &uuid128);
>         bt_uuid_to_string(&uuid128, uuid_str, sizeof(uuid_str));
>
> -       printf("%s\n", uuid_str);
> +       append(str, "%s", uuid_str);
>  }
>
>  static void print_incl(struct gatt_db_attribute *attr, void *user_data)
>  {
> -       struct client *cli =3D user_data;
>         uint16_t handle, start, end;
>         struct gatt_db_attribute *service;
>         bt_uuid_t uuid;
> +       char line[MAX_LEN_LINE] =3D {0};
>
>         if (!gatt_db_attribute_get_incl_data(attr, &handle, &start, &end)=
)
>                 return;
> @@ -269,18 +281,21 @@ static void print_incl(struct gatt_db_attribute *at=
tr, void *user_data)
>
>         gatt_db_attribute_get_service_uuid(service, &uuid);
>
> -       printf("\t  " COLOR_GREEN "include" COLOR_OFF " - handle: "
> +       append(line, "\t  " COLOR_GREEN "include" COLOR_OFF " - handle: "
>                                         "0x%04x, - start: 0x%04x, end: 0x=
%04x,"
>                                         "uuid: ", handle, start, end);
> -       print_uuid(&uuid);
> +       append_uuid(line, &uuid);
> +       print("%s", line);
>  }
>
>  static void print_desc(struct gatt_db_attribute *attr, void *user_data)
>  {
> -       printf("\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
> +       char line[MAX_LEN_LINE] =3D {0};
> +       append(line, "\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
>                                         " - handle: 0x%04x, uuid: ",
>                                         gatt_db_attribute_get_handle(attr=
));
> -       print_uuid(gatt_db_attribute_get_type(attr));
> +       append_uuid(line, gatt_db_attribute_get_type(attr));
> +       print("%s", line);
>  }
>
>  static void print_chrc(struct gatt_db_attribute *attr, void *user_data)
> @@ -289,6 +304,7 @@ static void print_chrc(struct gatt_db_attribute *attr=
, void *user_data)
>         uint8_t properties;
>         uint16_t ext_prop;
>         bt_uuid_t uuid;
> +       char line[MAX_LEN_LINE] =3D {0};
>
>         if (!gatt_db_attribute_get_char_data(attr, &handle,
>                                                                 &value_ha=
ndle,
> @@ -297,170 +313,133 @@ static void print_chrc(struct gatt_db_attribute *=
attr, void *user_data)
>                                                                 &uuid))
>                 return;
>
> -       printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
> +       append(line, "\t  " COLOR_YELLOW "charac" COLOR_OFF
>                                 " - start: 0x%04x, value: 0x%04x, "
>                                 "props: 0x%02x, ext_props: 0x%04x, uuid: =
",
>                                 handle, value_handle, properties, ext_pro=
p);
> -       print_uuid(&uuid);
> +       append_uuid(line, &uuid);
> +       print("%s", line);
>
>         gatt_db_service_foreach_desc(attr, print_desc, NULL);
>  }
>
>  static void print_service(struct gatt_db_attribute *attr, void *user_dat=
a)
>  {
> -       struct client *cli =3D user_data;
>         uint16_t start, end;
>         bool primary;
>         bt_uuid_t uuid;
> +       char line[MAX_LEN_LINE] =3D {0};
>
>         if (!gatt_db_attribute_get_service_data(attr, &start, &end, &prim=
ary,
>                                                                         &=
uuid))
>                 return;
>
> -       printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
> +       append(line, COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
>                                 "end: 0x%04x, type: %s, uuid: ",
>                                 start, end, primary ? "primary" : "second=
ary");
> -       print_uuid(&uuid);
> +       append_uuid(line, &uuid);
> +       print("%s", line);
>
> -       gatt_db_service_foreach_incl(attr, print_incl, cli);
> +       gatt_db_service_foreach_incl(attr, print_incl, NULL);
>         gatt_db_service_foreach_char(attr, print_chrc, NULL);
> -
> -       printf("\n");
>  }
>
>  static void print_services(struct client *cli)
>  {
> -       printf("\n");
> -
> -       gatt_db_foreach_service(cli->db, NULL, print_service, cli);
> +       gatt_db_foreach_service(cli->db, NULL, print_service, NULL);
>  }
>
> -static void print_services_by_uuid(struct client *cli, const bt_uuid_t *=
uuid)
> +static void print_services_by_uuid(const bt_uuid_t *uuid)
>  {
> -       printf("\n");
> -
> -       gatt_db_foreach_service(cli->db, uuid, print_service, cli);
> +       gatt_db_foreach_service(cli->db, uuid, print_service, NULL);
>  }
>
> -static void print_services_by_handle(struct client *cli, uint16_t handle=
)
> +static void print_services_by_handle(uint16_t handle)
>  {
> -       printf("\n");
> -
>         /* TODO: Filter by handle */
>         gatt_db_foreach_service(cli->db, NULL, print_service, cli);
>  }
>
>  static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
>  {
> -       struct client *cli =3D user_data;
> -
>         if (!success) {
> -               PRLOG("GATT discovery procedures failed - error code: 0x%=
02x\n",
> +               error("GATT discovery procedures failed - error code: 0x%=
02x",
>                                                                 att_ecode=
);
>                 return;
>         }
>
> -       PRLOG("GATT discovery procedures complete\n");
> +       print("GATT discovery procedures complete");
>
>         print_services(cli);
> -       print_prompt();
>  }
>
>  static void service_changed_cb(uint16_t start_handle, uint16_t end_handl=
e,
>                                                                 void *use=
r_data)
>  {
> -       struct client *cli =3D user_data;
> -
> -       printf("\nService Changed handled - start: 0x%04x end: 0x%04x\n",
> +       print("Service Changed handled - start: 0x%04x end: 0x%04x",
>                                                 start_handle, end_handle)=
;
>
> -       gatt_db_foreach_service_in_range(cli->db, NULL, print_service, cl=
i,
> +       gatt_db_foreach_service_in_range(cli->db, NULL, print_service, NU=
LL,
>                                                 start_handle, end_handle)=
;
> -       print_prompt();
> -}
> -
> -static void services_usage(void)
> -{
> -       printf("Usage: services [options]\nOptions:\n"
> -               "\t -u, --uuid <uuid>\tService UUID\n"
> -               "\t -a, --handle <handle>\tService start handle\n"
> -               "\t -h, --help\t\tShow help message\n"
> -               "e.g.:\n"
> -               "\tservices\n\tservices -u 0x180d\n\tservices -a 0x0009\n=
");
>  }
>
> -static bool parse_args(char *str, int expected_argc,  char **argv, int *=
argc)
> -{
> -       char **ap;
> -
> -       for (ap =3D argv; (*ap =3D strsep(&str, " \t")) !=3D NULL;) {
> -               if (**ap =3D=3D '\0')
> -                       continue;
> -
> -               (*argc)++;
> -               ap++;
> -
> -               if (*argc > expected_argc)
> -                       return false;
> -       }
> -
> -       return true;
> -}
> +static struct option services_options[] =3D {
> +       { "uuid",       1, 0, 'u' },
> +       { "handle",     1, 0, 'a' },
> +       { "help",       0, 0, 'h' },
> +       { 0, 0, 0, 0 }
> +};
>
> -static void cmd_services(struct client *cli, char *cmd_str)
> +static void cmd_services(int argc, char **argv)
>  {
> -       char *argv[3];
> -       int argc =3D 0;
> +       int opt;
> +       bool use_uuid =3D false;
> +       bt_uuid_t tmp, uuid;
> +       uint16_t handle =3D 0;
> +       char *endptr =3D NULL;
>
>         if (!bt_gatt_client_is_ready(cli->gatt)) {
> -               printf("GATT client not initialized\n");
> -               return;
> -       }
> -
> -       if (!parse_args(cmd_str, 2, argv, &argc)) {
> -               services_usage();
> -               return;
> -       }
> -
> -       if (!argc) {
> -               print_services(cli);
> +               print("GATT client not initialized");
>                 return;
>         }
>
> -       if (argc !=3D 2) {
> -               services_usage();
> -               return;
> -       }
> -
> -       if (!strcmp(argv[0], "-u") || !strcmp(argv[0], "--uuid")) {
> -               bt_uuid_t tmp, uuid;
> -
> -               if (bt_string_to_uuid(&tmp, argv[1]) < 0) {
> -                       printf("Invalid UUID: %s\n", argv[1]);
> -                       return;
> -               }
> -
> -               bt_uuid_to_uuid128(&tmp, &uuid);
> -
> -               print_services_by_uuid(cli, &uuid);
> -       } else if (!strcmp(argv[0], "-a") || !strcmp(argv[0], "--handle")=
) {
> -               uint16_t handle;
> -               char *endptr =3D NULL;
> -
> -               handle =3D strtol(argv[1], &endptr, 0);
> -               if (!endptr || *endptr !=3D '\0') {
> -                       printf("Invalid start handle: %s\n", argv[1]);
> -                       return;
> +       while ((opt =3D getopt_long(argc, argv, "u:a:", services_options,
> +                                                               NULL)) !=
=3D -1) {
> +               switch (opt) {
> +               case 'u':
> +                       if (bt_string_to_uuid(&tmp, optarg) < 0) {
> +                               error("Invalid UUID: %s", optarg);
> +                               optind =3D 0;
> +                               return bt_shell_noninteractive_quit(EXIT_=
FAILURE);
> +                       }
> +                       bt_uuid_to_uuid128(&tmp, &uuid);
> +                       use_uuid =3D true;
> +                       break;
> +               case 'a':
> +                       handle =3D strtol(optarg, &endptr, 0);
> +                       if (!endptr || *endptr !=3D '\0') {
> +                               error("Invalid start handle: %s", optarg)=
;
> +                               optind =3D 0;
> +                               return bt_shell_noninteractive_quit(EXIT_=
FAILURE);
> +                       }
> +                       break;
> +               case 'h':
> +                       bt_shell_usage();
> +                       optind =3D 0;
> +                       return bt_shell_noninteractive_quit(EXIT_SUCCESS)=
;
> +               default:
> +                       bt_shell_usage();
> +                       optind =3D 0;
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
>                 }
> +       }
>
> -               print_services_by_handle(cli, handle);
> -       } else
> -               services_usage();
> -}
> +       optind =3D 0;
>
> -static void read_multiple_usage(void)
> -{
> -       printf("Usage: read-multiple <handle_1> <handle_2> ...\n");
> +       if (use_uuid)
> +               print_services_by_uuid(&uuid);
> +       else
> +               print_services_by_handle(handle);
>  }
>
>  static void read_multiple_cb(bool success, uint8_t att_ecode,
> @@ -468,43 +447,37 @@ static void read_multiple_cb(bool success, uint8_t =
att_ecode,
>                                         void *user_data)
>  {
>         int i;
> +       char line[MAX_LEN_LINE] =3D {0};
>
>         if (!success) {
> -               PRLOG("\nRead multiple request failed: 0x%02x\n", att_eco=
de);
> +               error("Read multiple request failed: 0x%02x", att_ecode);
>                 return;
>         }
>
> -       printf("\nRead multiple value (%u bytes):", length);
> +       append(line, "Read multiple value (%u bytes):", length);
>
>         for (i =3D 0; i < length; i++)
> -               printf("%02x ", value[i]);
> +               append(line, "%02x ", value[i]);
>
> -       PRLOG("\n");
> +       print("%s", line);
>  }
>
> -static void cmd_read_multiple(struct client *cli, char *cmd_str)
> +static void cmd_read_multiple(int argc, char **argv)
>  {
> -       int argc =3D 0;
>         uint16_t *value;
> -       char *argv[512];
>         int i;
>         char *endptr =3D NULL;
>
> -       if (!parse_args(cmd_str, sizeof(argv), argv, &argc) || argc < 2) =
{
> -               read_multiple_usage();
> -               return;
> -       }
> -
>         value =3D malloc(sizeof(uint16_t) * argc);
>         if (!value) {
> -               printf("Failed to construct value\n");
> +               error("Failed to construct value");
>                 return;
>         }
>
> -       for (i =3D 0; i < argc; i++) {
> +       for (i =3D 1; i < argc; i++) {
>                 value[i] =3D strtol(argv[i], &endptr, 0);
>                 if (endptr =3D=3D argv[i] || *endptr !=3D '\0' || !value[=
i]) {
> -                       printf("Invalid value byte: %s\n", argv[i]);
> +                       error("Invalid value byte: %s", argv[i]);
>                         free(value);
>                         return;
>                 }
> @@ -512,133 +485,98 @@ static void cmd_read_multiple(struct client *cli, =
char *cmd_str)
>
>         if (!bt_gatt_client_read_multiple(cli->gatt, value, argc,
>                                                 read_multiple_cb, NULL, N=
ULL))
> -               printf("Failed to initiate read multiple procedure\n");
> +               error("Failed to initiate read multiple procedure");
>
>         free(value);
>  }
>
> -static void read_value_usage(void)
> -{
> -       printf("Usage: read-value <value_handle>\n");
> -}
> -
>  static void read_cb(bool success, uint8_t att_ecode, const uint8_t *valu=
e,
>                                         uint16_t length, void *user_data)
>  {
>         int i;
> +       char line[MAX_LEN_LINE] =3D {0};
>
>         if (!success) {
> -               PRLOG("\nRead request failed: %s (0x%02x)\n",
> +               error("Read request failed: %s (0x%02x)",
>                                 ecode_to_string(att_ecode), att_ecode);
>                 return;
>         }
>
> -       printf("\nRead value");
> +       append(line, "Read value");
>
>         if (length =3D=3D 0) {
> -               PRLOG(": 0 bytes\n");
> +               print("%s: 0 bytes", line);
>                 return;
>         }
>
> -       printf(" (%u bytes): ", length);
> +       append(line, " (%u bytes): ", length);
>
>         for (i =3D 0; i < length; i++)
> -               printf("%02x ", value[i]);
> +               append(line, "%02x ", value[i]);
>
> -       PRLOG("\n");
> +       print("%s", line);
>  }
>
> -static void cmd_read_value(struct client *cli, char *cmd_str)
> +static void cmd_read_value(int argc, char **argv)
>  {
> -       char *argv[2];
> -       int argc =3D 0;
>         uint16_t handle;
>         char *endptr =3D NULL;
>
> -       if (!parse_args(cmd_str, 1, argv, &argc) || argc !=3D 1) {
> -               read_value_usage();
> -               return;
> -       }
> -
> -       handle =3D strtol(argv[0], &endptr, 0);
> +       handle =3D strtol(argv[1], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || !handle) {
> -               printf("Invalid value handle: %s\n", argv[0]);
> +               error("Invalid value handle: %s", argv[1]);
>                 return;
>         }
>
>         if (!bt_gatt_client_read_value(cli->gatt, handle, read_cb,
>                                                                 NULL, NUL=
L))
> -               printf("Failed to initiate read value procedure\n");
> -}
> -
> -static void read_long_value_usage(void)
> -{
> -       printf("Usage: read-long-value <value_handle> <offset>\n");
> +               error("Failed to initiate read value procedure");
>  }
>
> -static void cmd_read_long_value(struct client *cli, char *cmd_str)
> +static void cmd_read_long_value(int argc, char **argv)
>  {
> -       char *argv[3];
> -       int argc =3D 0;
>         uint16_t handle;
>         uint16_t offset;
>         char *endptr =3D NULL;
>
> -       if (!parse_args(cmd_str, 2, argv, &argc) || argc !=3D 2) {
> -               read_long_value_usage();
> -               return;
> -       }
> -
> -       handle =3D strtol(argv[0], &endptr, 0);
> +       handle =3D strtol(argv[1], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || !handle) {
> -               printf("Invalid value handle: %s\n", argv[0]);
> +               error("Invalid value handle: %s", argv[1]);
>                 return;
>         }
>
>         endptr =3D NULL;
> -       offset =3D strtol(argv[1], &endptr, 0);
> +       offset =3D strtol(argv[2], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0') {
> -               printf("Invalid offset: %s\n", argv[1]);
> +               error("Invalid offset: %s", argv[2]);
>                 return;
>         }
>
>         if (!bt_gatt_client_read_long_value(cli->gatt, handle, offset, re=
ad_cb,
>                                                                 NULL, NUL=
L))
> -               printf("Failed to initiate read long value procedure\n");
> -}
> -
> -static void write_value_usage(void)
> -{
> -       printf("Usage: write-value [options] <value_handle> <value>\n"
> -               "Options:\n"
> -               "\t-w, --without-response\tWrite without response\n"
> -               "\t-s, --signed-write\tSigned write command\n"
> -               "e.g.:\n"
> -               "\twrite-value 0x0001 00 01 00\n");
> +               error("Failed to initiate read long value procedure");
>  }
>
>  static struct option write_value_options[] =3D {
>         { "without-response",   0, 0, 'w' },
>         { "signed-write",       0, 0, 's' },
> +       { "help",       0, 0, 'h' },
>         { }
>  };
>
>  static void write_cb(bool success, uint8_t att_ecode, void *user_data)
>  {
>         if (success) {
> -               PRLOG("\nWrite successful\n");
> +               print("Write successful");
>         } else {
> -               PRLOG("\nWrite failed: %s (0x%02x)\n",
> +               error("Write failed: %s (0x%02x)",
>                                 ecode_to_string(att_ecode), att_ecode);
>         }
>  }
>
> -static void cmd_write_value(struct client *cli, char *cmd_str)
> +static void cmd_write_value(int argc, char **argv)
>  {
>         int opt, i, val;
> -       char *argvbuf[516];
> -       char **argv =3D argvbuf;
> -       int argc =3D 1;
>         uint16_t handle;
>         char *endptr =3D NULL;
>         int length;
> @@ -646,14 +584,6 @@ static void cmd_write_value(struct client *cli, char=
 *cmd_str)
>         bool without_response =3D false;
>         bool signed_write =3D false;
>
> -       if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
> -               printf("Too many arguments\n");
> -               write_value_usage();
> -               return;
> -       }
> -
> -       optind =3D 0;
> -       argv[0] =3D "write-value";
>         while ((opt =3D getopt_long(argc, argv, "+ws", write_value_option=
s,
>                                                                 NULL)) !=
=3D -1) {
>                 switch (opt) {
> @@ -663,23 +593,24 @@ static void cmd_write_value(struct client *cli, cha=
r *cmd_str)
>                 case 's':
>                         signed_write =3D true;
>                         break;
> +               case 'h':
> +                       bt_shell_usage();
> +                       optind =3D 0;
> +                       return bt_shell_noninteractive_quit(EXIT_SUCCESS)=
;
>                 default:
> -                       write_value_usage();
> -                       return;
> +                       bt_shell_usage();
> +                       optind =3D 0;
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
>                 }
>         }
>
>         argc -=3D optind;
>         argv +=3D optind;
> -
> -       if (argc < 1) {
> -               write_value_usage();
> -               return;
> -       }
> +       optind =3D 0;
>
>         handle =3D strtol(argv[0], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || !handle) {
> -               printf("Invalid handle: %s\n", argv[0]);
> +               error("Invalid handle: %s", argv[1]);
>                 return;
>         }
>
> @@ -687,13 +618,13 @@ static void cmd_write_value(struct client *cli, cha=
r *cmd_str)
>
>         if (length > 0) {
>                 if (length > UINT16_MAX) {
> -                       printf("Write value too long\n");
> +                       error("Write value too long");
>                         return;
>                 }
>
>                 value =3D malloc(length);
>                 if (!value) {
> -                       printf("Failed to construct write value\n");
> +                       error("Failed to construct write value");
>                         return;
>                 }
>
> @@ -701,7 +632,7 @@ static void cmd_write_value(struct client *cli, char =
*cmd_str)
>                         val =3D strtol(argv[i], &endptr, 0);
>                         if (endptr =3D=3D argv[i] || *endptr !=3D '\0'
>                                 || errno =3D=3D ERANGE || val < 0 || val =
> 255) {
> -                               printf("Invalid value byte: %s\n",
> +                               error("Invalid value byte: %s",
>                                                                 argv[i]);
>                                 goto done;
>                         }
> @@ -712,36 +643,27 @@ static void cmd_write_value(struct client *cli, cha=
r *cmd_str)
>         if (without_response) {
>                 if (!bt_gatt_client_write_without_response(cli->gatt, han=
dle,
>                                                 signed_write, value, leng=
th)) {
> -                       printf("Failed to initiate write without response=
 "
> -                                                               "procedur=
e\n");
> +                       error("Failed to initiate write without response =
"
> +                                                               "procedur=
e");
>                         goto done;
>                 }
>
> -               printf("Write command sent\n");
> +               print("Write command sent");
>                 goto done;
>         }
>
>         if (!bt_gatt_client_write_value(cli->gatt, handle, value, length,
>                                                                 write_cb,
>                                                                 NULL, NUL=
L))
> -               printf("Failed to initiate write procedure\n");
> +               error("Failed to initiate write procedure");
>
>  done:
>         free(value);
>  }
>
> -static void write_long_value_usage(void)
> -{
> -       printf("Usage: write-long-value [options] <value_handle> <offset>=
 "
> -                               "<value>\n"
> -                               "Options:\n"
> -                               "\t-r, --reliable-write\tReliable write\n=
"
> -                               "e.g.:\n"
> -                               "\twrite-long-value 0x0001 0 00 01 00\n")=
;
> -}
> -
>  static struct option write_long_value_options[] =3D {
>         { "reliable-write",     0, 0, 'r' },
> +       { "help", 0, 0, 'h' },
>         { }
>  };
>
> @@ -749,21 +671,18 @@ static void write_long_cb(bool success, bool reliab=
le_error, uint8_t att_ecode,
>                                                                 void *use=
r_data)
>  {
>         if (success) {
> -               PRLOG("Write successful\n");
> +               print("Write successful");
>         } else if (reliable_error) {
> -               PRLOG("Reliable write not verified\n");
> +               error("Reliable write not verified");
>         } else {
> -               PRLOG("\nWrite failed: %s (0x%02x)\n",
> +               error("Write failed: %s (0x%02x)",
>                                 ecode_to_string(att_ecode), att_ecode);
>         }
>  }
>
> -static void cmd_write_long_value(struct client *cli, char *cmd_str)
> +static void cmd_write_long_value(int argc, char **argv)
>  {
>         int opt, i, val;
> -       char *argvbuf[516];
> -       char **argv =3D argvbuf;
> -       int argc =3D 1;
>         uint16_t handle;
>         uint16_t offset;
>         char *endptr =3D NULL;
> @@ -771,44 +690,44 @@ static void cmd_write_long_value(struct client *cli=
, char *cmd_str)
>         uint8_t *value =3D NULL;
>         bool reliable_writes =3D false;
>
> -       if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
> -               printf("Too many arguments\n");
> -               write_value_usage();
> -               return;
> -       }
> -
> -       optind =3D 0;
> -       argv[0] =3D "write-long-value";
>         while ((opt =3D getopt_long(argc, argv, "+r", write_long_value_op=
tions,
>                                                                 NULL)) !=
=3D -1) {
>                 switch (opt) {
>                 case 'r':
>                         reliable_writes =3D true;
>                         break;
> +               case 'h':
> +                       bt_shell_usage();
> +                       optind =3D 0;
> +                       return bt_shell_noninteractive_quit(EXIT_SUCCESS)=
;
>                 default:
> -                       write_long_value_usage();
> -                       return;
> +                       bt_shell_usage();
> +                       optind =3D 0;
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
>                 }
>         }
>
>         argc -=3D optind;
>         argv +=3D optind;
> +       optind =3D 0;
>
> -       if (argc < 2) {
> -               write_long_value_usage();
> +       if (argc > 514) {
> +               error("Too many arguments");
> +               bt_shell_usage();
> +               optind =3D 0;
>                 return;
>         }
>
>         handle =3D strtol(argv[0], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || !handle) {
> -               printf("Invalid handle: %s\n", argv[0]);
> +               error("Invalid handle: %s", argv[1]);
>                 return;
>         }
>
>         endptr =3D NULL;
>         offset =3D strtol(argv[1], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || errno =3D=3D ERANGE) {
> -               printf("Invalid offset: %s\n", argv[1]);
> +               error("Invalid offset: %s", argv[2]);
>                 return;
>         }
>
> @@ -816,13 +735,13 @@ static void cmd_write_long_value(struct client *cli=
, char *cmd_str)
>
>         if (length > 0) {
>                 if (length > UINT16_MAX) {
> -                       printf("Write value too long\n");
> +                       error("Write value too long");
>                         return;
>                 }
>
>                 value =3D malloc(length);
>                 if (!value) {
> -                       printf("Failed to construct write value\n");
> +                       error("Failed to construct write value");
>                         return;
>                 }
>
> @@ -830,7 +749,7 @@ static void cmd_write_long_value(struct client *cli, =
char *cmd_str)
>                         val =3D strtol(argv[i], &endptr, 0);
>                         if (endptr =3D=3D argv[i] || *endptr !=3D '\0'
>                                 || errno =3D=3D ERANGE || val < 0 || val =
> 255) {
> -                               printf("Invalid value byte: %s\n",
> +                               error("Invalid value byte: %s",
>                                                                 argv[i]);
>                                 free(value);
>                                 return;
> @@ -843,32 +762,20 @@ static void cmd_write_long_value(struct client *cli=
, char *cmd_str)
>                                                         offset, value, le=
ngth,
>                                                         write_long_cb,
>                                                         NULL, NULL))
> -               printf("Failed to initiate long write procedure\n");
> +               error("Failed to initiate long write procedure");
>
>         free(value);
>  }
>
> -static void write_prepare_usage(void)
> -{
> -       printf("Usage: write-prepare [options] <value_handle> <offset> "
> -                               "<value>\n"
> -                               "Options:\n"
> -                               "\t-s, --session-id\tSession id\n"
> -                               "e.g.:\n"
> -                               "\twrite-prepare -s 1 0x0001 00 01 00\n")=
;
> -}
> -
>  static struct option write_prepare_options[] =3D {
>         { "session-id",         1, 0, 's' },
> +       { "help", 0, 0, 'h' },
>         { }
>  };
>
> -static void cmd_write_prepare(struct client *cli, char *cmd_str)
> +static void cmd_write_prepare(int argc, char **argv)
>  {
>         int opt, i, val;
> -       char *argvbuf[516];
> -       char **argv =3D argvbuf;
> -       int argc =3D 0;
>         unsigned int id =3D 0;
>         uint16_t handle;
>         uint16_t offset;
> @@ -876,59 +783,50 @@ static void cmd_write_prepare(struct client *cli, c=
har *cmd_str)
>         unsigned int length;
>         uint8_t *value =3D NULL;
>
> -       if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
> -               printf("Too many arguments\n");
> -               write_value_usage();
> -               return;
> -       }
> -
> -       /* Add command name for getopt_long */
> -       argc++;
> -       argv[0] =3D "write-prepare";
> -
> -       optind =3D 0;
>         while ((opt =3D getopt_long(argc, argv , "s:", write_prepare_opti=
ons,
>                                                                 NULL)) !=
=3D -1) {
>                 switch (opt) {
>                 case 's':
> -                       if (!optarg) {
> -                               write_prepare_usage();
> -                               return;
> -                       }
> -
>                         id =3D atoi(optarg);
> -
>                         break;
> +               case 'h':
> +                       bt_shell_usage();
> +                       optind =3D 0;
> +                       return bt_shell_noninteractive_quit(EXIT_SUCCESS)=
;
>                 default:
> -                       write_prepare_usage();
> -                       return;
> +                       bt_shell_usage();
> +                       optind =3D 0;
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
>                 }
>         }
>
>         argc -=3D optind;
>         argv +=3D optind;
> +       optind =3D 0;
>
> -       if (argc < 3) {
> -               write_prepare_usage();
> +       if (argc > 514) {
> +               error("Too many arguments");
> +               bt_shell_usage();
> +               optind =3D 0;
>                 return;
>         }
>
>         if (cli->reliable_session_id !=3D id) {
> -               printf("Session id !=3D Ongoing session id (%u!=3D%u)\n",=
 id,
> +               error("Session id !=3D Ongoing session id (%u!=3D%u)", id=
,
>                                                 cli->reliable_session_id)=
;
>                 return;
>         }
>
>         handle =3D strtol(argv[0], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || !handle) {
> -               printf("Invalid handle: %s\n", argv[0]);
> +               error("Invalid handle: %s", argv[1]);
>                 return;
>         }
>
>         endptr =3D NULL;
>         offset =3D strtol(argv[1], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || errno =3D=3D ERANGE) {
> -               printf("Invalid offset: %s\n", argv[1]);
> +               error("Invalid offset: %s", argv[2]);
>                 return;
>         }
>
> @@ -942,13 +840,13 @@ static void cmd_write_prepare(struct client *cli, c=
har *cmd_str)
>                 goto done;
>
>         if (length > UINT16_MAX) {
> -               printf("Write value too long\n");
> +               error("Write value too long");
>                 return;
>         }
>
>         value =3D malloc(length);
>         if (!value) {
> -               printf("Failed to allocate memory for value\n");
> +               error("Failed to allocate memory for value");
>                 return;
>         }
>
> @@ -956,7 +854,7 @@ static void cmd_write_prepare(struct client *cli, cha=
r *cmd_str)
>                 val =3D strtol(argv[i], &endptr, 0);
>                 if (endptr =3D=3D argv[i] || *endptr !=3D '\0' || errno =
=3D=3D ERANGE
>                                                 || val < 0 || val > 255) =
{
> -                       printf("Invalid value byte: %s\n", argv[i]);
> +                       error("Invalid value byte: %s", argv[i]);
>                         free(value);
>                         return;
>                 }
> @@ -971,64 +869,43 @@ done:
>                                                         write_long_cb, NU=
LL,
>                                                         NULL);
>         if (!cli->reliable_session_id)
> -               printf("Failed to proceed prepare write\n");
> +               error("Failed to proceed prepare write");
>         else
> -               printf("Prepare write success.\n"
> -                               "Session id: %d to be used on next write\=
n",
> +               print("Prepare write success."
> +                               "Session id: %d to be used on next write"=
,
>                                                 cli->reliable_session_id)=
;
>
>         free(value);
>  }
>
> -static void write_execute_usage(void)
> -{
> -       printf("Usage: write-execute <session_id> <execute>\n"
> -                               "e.g.:\n"
> -                               "\twrite-execute 1 0\n");
> -}
> -
> -static void cmd_write_execute(struct client *cli, char *cmd_str)
> +static void cmd_write_execute(int argc, char **argv)
>  {
> -       char *argvbuf[516];
> -       char **argv =3D argvbuf;
> -       int argc =3D 0;
>         char *endptr =3D NULL;
>         unsigned int session_id;
>         bool execute;
>
> -       if (!parse_args(cmd_str, 514, argv, &argc)) {
> -               printf("Too many arguments\n");
> -               write_value_usage();
> -               return;
> -       }
> -
> -       if (argc < 2) {
> -               write_execute_usage();
> -               return;
> -       }
> -
> -       session_id =3D strtol(argv[0], &endptr, 0);
> +       session_id =3D strtol(argv[1], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0') {
> -               printf("Invalid session id: %s\n", argv[0]);
> +               error("Invalid session id: %s", argv[1]);
>                 return;
>         }
>
>         if (session_id !=3D cli->reliable_session_id) {
> -               printf("Invalid session id: %u !=3D %u\n", session_id,
> +               error("Invalid session id: %u !=3D %u", session_id,
>                                                 cli->reliable_session_id)=
;
>                 return;
>         }
>
> -       execute =3D !!strtol(argv[1], &endptr, 0);
> +       execute =3D !!strtol(argv[2], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0') {
> -               printf("Invalid execute: %s\n", argv[1]);
> +               error("Invalid execute: %s", argv[2]);
>                 return;
>         }
>
>         if (execute) {
>                 if (!bt_gatt_client_write_execute(cli->gatt, session_id,
>                                                         write_cb, NULL, N=
ULL))
> -                       printf("Failed to proceed write execute\n");
> +                       error("Failed to proceed write execute");
>         } else {
>                 bt_gatt_client_cancel(cli->gatt, session_id);
>         }
> @@ -1036,46 +913,40 @@ static void cmd_write_execute(struct client *cli, =
char *cmd_str)
>         cli->reliable_session_id =3D 0;
>  }
>
> -static void register_notify_usage(void)
> -{
> -       printf("Usage: register-notify <chrc value handle>\n");
> -}
> -
>  static void notify_cb(uint16_t value_handle, const uint8_t *value,
>                                         uint16_t length, void *user_data)
>  {
>         int i;
> +       char line[MAX_LEN_LINE] =3D {0};
>
> -       printf("\n\tHandle Value Not/Ind: 0x%04x - ", value_handle);
> +       append(line, "\tHandle Value Not/Ind: 0x%04x - ", value_handle);
>
>         if (length =3D=3D 0) {
> -               PRLOG("(0 bytes)\n");
> +               print("%s(0 bytes)", line);
>                 return;
>         }
>
> -       printf("(%u bytes): ", length);
> +       append(line, "(%u bytes): ", length);
>
>         for (i =3D 0; i < length; i++)
> -               printf("%02x ", value[i]);
> +               append(line, "%02x ", value[i]);
>
> -       PRLOG("\n");
> +       print("%s", line);
>  }
>
>  static void register_notify_cb(uint16_t att_ecode, void *user_data)
>  {
>         if (att_ecode) {
> -               PRLOG("Failed to register notify handler "
> -                                       "- error code: 0x%02x\n", att_eco=
de);
> +               error("Failed to register notify handler "
> +                                       "- error code: 0x%02x", att_ecode=
);
>                 return;
>         }
>
> -       PRLOG("Registered notify handler!\n");
> +       print("Registered notify handler!");
>  }
>
> -static void cmd_register_notify(struct client *cli, char *cmd_str)
> +static void cmd_register_notify(int argc, char **argv)
>  {
> -       char *argv[2];
> -       int argc =3D 0;
>         uint16_t value_handle;
>         unsigned int id;
>         char *endptr =3D NULL;
> @@ -1085,14 +956,9 @@ static void cmd_register_notify(struct client *cli,=
 char *cmd_str)
>                 return;
>         }
>
> -       if (!parse_args(cmd_str, 1, argv, &argc) || argc !=3D 1) {
> -               register_notify_usage();
> -               return;
> -       }
> -
> -       value_handle =3D strtol(argv[0], &endptr, 0);
> +       value_handle =3D strtol(argv[1], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || !value_handle) {
> -               printf("Invalid value handle: %s\n", argv[0]);
> +               error("Invalid value handle: %s", argv[1]);
>                 return;
>         }
>
> @@ -1100,22 +966,15 @@ static void cmd_register_notify(struct client *cli=
, char *cmd_str)
>                                                         register_notify_c=
b,
>                                                         notify_cb, NULL, =
NULL);
>         if (!id) {
> -               printf("Failed to register notify handler\n");
> +               error("Failed to register notify handler");
>                 return;
>         }
>
> -       printf("Registering notify handler with id: %u\n", id);
> +       print("Registering notify handler with id: %u", id);
>  }
>
> -static void unregister_notify_usage(void)
> +static void cmd_unregister_notify(int argc, char **argv)
>  {
> -       printf("Usage: unregister-notify <notify id>\n");
> -}
> -
> -static void cmd_unregister_notify(struct client *cli, char *cmd_str)
> -{
> -       char *argv[2];
> -       int argc =3D 0;
>         unsigned int id;
>         char *endptr =3D NULL;
>
> @@ -1124,72 +983,46 @@ static void cmd_unregister_notify(struct client *c=
li, char *cmd_str)
>                 return;
>         }
>
> -       if (!parse_args(cmd_str, 1, argv, &argc) || argc !=3D 1) {
> -               unregister_notify_usage();
> -               return;
> -       }
> -
> -       id =3D strtol(argv[0], &endptr, 0);
> +       id =3D strtol(argv[1], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || !id) {
> -               printf("Invalid notify id: %s\n", argv[0]);
> +               error("Invalid notify id: %s", argv[1]);
>                 return;
>         }
>
>         if (!bt_gatt_client_unregister_notify(cli->gatt, id)) {
> -               printf("Failed to unregister notify handler with id: %u\n=
", id);
> +               error("Failed to unregister notify handler with id: %u", =
id);
>                 return;
>         }
>
> -       printf("Unregistered notify handler with id: %u\n", id);
> -}
> -
> -static void set_security_usage(void)
> -{
> -       printf("Usage: set-security <level>\n"
> -               "level: 1-3\n"
> -               "e.g.:\n"
> -               "\tset-security 2\n");
> +       print("Unregistered notify handler with id: %u", id);
>  }
>
> -static void cmd_set_security(struct client *cli, char *cmd_str)
> +static void cmd_set_security(int argc, char **argv)
>  {
> -       char *argv[2];
> -       int argc =3D 0;
>         char *endptr =3D NULL;
>         int level;
>
> -       if (!parse_args(cmd_str, 1, argv, &argc)) {
> -               printf("Too many arguments\n");
> -               set_security_usage();
> -               return;
> -       }
> -
> -       if (argc < 1) {
> -               set_security_usage();
> -               return;
> -       }
> -
> -       level =3D strtol(argv[0], &endptr, 0);
> +       level =3D strtol(argv[1], &endptr, 0);
>         if (!endptr || *endptr !=3D '\0' || level < 1 || level > 3) {
> -               printf("Invalid level: %s\n", argv[0]);
> +               error("Invalid level: %s", argv[1]);
>                 return;
>         }
>
>         if (!bt_gatt_client_set_security(cli->gatt, level))
> -               printf("Could not set sec level\n");
> +               error("Could not set sec level");
>         else
> -               printf("Setting security level %d success\n", level);
> +               print("Setting security level %d success", level);
>  }
>
> -static void cmd_get_security(struct client *cli, char *cmd_str)
> +static void cmd_get_security(int argc, char **argv)
>  {
>         int level;
>
>         level =3D bt_gatt_client_get_security(cli->gatt);
>         if (level < 0)
> -               printf("Could not set sec level\n");
> +               error("Could not get sec level");
>         else
> -               printf("Security level: %u\n", level);
> +               print("Security level: %u", level);
>  }
>
>  static bool convert_sign_key(char *optarg, uint8_t key[16])
> @@ -1197,7 +1030,7 @@ static bool convert_sign_key(char *optarg, uint8_t =
key[16])
>         int i;
>
>         if (strlen(optarg) !=3D 32) {
> -               printf("sign-key length is invalid\n");
> +               error("sign-key length is invalid");
>                 return false;
>         }
>
> @@ -1209,14 +1042,6 @@ static bool convert_sign_key(char *optarg, uint8_t=
 key[16])
>         return true;
>  }
>
> -static void set_sign_key_usage(void)
> -{
> -       printf("Usage: set-sign-key [options]\nOptions:\n"
> -               "\t -c, --sign-key <csrk>\tCSRK\n"
> -               "e.g.:\n"
> -               "\tset-sign-key -c D8515948451FEA320DC05A2E88308188\n");
> -}
> -
>  static bool local_counter(uint32_t *sign_cnt, void *user_data)
>  {
>         static uint32_t cnt =3D 0;
> @@ -1226,141 +1051,74 @@ static bool local_counter(uint32_t *sign_cnt, vo=
id *user_data)
>         return true;
>  }
>
> -static void cmd_set_sign_key(struct client *cli, char *cmd_str)
> +static void cmd_set_sign_key(int argc, char **argv)
>  {
> -       char *argv[3];
> -       int argc =3D 0;
>         uint8_t key[16];
>
>         memset(key, 0, 16);
>
> -       if (!parse_args(cmd_str, 2, argv, &argc)) {
> -               set_sign_key_usage();
> -               return;
> -       }
> -
> -       if (argc !=3D 2) {
> -               set_sign_key_usage();
> -               return;
> -       }
> -
> -       if (!strcmp(argv[0], "-c") || !strcmp(argv[0], "--sign-key")) {
> -               if (convert_sign_key(argv[1], key))
> +       if (!strcmp(argv[1], "-c") || !strcmp(argv[1], "--sign-key")) {
> +               if (convert_sign_key(argv[2], key))
>                         bt_att_set_local_key(cli->att, key, local_counter=
, cli);
> -       } else
> -               set_sign_key_usage();
> -}
> -
> -static void cmd_help(struct client *cli, char *cmd_str);
> -
> -typedef void (*command_func_t)(struct client *cli, char *cmd_str);
> -
> -static struct {
> -       char *cmd;
> -       command_func_t func;
> -       char *doc;
> -} command[] =3D {
> -       { "help", cmd_help, "\tDisplay help message" },
> -       { "services", cmd_services, "\tShow discovered services" },
> -       { "read-value", cmd_read_value,
> -                               "\tRead a characteristic or descriptor va=
lue" },
> -       { "read-long-value", cmd_read_long_value,
> -               "\tRead a long characteristic or desctriptor value" },
> -       { "read-multiple", cmd_read_multiple, "\tRead Multiple" },
> -       { "write-value", cmd_write_value,
> -                       "\tWrite a characteristic or descriptor value" },
> -       { "write-long-value", cmd_write_long_value,
> -                       "Write long characteristic or descriptor value" }=
,
> -       { "write-prepare", cmd_write_prepare,
> -                       "\tWrite prepare characteristic or descriptor val=
ue" },
> -       { "write-execute", cmd_write_execute,
> -                       "\tExecute already prepared write" },
> -       { "register-notify", cmd_register_notify,
> -                       "\tSubscribe to not/ind from a characteristic" },
> -       { "unregister-notify", cmd_unregister_notify,
> -                                               "Unregister a not/ind ses=
sion"},
> -       { "set-security", cmd_set_security,
> -                               "\tSet security level on le connection"},
> -       { "get-security", cmd_get_security,
> -                               "\tGet security level on le connection"},
> -       { "set-sign-key", cmd_set_sign_key,
> -                               "\tSet signing key for signed write comma=
nd"},
> -       { }
> -};
> -
> -static void cmd_help(struct client *cli, char *cmd_str)
> -{
> -       int i;
> -
> -       printf("Commands:\n");
> -       for (i =3D 0; command[i].cmd; i++)
> -               printf("\t%-15s\t%s\n", command[i].cmd, command[i].doc);
> -}
> -
> -static void prompt_read_cb(int fd, uint32_t events, void *user_data)
> -{
> -       ssize_t read;
> -       size_t len =3D 0;
> -       char *line =3D NULL;
> -       char *cmd =3D NULL, *args;
> -       struct client *cli =3D user_data;
> -       int i;
> -
> -       if (events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR)) {
> -               mainloop_quit();
> -               return;
> -       }
> -
> -       read =3D getline(&line, &len, stdin);
> -       if (read < 0) {
> -               free(line);
> -               return;
> -       }
> -
> -       if (read <=3D 1) {
> -               cmd_help(cli, NULL);
> -               print_prompt();
> -               free(line);
> -               return;
> -       }
> -
> -       line[read-1] =3D '\0';
> -       args =3D line;
> -
> -       while ((cmd =3D strsep(&args, " \t")))
> -               if (*cmd !=3D '\0')
> -                       break;
> -
> -       if (!cmd)
> -               goto failed;
> -
> -       for (i =3D 0; command[i].cmd; i++) {
> -               if (strcmp(command[i].cmd, cmd) =3D=3D 0)
> -                       break;
> +       } else {
> +               bt_shell_usage();
> +               optind =3D 0;
>         }
> -
> -       if (command[i].cmd)
> -               command[i].func(cli, args);
> -       else
> -               fprintf(stderr, "Unknown command: %s\n", line);
> -
> -failed:
> -       print_prompt();
> -
> -       free(line);
>  }
>
> -static void signal_cb(int signum, void *user_data)
> -{
> -       switch (signum) {
> -       case SIGINT:
> -       case SIGTERM:
> -               mainloop_quit();
> -               break;
> -       default:
> -               break;
> -       }
> -}
> +static const struct bt_shell_menu main_menu =3D {
> +       .name =3D "main",
> +       .entries =3D {
> +       { "services", "[options...]", cmd_services,
> +               "Show discovered services\n"
> +               "Options:\n"
> +                       "\t -u, --uuid <uuid>\tService UUID\n"
> +                       "\t -a, --handle <handle>\tService start handle\n=
"
> +               "e.g.:\n"
> +                       "\tservices\n\tservices -u 0x180d\n\tservices -a =
0x0009"
> +       },
> +       { "read-value", "<value_handle>",
> +               cmd_read_value, "Read a characteristic or descriptor valu=
e" },
> +       { "read-long-value", "<value_handle> <offset>",
> +               cmd_read_long_value, "Read a long characteristic or desct=
riptor value" },
> +       { "read-multiple", "<handles...>",
> +               cmd_read_multiple, "Read Multiple" },
> +       { "write-value", " [-w|-s] <value_handle> <value...>",
> +               cmd_write_value, "Write a characteristic or descriptor va=
lue\n"
> +               "Options:\n"
> +                       "\t-w, --without-response\tWrite without response=
\n"
> +                       "\t-s, --signed-write\tSigned write command\n"
> +               "e.g.:\n"
> +                       "\twrite-value 0x0001 00 01 00"
> +       },
> +       { "write-long-value", "[-r] <value_handle> <offset>",
> +               cmd_write_long_value, "Write long characteristic or descr=
iptor value\n"
> +               "Options:\n"
> +                       "\t-r, --reliable-write\tReliable write\n"
> +               "e.g.:\n"
> +                       "\twrite-long-value 0x0001 0 00 01 00"
> +       },
> +       { "write-prepare", " [options...] <value_handle> <value>",
> +               cmd_write_prepare, "Write prepare characteristic or descr=
iptor value\n"
> +               "Options:\n"
> +                       "\t-s, --session-id\tSession id\n"
> +               "e.g.:\n"
> +                       "\twrite-prepare -s 1 0x0001 00 01 00"
> +       },
> +       { "write-execute", " <session_id> <execute>",
> +               cmd_write_execute, "Execute already prepared write" },
> +       { "register-notify", "<chrc_value_handle>",
> +               cmd_register_notify, "Subscribe to not/ind from a charact=
eristic" },
> +       { "unregister-notify", "<notify_id>",
> +               cmd_unregister_notify, "Unregister a not/ind session"},
> +       { "set-security", "<level 1-3>",
> +               cmd_set_security, "Set security level on connection"},
> +       { "get-security", NULL,
> +               cmd_get_security, "Get security level on connection"},
> +       { "set-sign-key", "<csrk>",
> +               cmd_set_sign_key, "Set signing key for signed write comma=
nd"},
> +       {} },
> +};
>
>  static int l2cap_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_t=
ype,
>                                                                         i=
nt sec)
> @@ -1375,15 +1133,15 @@ static int l2cap_att_connect(bdaddr_t *src, bdadd=
r_t *dst, uint8_t dst_type,
>                 ba2str(src, srcaddr_str);
>                 ba2str(dst, dstaddr_str);
>
> -               printf("btgatt-client: Opening L2CAP %s connection on ATT=
 "
> -                                       "channel:\n\t src: %s\n\tdest: %s=
\n",
> +               print("btgatt-client: Opening L2CAP %s connection on ATT =
"
> +                                       "channel:\n\t src: %s\n\tdest: %s=
",
>                                         (dst_type =3D=3D BDADDR_BREDR ? "=
BR/EDR" : "LE"),
>                                         srcaddr_str, dstaddr_str);
>         }
>
>         sock =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
>         if (sock < 0) {
> -               perror("Failed to create L2CAP socket");
> +               error("Failed to create L2CAP socket");
>                 return -1;
>         }
>
> @@ -1398,7 +1156,7 @@ static int l2cap_att_connect(bdaddr_t *src, bdaddr_=
t *dst, uint8_t dst_type,
>         bacpy(&srcaddr.l2_bdaddr, src);
>
>         if (bind(sock, (struct sockaddr *)&srcaddr, sizeof(srcaddr)) < 0)=
 {
> -               perror("Failed to bind L2CAP socket");
> +               error("Failed to bind L2CAP socket");
>                 close(sock);
>                 return -1;
>         }
> @@ -1408,7 +1166,7 @@ static int l2cap_att_connect(bdaddr_t *src, bdaddr_=
t *dst, uint8_t dst_type,
>         btsec.level =3D sec;
>         if (setsockopt(sock, SOL_BLUETOOTH, BT_SECURITY, &btsec,
>                                                         sizeof(btsec)) !=
=3D 0) {
> -               fprintf(stderr, "Failed to set L2CAP security level\n");
> +               error("Failed to set L2CAP security level");
>                 close(sock);
>                 return -1;
>         }
> @@ -1423,164 +1181,144 @@ static int l2cap_att_connect(bdaddr_t *src, bda=
ddr_t *dst, uint8_t dst_type,
>         dstaddr.l2_bdaddr_type =3D dst_type;
>         bacpy(&dstaddr.l2_bdaddr, dst);
>
> -       printf("Connecting to device...");
> +       print("Connecting to device...");
>         fflush(stdout);
>
>         if (connect(sock, (struct sockaddr *) &dstaddr, sizeof(dstaddr)) =
< 0) {
> -               perror(" Failed to connect");
> +               error("Failed to connect");
>                 close(sock);
>                 return -1;
>         }
>
> -       printf(" Done\n");
> +       print("Done");
>
>         return sock;
>  }
>
> -static void usage(void)
> -{
> -       printf("btgatt-client\n");
> -       printf("Usage:\n\tbtgatt-client [options]\n");
> -
> -       printf("Options:\n"
> -               "\t-i, --index <id>\t\tSpecify adapter index, e.g. hci0\n=
"
> -               "\t-d, --dest <addr>\t\tSpecify the destination address\n=
"
> -               "\t-t, --type [random|public|bredr] \tSpecify the address=
 type\n"
> -               "\t-m, --mtu <mtu> \t\tThe ATT MTU to use\n"
> -               "\t-s, --security-level <sec> \tSet security level (low|m=
edium|"
> -                                                               "high|fip=
s)\n"
> -               "\t-v, --verbose\t\t\tEnable extra logging\n"
> -               "\t-h, --help\t\t\tDisplay help\n");
> -}
> -
>  static struct option main_options[] =3D {
> -       { "index",              1, 0, 'i' },
> -       { "dest",               1, 0, 'd' },
> -       { "type",               1, 0, 't' },
> -       { "mtu",                1, 0, 'm' },
> -       { "security-level",     1, 0, 's' },
> -       { "verbose",            0, 0, 'v' },
> -       { "help",               0, 0, 'h' },
> +       { "index",     required_argument, NULL, 'i' },
> +       { "dst-addr",  required_argument, NULL, 'd' },
> +       { "type",      required_argument, NULL, 'T' },
> +       { "mtu",       required_argument, NULL, 'M' },
> +       { "sec-level", required_argument, NULL, 's' },
> +       { "verbose",   no_argument,       NULL, 'V' },
>         { }
>  };
>
> +static const char *index_option;
> +static const char *dst_addr_option;
> +static const char *type_option;
> +static const char *mtu_option;
> +static const char *security_level_option;
> +static const char *verbose_option;
> +
> +static const char **optargs[] =3D {
> +       &index_option,
> +       &dst_addr_option,
> +       &type_option,
> +       &mtu_option,
> +       &security_level_option,
> +       &verbose_option,
> +};
> +
> +static const char *help[] =3D {
> +       "Specify adapter index, e.g. hci0",
> +       "Specify the destination address",
> +       "Specify the address type (random|public|bredr)",
> +       "The ATT MTU to use",
> +       "Set security level (low|medium|high|fips)",
> +       "Enable extra logging"
> +};
> +
> +static const struct bt_shell_opt opt =3D {
> +       .options =3D main_options,
> +       .optno =3D sizeof(main_options) / sizeof(struct option),
> +       .optstr =3D "i:d:T:M:s:V",
> +       .optarg =3D optargs,
> +       .help =3D help,
> +};
> +
>  int main(int argc, char *argv[])
>  {
> -       int opt;
>         int sec =3D BT_SECURITY_LOW;
>         uint16_t mtu =3D 0;
>         uint8_t dst_type =3D BDADDR_LE_PUBLIC;
> -       bool dst_addr_given =3D false;
>         bdaddr_t src_addr, dst_addr;
>         int dev_id =3D -1;
>         int fd;
> -       struct client *cli;
> -
> -       while ((opt =3D getopt_long(argc, argv, "+hvs:m:t:d:i:",
> -                                               main_options, NULL)) !=3D=
 -1) {
> -               switch (opt) {
> -               case 'h':
> -                       usage();
> -                       return EXIT_SUCCESS;
> -               case 'v':
> -                       verbose =3D true;
> -                       break;
> -               case 's':
> -                       if (strcmp(optarg, "low") =3D=3D 0)
> -                               sec =3D BT_SECURITY_LOW;
> -                       else if (strcmp(optarg, "medium") =3D=3D 0)
> -                               sec =3D BT_SECURITY_MEDIUM;
> -                       else if (strcmp(optarg, "high") =3D=3D 0)
> -                               sec =3D BT_SECURITY_HIGH;
> -                       else if (strcmp(optarg, "fips") =3D=3D 0)
> -                               sec =3D BT_SECURITY_FIPS;
> -                       else {
> -                               fprintf(stderr, "Invalid security level\n=
");
> -                               return EXIT_FAILURE;
> -                       }
> -                       break;
> -               case 'm': {
> -                       int arg;
> -
> -                       arg =3D atoi(optarg);
> -                       if (arg <=3D 0) {
> -                               fprintf(stderr, "Invalid MTU: %d\n", arg)=
;
> -                               return EXIT_FAILURE;
> -                       }
> -
> -                       if (arg > UINT16_MAX) {
> -                               fprintf(stderr, "MTU too large: %d\n", ar=
g);
> -                               return EXIT_FAILURE;
> -                       }
> -
> -                       mtu =3D (uint16_t)arg;
> -                       break;
> +       int status;
> +
> +       bt_shell_init(argc, argv, &opt);
> +       bt_shell_set_menu(&main_menu);
> +
> +       if (verbose_option)
> +               verbose =3D true;
> +       if (security_level_option) {
> +               if (strcmp(security_level_option, "low") =3D=3D 0)
> +                       sec =3D BT_SECURITY_LOW;
> +               else if (strcmp(security_level_option, "medium") =3D=3D 0=
)
> +                       sec =3D BT_SECURITY_MEDIUM;
> +               else if (strcmp(security_level_option, "high") =3D=3D 0)
> +                       sec =3D BT_SECURITY_HIGH;
> +               else if (strcmp(security_level_option, "fips") =3D=3D 0)
> +                       sec =3D BT_SECURITY_FIPS;
> +               else {
> +                       error("Invalid security level");
> +                       return EXIT_FAILURE;
>                 }
> -               case 't':
> -                       if (strcmp(optarg, "random") =3D=3D 0)
> -                               dst_type =3D BDADDR_LE_RANDOM;
> -                       else if (strcmp(optarg, "public") =3D=3D 0)
> -                               dst_type =3D BDADDR_LE_PUBLIC;
> -                       else if (strcmp(optarg, "bredr") =3D=3D 0)
> -                               dst_type =3D BDADDR_BREDR;
> -                       else {
> -                               fprintf(stderr,
> -                                       "Allowed types: random, public, b=
redr\n");
> -                               return EXIT_FAILURE;
> -                       }
> -                       break;
> -               case 'd':
> -                       if (str2ba(optarg, &dst_addr) < 0) {
> -                               fprintf(stderr, "Invalid remote address: =
%s\n",
> -                                                                       o=
ptarg);
> -                               return EXIT_FAILURE;
> -                       }
> +       }
> +       if (mtu_option) {
> +               int arg;
>
> -                       dst_addr_given =3D true;
> -                       break;
> +               arg =3D atoi(mtu_option);
> +               if (arg <=3D 0) {
> +                       error("Invalid MTU: %d", arg);
> +                       return EXIT_FAILURE;
> +               }
>
> -               case 'i':
> -                       dev_id =3D hci_devid(optarg);
> -                       if (dev_id < 0) {
> -                               perror("Invalid adapter");
> -                               return EXIT_FAILURE;
> -                       }
> +               if (arg > UINT16_MAX) {
> +                       error("MTU too large: %d", arg);
> +                       return EXIT_FAILURE;
> +               }
>
> -                       break;
> -               default:
> -                       fprintf(stderr, "Invalid option: %c\n", opt);
> +               mtu =3D (uint16_t)arg;
> +       }
> +       if (type_option) {
> +               if (strcmp(type_option, "random") =3D=3D 0)
> +                       dst_type =3D BDADDR_LE_RANDOM;
> +               else if (strcmp(type_option, "public") =3D=3D 0)
> +                       dst_type =3D BDADDR_LE_PUBLIC;
> +               else if (strcmp(type_option, "bredr") =3D=3D 0)
> +                       dst_type =3D BDADDR_BREDR;
> +               else {
> +                       error("Allowed types: random, public, bredr");
>                         return EXIT_FAILURE;
>                 }
>         }
> -
> -       if (!argc) {
> -               usage();
> -               return EXIT_SUCCESS;
> +       if (dst_addr_option) {
> +               if (str2ba(dst_addr_option, &dst_addr) < 0) {
> +                       error("Invalid remote address: %s", dst_addr_opti=
on);
> +                       return EXIT_FAILURE;
> +               }
> +       } else {
> +               error("Destination address required!");
> +               return EXIT_FAILURE;
>         }
> -
> -       argc -=3D optind;
> -       argv +=3D optind;
> -       optind =3D 0;
> -
> -       if (argc) {
> -               usage();
> -               return EXIT_SUCCESS;
> +       if (index_option) {
> +               dev_id =3D hci_devid(index_option);
> +               if (dev_id < 0) {
> +                       error("Invalid adapter");
> +                       return EXIT_FAILURE;
> +               }
>         }
>
>         if (dev_id =3D=3D -1)
>                 bacpy(&src_addr, BDADDR_ANY);
>         else if (hci_devba(dev_id, &src_addr) < 0) {
> -               perror("Adapter not available");
> +               error("Adapter not available");
>                 return EXIT_FAILURE;
>         }
>
> -       if (!dst_addr_given) {
> -               fprintf(stderr, "Destination address required!\n");
> -               return EXIT_FAILURE;
> -       }
> -
> -       mainloop_init();
> -
>         fd =3D l2cap_att_connect(&src_addr, &dst_addr, dst_type, sec);
>         if (fd < 0)
>                 return EXIT_FAILURE;
> @@ -1591,20 +1329,15 @@ int main(int argc, char *argv[])
>                 return EXIT_FAILURE;
>         }
>
> -       if (mainloop_add_fd(fileno(stdin),
> -                               EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLER=
R,
> -                               prompt_read_cb, cli, NULL) < 0) {
> -               fprintf(stderr, "Failed to initialize console\n");
> -               return EXIT_FAILURE;
> -       }
> -
> -       print_prompt();
> -
> -       mainloop_run_with_signal(signal_cb, NULL);
> +       bt_shell_attach(fileno(stdin));
> +       update_prompt();
> +       shell_running =3D true;
> +       status =3D bt_shell_run();
> +       shell_running =3D false;
>
> -       printf("\n\nShutting down...\n");
> +       print("Shutting down...");
>
>         client_destroy(cli);
>
> -       return EXIT_SUCCESS;
> +       return status;
>  }
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
