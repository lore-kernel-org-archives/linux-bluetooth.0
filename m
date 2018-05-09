Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] build: Disable some warnings from GCC 8
Date: Wed, 09 May 2018 15:04:16 +0200
Message-ID: <2459401.iogB4MuffB@ix>
In-Reply-To: <EDA6E2ED-674B-45FE-900B-6DA05D1D1EC2@holtmann.org>
References: <20180509121113.4110-1-szymon.janc@codecoup.pl> <EDA6E2ED-674B-45FE-900B-6DA05D1D1EC2@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marce,

On Wednesday, 9 May 2018 14:26:36 CEST Marcel Holtmann wrote:
> Hi Szymon,
>=20
> > GCC 8 -Wall -Wextra seem to enable additional checks. Those generates
> > lots of spourious warnings so disable them (at least for time being).
> > ---
> > acinclude.m4 | 3 +++
> > 1 file changed, 3 insertions(+)
> >=20
> > diff --git a/acinclude.m4 b/acinclude.m4
> > index bc39c6d73..39a6be44a 100644
> > --- a/acinclude.m4
> > +++ b/acinclude.m4
> > @@ -16,6 +16,9 @@ AC_DEFUN([COMPILER_FLAGS], [
> >=20
> > 		with_cflags=3D"$with_cflags -Wall -Werror -Wextra"
> > 		with_cflags=3D"$with_cflags -Wno-unused-parameter"
> > 		with_cflags=3D"$with_cflags -Wno-missing-field-initializers"
> >=20
> > +		with_cflags=3D"$with_cflags -Wno-format-truncation"
> > +		with_cflags=3D"$with_cflags -Wno-cast-function-type"
> > +		with_cflags=3D"$with_cflags -Wno-stringop-truncation=E2=80=9D
>=20
> can you explain these with examples on why we would disable them.

=2DWformat-truncation

Than one warns when snprintf could be truncated:
eg=20
char a[10];
char b[10];
char c[15];
=2E.
snprintf(c, sizeof(c), "%s%s", a, b);

This sometimes triggers warning also with "sizeof(c) - 1" when c is either=
=20
memset before or last byte being explicitly set to '\0' after snprintf.

Also, sometimes we are fine if resulting string is left unterminated eg
when filling in mgmt commands or struct sockaddr with paths and/or names.
Some could be change to memcpy + strlen (possibly after getting min size fr=
om=20
both buffers) or we could adjust buffers to make those go away.



=2DWstringop-truncation
This is pretty match the same as above but for strncpy and family.
Also here, some could be change to memcpy + strlen. Or even better don't us=
e=20
strncpy at all and have own implementation of strlcpy.



=2DWcast-function-type
Warn when a function pointer is cast to an incompatible function pointer.
We often cast function pointers with g_slist_foreach or queue call to avoid
need for having wrappers. This seems to be fine as along as casted function
doesn't expect more parameters than type it is casted to. To fix those we=20
would have to always wrap eg:

+static void update_adapter_cb(gpointer data,  gpointer user_data)
+{
+	struct hdp_adapter *hdp_adapter =3D data;
+
+	update_adapter(hdp_adapter);
+}
+
 static void remove_application(struct hdp_application *app)
 {
 	DBG("Application %s deleted", app->path);
 	hdp_application_unref(app);
=20
=2D	g_slist_foreach(adapters, (GFunc) update_adapter, NULL);
+	g_slist_foreach(adapters, update_adapter_cb, NULL);
 }



=2D-=20
pozdrawiam
Szymon Janc
