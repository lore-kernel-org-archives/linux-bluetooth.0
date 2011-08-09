Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC v2 2/2] Add external dummy plugin for testing
Date: Tue, 9 Aug 2011 12:39:13 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "par-gunnar.p.hjalmdahl@stericsson.com" <par-gunnar.p.hjalmdahl@stericsson.com>,
 "ulrik.lauren@stericsson.com" <ulrik.lauren@stericsson.com>
References: <1312385452-9770-1-git-send-email-szymon.janc@tieto.com> <1312385452-9770-3-git-send-email-szymon.janc@tieto.com> <1312714596.3373.66.camel@aeonflux>
In-Reply-To: <1312714596.3373.66.camel@aeonflux>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108091239.14085.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Szymon,
> 
> >  Makefile.am              |    9 +++++++++
> >  acinclude.m4             |    6 ++++++
> >  plugins/external-dummy.c |   42 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 57 insertions(+), 0 deletions(-)
> >  create mode 100644 plugins/external-dummy.c
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index 083ad27..b51f82e 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -48,6 +48,8 @@ endif
> >  plugindir = $(libdir)/bluetooth/plugins
> >  
> >  plugin_LTLIBRARIES =
> > +plugin_LDFLAGS = -module -avoid-version -Wl,--export-dynamic \
> > +			-Wl,-u__start___debug -Wl,-u__stop___debug
> 
> this part is a bit ugly. I wish we could automate it.
> 
> And what does actually take care of bluetooth_plugin_desc since that is
> suppose to be the only exported symbol in the first place.

As explained in last email, this could be automated with some trigger function
that would dereference those pointer. With combination with 
__attribute__((constructor/destructor)) this could be quite automatic..
I'll investigate this and send V3 shortly.

> >  lib_headers = lib/bluetooth.h lib/hci.h lib/hci_lib.h lib/mgmt.h \
> > @@ -258,6 +260,13 @@ builtin_modules += dbusoob
> >  builtin_sources += plugins/dbusoob.c
> >  endif
> >  
> > +if EXTERNALDUMMYPLUGIN
> > +plugin_LTLIBRARIES += plugins/external-dummy.la
> > +plugins_external_dummy_la_SOURCES = plugins/external-dummy.c
> > +plugins_external_dummy_la_LDFLAGS = $(plugin_LDFLAGS)
> > +plugins_external_dummy_la_CFLAGS = -fvisibility=hidden
> > +endif
> > +
> >  sbin_PROGRAMS += src/bluetoothd
> >  
> >  src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
> > diff --git a/acinclude.m4 b/acinclude.m4
> > index 3cb9459..737c000 100644
> > --- a/acinclude.m4
> > +++ b/acinclude.m4
> > @@ -216,6 +216,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
> >  	dbusoob_enable=no
> >  	wiimote_enable=no
> >  	thermometer_enable=no
> > +	external_dummy_enable=no
> >  
> >  	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
> >  		optimization_enable=${enableval}
> > @@ -364,6 +365,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
> >  		thermometer_enable=${enableval}
> >  	])
> >  
> > +	AC_ARG_ENABLE(external_dummy, AC_HELP_STRING([--enable-external-dummy], [enable sample external plugin]), [
> > +		external_dummy_enable=${enableval}
> > +	])
> > +
> 
> Please don't. This project has already too many configure options. Just
> use if MAINTAINER_MODE in Makefile.am.

OK.

> 
> >  	if (test "${fortify_enable}" = "yes"); then
> >  		CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=2"
> >  	fi
> > @@ -421,4 +426,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
> >  	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
> >  	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
> >  	AM_CONDITIONAL(THERMOMETERPLUGIN, test "${thermometer_enable}" = "yes")
> > +	AM_CONDITIONAL(EXTERNALDUMMYPLUGIN, test "${external_dummy_enable}" = "yes")
> >  ])
> > diff --git a/plugins/external-dummy.c b/plugins/external-dummy.c
> > new file mode 100644
> > index 0000000..ff4608b
> > --- /dev/null
> > +++ b/plugins/external-dummy.c
> > @@ -0,0 +1,42 @@
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include "plugin.h"
> > +#include "log.h"
> > +
> > +static int dummy_init(void)
> > +{
> > +	DBG("");
> > +
> > +	return 0;
> > +}
> > +
> > +static void dummy_exit(void)
> > +{
> > +	DBG("");
> > +}
> > +
> > +BLUETOOTH_PLUGIN_DEFINE(external_dummy, VERSION,
> > +		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, dummy_init, dummy_exit)
> > +
> 
> Just to be paranoid, make it PRIORITY_LOW ;)

OK :)
