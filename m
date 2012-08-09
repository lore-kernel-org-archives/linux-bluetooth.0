Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1344502915-487-1-git-send-email-luf@pzkagis.cz>
References: <1344502915-487-1-git-send-email-luf@pzkagis.cz>
Date: Thu, 9 Aug 2012 13:53:21 +0300
Message-ID: <CABBYNZ+5r8pqrfdB16k0=Zyfw6Dk0oQL0FEuppBrFoAL-ZZGHw@mail.gmail.com>
Subject: Re: [PATCH] irmc: Fix possible memory leak in handling of location
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ludek Finstrle <luf@pzkagis.cz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ludek,

On Thu, Aug 9, 2012 at 12:01 PM, Ludek Finstrle <luf@pzkagis.cz> wrote:
> ---
>  plugins/irmc.c |   19 ++++++++++++-------
>  1 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/plugins/irmc.c b/plugins/irmc.c
> index 2a8c543..0a0dc93 100644
> --- a/plugins/irmc.c
> +++ b/plugins/irmc.c
> @@ -401,6 +401,7 @@ static void *irmc_open(const char *name, int oflag, mode_t mode, void *context,
>  {
>         struct irmc_session *irmc = context;
>         int ret = 0;
> +       void *retp = NULL
>         char *path;
>
>         DBG("name %s context %p", name, context);
> @@ -422,22 +423,26 @@ static void *irmc_open(const char *name, int oflag, mode_t mode, void *context,
>                 path = g_build_filename("/", name, NULL);
>
>         if (g_str_equal(path, PB_DEVINFO))
> -               return irmc_open_devinfo(irmc, err);
> +               retp = irmc_open_devinfo(irmc, err);
>         else if (g_str_equal(path, PB_CONTACTS))
> -               return irmc_open_pb(irmc, err);
> +               retp = irmc_open_pb(irmc, err);
>         else if (g_str_equal(path, PB_INFO_LOG))
> -               return irmc_open_info(irmc, err);
> +               retp = irmc_open_info(irmc, err);
>         else if (g_str_equal(path, PB_CC_LOG))
> -               return irmc_open_cc(irmc, err);
> +               retp = irmc_open_cc(irmc, err);
>         else if (g_str_has_prefix(path, PB_CALENDAR_FOLDER))
> -               return irmc_open_cal(irmc, err);
> +               retp = irmc_open_cal(irmc, err);
>         else if (g_str_has_prefix(path, PB_NOTES_FOLDER))
> -               return irmc_open_nt(irmc, err);
> +               retp = irmc_open_nt(irmc, err);
>         else if (g_str_has_prefix(path, PB_LUID_FOLDER))
> -               return irmc_open_luid(irmc, err);
> +               retp = irmc_open_luid(irmc, err);
>         else
>                 ret = -EBADR;
>
> +       g_free(path);
> +       if (retp)
> +               return retp;
> +
>  fail:
>         if (err)
>                 *err = ret;
> --
> 1.7.1

Doesnt compile:

plugins/irmc.c: In function ‘irmc_open’:
plugins/irmc.c:405:2: error: expected ‘,’ or ‘;’ before ‘char’
plugins/irmc.c:421:3: error: ‘path’ undeclared (first use in this function)
plugins/irmc.c:421:3: note: each undeclared identifier is reported
only once for each function it appears in
make[1]: *** [plugins/irmc.o] Error 1
make: *** [all] Error 2

Anyway Ive done a little bit different fix:

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 2a8c543..c9c3521 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -281,7 +281,7 @@ static int irmc_chkput(struct obex_session *os,
void *user_data)
 	return -EBADR;
 }

-static void *irmc_open_devinfo(struct irmc_session *irmc, int *err)
+static int irmc_open_devinfo(struct irmc_session *irmc)
 {
 	if (!irmc->buffer)
 		irmc->buffer = g_string_new("");
@@ -301,10 +301,10 @@ static void *irmc_open_devinfo(struct
irmc_session *irmc, int *err)
 				"NOTE-TYPE-RX:NONE\r\n",
 				irmc->manu, irmc->model, irmc->sn);

-	return irmc;
+	return 0;
 }

-static void *irmc_open_pb(struct irmc_session *irmc, int *err)
+static int irmc_open_pb(struct irmc_session *irmc)
 {
 	int ret;

@@ -313,25 +313,19 @@ static void *irmc_open_pb(struct irmc_session
*irmc, int *err)
 						query_result, irmc, &ret);
 	if (ret < 0) {
 		DBG("phonebook_pull failed...");
-		goto fail;
+		return ret;
 	}

 	ret = phonebook_pull_read(irmc->request);
 	if (ret < 0) {
 		DBG("phonebook_pull_read failed...");
-		goto fail;
+		return ret;
 	}

-	return irmc;
-
-fail:
-	if (err)
-		*err = ret;
-
-	return NULL;
+	return 0;
 }

-static void *irmc_open_info(struct irmc_session *irmc, int *err)
+static int irmc_open_info(struct irmc_session *irmc)
 {
 	if (irmc->buffer == NULL)
 		irmc->buffer = g_string_new("");
@@ -343,20 +337,20 @@ static void *irmc_open_info(struct irmc_session
*irmc, int *err)
 				irmc->params->maxlistcount,
 				irmc->params->maxlistcount, irmc->did);

-	return irmc;
+	return 0;
 }

-static void *irmc_open_cc(struct irmc_session *irmc, int *err)
+static int irmc_open_cc(struct irmc_session *irmc)
 {
 	if (irmc->buffer == NULL)
 		irmc->buffer = g_string_new("");

 	g_string_printf(irmc->buffer, "%d\r\n", irmc->params->maxlistcount);

-	return irmc;
+	return 0;
 }

-static void *irmc_open_cal(struct irmc_session *irmc, int *err)
+static int irmc_open_cal(struct irmc_session *irmc)
 {
 	/* no suport yet. Just return an empty buffer. cal.vcs */
 	DBG("unsupported, returning empty buffer");
@@ -364,10 +358,10 @@ static void *irmc_open_cal(struct irmc_session
*irmc, int *err)
 	if (!irmc->buffer)
 		irmc->buffer = g_string_new("");

-	return irmc;
+	return 0;
 }

-static void *irmc_open_nt(struct irmc_session *irmc, int *err)
+static int irmc_open_nt(struct irmc_session *irmc)
 {
 	/* no suport yet. Just return an empty buffer. nt.vnt */
 	DBG("unsupported, returning empty buffer");
@@ -375,10 +369,10 @@ static void *irmc_open_nt(struct irmc_session
*irmc, int *err)
 	if (!irmc->buffer)
 		irmc->buffer = g_string_new("");

-	return irmc;
+	return 0;
 }

-static void *irmc_open_luid(struct irmc_session *irmc, int *err)
+static int irmc_open_luid(struct irmc_session *irmc)
 {
 	if (irmc->buffer == NULL)
 		irmc->buffer = g_string_new("");
@@ -393,7 +387,7 @@ static void *irmc_open_luid(struct irmc_session
*irmc, int *err)
 					irmc->params->maxlistcount,
 					irmc->params->maxlistcount);

-	return irmc;
+	return 0;
 }

 static void *irmc_open(const char *name, int oflag, mode_t mode, void *context,
@@ -422,22 +416,27 @@ static void *irmc_open(const char *name, int
oflag, mode_t mode, void *context,
 		path = g_build_filename("/", name, NULL);

 	if (g_str_equal(path, PB_DEVINFO))
-		return irmc_open_devinfo(irmc, err);
+		ret = irmc_open_devinfo(irmc);
 	else if (g_str_equal(path, PB_CONTACTS))
-		return irmc_open_pb(irmc, err);
+		ret = irmc_open_pb(irmc);
 	else if (g_str_equal(path, PB_INFO_LOG))
-		return irmc_open_info(irmc, err);
+		ret = irmc_open_info(irmc);
 	else if (g_str_equal(path, PB_CC_LOG))
-		return irmc_open_cc(irmc, err);
+		ret = irmc_open_cc(irmc);
 	else if (g_str_has_prefix(path, PB_CALENDAR_FOLDER))
-		return irmc_open_cal(irmc, err);
+		ret = irmc_open_cal(irmc);
 	else if (g_str_has_prefix(path, PB_NOTES_FOLDER))
-		return irmc_open_nt(irmc, err);
+		ret = irmc_open_nt(irmc);
 	else if (g_str_has_prefix(path, PB_LUID_FOLDER))
-		return irmc_open_luid(irmc, err);
+		ret = irmc_open_luid(irmc);
 	else
 		ret = -EBADR;

+	g_free(path);
+
+	if (ret == 0)
+		return irmc;
+
 fail:
 	if (err)
 		*err = ret;
-- 
1.7.11.2


-- 
Luiz Augusto von Dentz
