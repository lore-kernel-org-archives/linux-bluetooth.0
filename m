Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Aug 2010 11:05:36 +0200
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2nd version] IrMC sync server support
Message-ID: <20100813090536.GA13045@joshua.mesa.nl>
References: <201008122116.o7CLGo4p017361@joshua.mesa.nl> <AANLkTimSBnkvoN1x-Ak3Vgk8GNHFjTxoRJmQTV+3ZRys@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTimSBnkvoN1x-Ak3Vgk8GNHFjTxoRJmQTV+3ZRys@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 13, 2010 at 10:03:35AM +0300, Luiz Augusto von Dentz wrote:
> Hi Marcel,
> 
> On Fri, Aug 13, 2010 at 12:09 AM, Marcel Mol <marcel@mesa.nl> wrote:
> > A reasonable working IrMC SYNC server (only full phonebook sync support)
> > Support for cal and note by just returning nothing.
> > ---
> >  Makefile.am    |    3 +
> >  plugins/irmc.c |  507 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/main.c     |   10 +-
> >  src/obex.h     |    3 +-
> >  4 files changed, 521 insertions(+), 2 deletions(-)
> >  create mode 100644 plugins/irmc.c
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 73e2f28..a2873f9 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -55,6 +55,9 @@ builtin_modules += pbap
> >  builtin_sources += plugins/pbap.c plugins/phonebook.h \
> >                        plugins/vcard.h plugins/vcard.c
> >
> > +builtin_modules += irmc
> > +builtin_sources += plugins/irmc.c plugins/phonebook.h
> > +
> 
> I guess we don't need phonebook.h, it is already listed in
> builtin-sources before.

Yes, I saw that too, but I think Makefile.am can be optimized even more.
I guess phonebook.h should not be mentioned at the pbabp line either,
but later on at the phonebook.c inclusion.
Also the vcard.h and vcard.h have 'nothing' to do with pbap. The exported
functions from those files are only used by phonebook-tracker...

I intended to file a Makfile.am patch later on....

But I made a few extra changes here so will create a new patch for IrMC
fixing the IrMC makefele.am part  (and will nclude the name is NULL check
you mentioned below).

> 
> >  builtin_modules += syncevolution
> >  builtin_sources += plugins/syncevolution.c
> >
> > diff --git a/plugins/irmc.c b/plugins/irmc.c
> > new file mode 100644
> > index 0000000..fa7f91d
> > --- /dev/null
> > +++ b/plugins/irmc.c
> > @@ -0,0 +1,507 @@
> > +/*
> > + *
> > + *  OBEX IrMC Sync Server
> > + *
> > + *  Copyright (C) 2010  Marcel Mol <marcel@mesa.nl>
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <glib.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <arpa/inet.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +
> > +#include <openobex/obex.h>
> > +#include <openobex/obex_const.h>
> > +
> > +#include "plugin.h"
> > +#include "log.h"
> > +#include "obex.h"
> > +#include "service.h"
> > +#include "phonebook.h"
> > +#include "mimetype.h"
> > +#include "filesystem.h"
> > +#include "dbus.h"
> > +
> > +#define IRMC_CHANNEL   17
> > +
> > +#define IRMC_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>       \
> > +<record>                                                               \
> > +  <attribute id=\"0x0001\">                                            \
> > +    <sequence>                                                         \
> > +      <uuid value=\"0x1104\"/>                                         \
> > +    </sequence>                                                                \
> > +  </attribute>                                                         \
> > +                                                                       \
> > +  <attribute id=\"0x0004\">                                            \
> > +    <sequence>                                                         \
> > +      <sequence>                                                       \
> > +        <uuid value=\"0x0100\"/>                                       \
> > +      </sequence>                                                      \
> > +      <sequence>                                                       \
> > +        <uuid value=\"0x0003\"/>                                       \
> > +        <uint8 value=\"%u\" name=\"channel\"/>                         \
> > +      </sequence>                                                      \
> > +      <sequence>                                                       \
> > +        <uuid value=\"0x0008\"/>                                       \
> > +      </sequence>                                                      \
> > +    </sequence>                                                                \
> > +  </attribute>                                                         \
> > +                                                                       \
> > +  <attribute id=\"0x0009\">                                            \
> > +    <sequence>                                                         \
> > +      <sequence>                                                       \
> > +        <uuid value=\"0x1104\"/>                                       \
> > +        <uint16 value=\"0x0100\" name=\"version\"/>                    \
> > +      </sequence>                                                      \
> > +    </sequence>                                                                \
> > +  </attribute>                                                         \
> > +                                                                       \
> > +  <attribute id=\"0x0100\">                                            \
> > +    <text value=\"%s\" name=\"name\"/>                                 \
> > +  </attribute>                                                         \
> > +                                                                       \
> > +  <attribute id=\"0x0301\">                                            \
> > +    <sequence>                                                         \
> > +      <uint8 value=\"0x01\"/>                                          \
> > +    </sequence>                                                                \
> > +  </attribute>                                                         \
> > +</record>"
> > +
> > +
> > +struct aparam_header {
> > +       uint8_t tag;
> > +       uint8_t len;
> > +       uint8_t val[0];
> > +} __attribute__ ((packed));
> > +
> > +#define DID_LEN 18
> > +
> > +struct irmc_session {
> > +       struct obex_session *os;
> > +       struct apparam_field *params;
> > +       uint16_t entries;
> > +       GString *buffer;
> > +       char sn[DID_LEN];
> > +       char did[DID_LEN];
> > +       char manu[DID_LEN];
> > +       char model[DID_LEN];
> > +};
> > +
> > +#define IRMC_TARGET_SIZE 9
> > +
> > +static const guint8 IRMC_TARGET[IRMC_TARGET_SIZE] = {
> > +                       0x49, 0x52, 0x4d, 0x43,  0x2d, 0x53, 0x59, 0x4e, 0x43 };
> > +
> > +/*
> > + * FIXME:
> > + * the IrMC specs state the first vcard should be the owner
> > + * vcard. As there is no simple way to collect ownerdetails
> > + * just create an empty vcard (which is allowed according to the
> > + * specs).
> > + */
> > +static const char *owner_vcard =
> > +               "BEGIN:VCARD\r\n"
> > +               "VERSION:2.1\r\n"
> > +               "N:\r\n"
> > +               "TEL:\r\n"
> > +               "X-IRMX-LUID:0\r\n"
> > +               "END:VCARD\r\n";
> > +
> > +static void phonebook_size_result(const char *buffer, size_t bufsize,
> > +                               int vcards, int missed, void *user_data)
> > +{
> > +       struct irmc_session *irmc = user_data;
> > +
> > +       DBG("vcards %d", vcards);
> > +
> > +       irmc->params->maxlistcount = vcards;
> > +}
> > +
> > +static void query_result(const char *buffer, size_t bufsize, int vcards,
> > +                                       int missed, void *user_data)
> > +{
> > +       struct irmc_session *irmc = user_data;
> > +       const char *s, *t;
> > +
> > +       DBG("bufsize %d vcards %d missed %d", bufsize, vcards, missed);
> > +
> > +       /* first add a 'owner' vcard */
> > +       if (!irmc->buffer)
> > +               irmc->buffer = g_string_new(owner_vcard);
> > +       else
> > +               irmc->buffer = g_string_append(irmc->buffer, owner_vcard);
> > +
> > +       /* loop around buffer and add X-IRMC-LUID attribs */
> > +       s = buffer;
> > +       while ((t = strstr(s, "UID:")) != NULL) {
> > +               /* add upto UID: into buffer */
> > +               irmc->buffer = g_string_append_len(irmc->buffer, s, t-s);
> > +               /*
> > +                * add UID: line into buffer
> > +                * Not sure if UID is still needed if X-IRMC-LUID is there
> > +                */
> > +               s = t;
> > +               t = strstr(s, "\r\n");
> > +               t += 2;
> > +               irmc->buffer = g_string_append_len(irmc->buffer, s, t-s);
> > +               /* add X-IRMC-LUID with same number as UID */
> > +               irmc->buffer = g_string_append_len(irmc->buffer,
> > +                                                       "X-IRMC-LUID:", 12);
> > +               s += 4; /* point to uid number */
> > +               irmc->buffer = g_string_append_len(irmc->buffer, s, t-s);
> > +               s = t;
> > +       }
> > +       /* add remaining bit of buffer */
> > +       irmc->buffer = g_string_append(irmc->buffer, s);
> > +
> > +       obex_object_set_io_flags(irmc, G_IO_IN, 0);
> > +}
> > +
> > +static void *irmc_connect(struct obex_session *os, int *err)
> > +{
> > +       struct irmc_session *irmc;
> > +       struct apparam_field *param;
> > +
> > +       DBG("");
> > +
> > +       manager_register_session(os);
> > +
> > +       irmc = g_new0(struct irmc_session, 1);
> > +       irmc->os = os;
> > +
> > +       /*
> > +        * FIXME:
> > +        * Ideally get capabilities info here and use that to define
> > +        * IrMC DID and SN etc parameters.
> > +        * For now lets used hostname and some 'random' value
> > +        */
> > +       gethostname(irmc->did, DID_LEN);
> > +       strncpy(irmc->sn, "12345", DID_LEN);
> > +       strncpy(irmc->manu, "obex", DID_LEN);
> > +       strncpy(irmc->model, "mymodel", DID_LEN);
> > +
> > +       /*
> > +         *  We need to know the number of contact/cal/nt entries
> > +         *  somewhere so why not do it now.
> > +         */
> > +       param = g_new0(struct apparam_field, 1);
> > +       param->maxlistcount = 0; /* to count the number of vcards... */
> > +       param->filter = 0x200085; /* UID TEL N VERSION */
> > +       irmc->params = param;
> > +       phonebook_pull("telecom/pb.vcf", irmc->params, phonebook_size_result,
> > +                                                                       irmc);
> > +
> > +       if (err)
> > +               *err = 0;
> > +
> > +       return irmc;
> > +}
> > +
> > +static int irmc_get(struct obex_session *os, obex_object_t *obj,
> > +               gboolean *stream, void *user_data)
> > +{
> > +       struct irmc_session *irmc = user_data;
> > +       const char *type = obex_get_type(os);
> > +       const char *name = obex_get_name(os);
> > +       char *path;
> > +       int ret;
> > +
> > +       DBG("name %s type %s irmc %p", name, type ? type : "NA", irmc);
> > +
> > +       path = g_strdup(name);
> > +       *stream = TRUE;
> > +
> > +       ret = obex_get_stream_start(os, path);
> > +
> > +       g_free(path);
> > +
> > +       return ret;
> > +}
> > +
> > +static void irmc_disconnect(struct obex_session *os, void *user_data)
> > +{
> > +       struct irmc_session *irmc = user_data;
> > +
> > +       DBG("");
> > +
> > +       manager_unregister_session(os);
> > +
> > +        if (irmc->params) {
> > +                if (irmc->params->searchval)
> > +                       g_free(irmc->params->searchval);
> > +                g_free(irmc->params);
> > +        }
> > +       if (irmc->buffer) {
> > +               string_free(irmc->buffer);
> > +               irmc->buffer = NULL;
> > +       }
> > +
> > +       g_free(irmc);
> > +}
> > +
> > +static int irmc_chkput(struct obex_session *os, void *user_data)
> > +{
> > +       DBG("");
> > +       /* Reject all PUTs */
> > +       return -EBADR;
> > +}
> > +
> > +static void *irmc_open_devinfo(struct irmc_session *irmc, int *err)
> > +{
> > +       if (!irmc->buffer)
> > +               irmc->buffer = g_string_new("");
> > +
> > +       g_string_append_printf(irmc->buffer,
> > +                               "MANU:%s\r\n"
> > +                               "MOD:%s\r\n"
> > +                               "SN:%s\r\n"
> > +                               "PB-TYPE-TX:VCARD2.1\r\n",
> > +                               irmc->manu, irmc->model, irmc->sn);
> > +
> > +       return irmc;
> > +}
> > +
> > +static void *irmc_open_pb(const char *name,
> > +                struct irmc_session *irmc, int *err)
> > +{
> > +       GString *mybuf;
> > +       int ret;
> > +
> > +       if (!g_strcmp0(name, ".vcf")) {
> > +               /* how can we tell if the vcard count call already finished? */
> > +               ret = phonebook_pull("telecom/pb.vcf", irmc->params,
> > +                                                       query_result, irmc);
> > +               if (ret < 0) {
> > +                       DBG("phonebook_pull failed...");
> > +                       goto fail;
> > +               }
> > +               return irmc;
> > +       }
> > +
> > +       if (!g_strcmp0(name, "/info.log")) {
> > +               mybuf = g_string_new("");
> > +               g_string_printf(mybuf, "Total-Records:%d\r\n"
> > +                               "Maximum-Records:%d\r\n"
> > +                               "DID:%s\r\n",
> > +                               irmc->params->maxlistcount,
> > +                               irmc->params->maxlistcount, irmc->did);
> > +       }
> > +       else if (!strncmp(name, "/luid/", 6)) {
> > +               name += 6;
> > +               if (!g_strcmp0(name, "cc.log")) {
> > +                       mybuf = g_string_new("");
> > +                       g_string_printf(mybuf, "%d\r\n", irmc->params->maxlistcount);
> > +               }
> > +               else {
> > +                       int l = strlen(name);
> > +                       /* FIXME:
> > +                        * Reply the same to any *.log so we hopefully force a
> > +                        * full phonebook dump.
> > +                        * Is IEL:2 ok?
> > +                        */
> > +                       if (l > 4 && !g_strcmp0(name + l - 4, ".log")) {
> > +                               DBG("changelog request, force whole book");
> > +                               mybuf = g_string_new("");
> > +                               g_string_printf(mybuf, "SN:%s\r\n"
> > +                                                       "IEL:2\r\n"
> > +                                                       "DID:%s\r\n"
> > +                                                       "Total-Records:%d\r\n"
> > +                                                       "Maximum-Records:%d\r\n"
> > +                                                       "*\r\n",
> > +                                               irmc->sn, irmc->did,
> > +                                               irmc->params->maxlistcount,
> > +                                               irmc->params->maxlistcount);
> > +                       }
> > +                       else {
> > +                               ret = -EBADR;
> > +                               goto fail;
> > +                       }
> > +               }
> > +       }
> > +       else {
> > +               ret = -EBADR;
> > +               goto fail;
> > +       }
> > +
> > +       if (!irmc->buffer)
> > +               irmc->buffer = mybuf;
> > +       else {
> > +               irmc->buffer = g_string_append(irmc->buffer, mybuf->str);
> > +               string_free(mybuf);
> > +       }
> > +
> > +       return irmc;
> > +
> > +fail:
> > +       if (err)
> > +               *err = ret;
> > +
> > +       return NULL;
> > +}
> > +
> > +static void *irmc_open_cal(const char *name,
> > +                struct irmc_session *irmc, int *err)
> > +{
> > +       /* no suport yet. Just return an empty buffer. cal.vcs */
> > +       DBG("unsupported, returning empty buffer");
> > +       if (!irmc->buffer)
> > +               irmc->buffer = g_string_new("");
> > +
> > +       return irmc;
> > +}
> > +
> > +static void *irmc_open_nt(const char *name,
> > +                struct irmc_session *irmc, int *err)
> > +{
> > +       /* no suport yet. Just return an empty buffer. nt.vnt */
> > +       DBG("unsupported, returning empty buffer");
> > +       if (!irmc->buffer)
> > +               irmc->buffer = g_string_new("");
> > +
> > +       return irmc;
> > +}
> > +
> > +static void *irmc_open(const char *name, int oflag, mode_t mode,
> > +               void *context, size_t *size, int *err)
> > +{
> > +       struct irmc_session *irmc = context;
> > +       int ret;
> > +       const char *p;
> > +
> > +       DBG("name %s context %p", name, context);
> > +       if (oflag != O_RDONLY) {
> > +               ret = -EPERM;
> > +               goto fail;
> > +       }
> 
> Since Ive seen this many times we better put a check for NULL name
> here otherwise it may crash in the following line.
> 
> > +       if (strncmp(name, "telecom/", 8) != 0) {
> > +               ret = -EBADR;
> > +               goto fail;
> > +       }
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
> Computer Engineer

-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
