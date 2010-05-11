Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 25/25] Initial support for clock synchronization
 protocol
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20100511055245.GA3252@vigoh>
References: <1273486527-7855-16-git-send-email-sancane@gmail.com>
	 <1273486527-7855-17-git-send-email-sancane@gmail.com>
	 <1273486527-7855-18-git-send-email-sancane@gmail.com>
	 <1273486527-7855-19-git-send-email-sancane@gmail.com>
	 <1273486527-7855-20-git-send-email-sancane@gmail.com>
	 <1273486527-7855-21-git-send-email-sancane@gmail.com>
	 <1273486527-7855-22-git-send-email-sancane@gmail.com>
	 <1273486527-7855-23-git-send-email-sancane@gmail.com>
	 <1273486527-7855-24-git-send-email-sancane@gmail.com>
	 <1273486527-7855-25-git-send-email-sancane@gmail.com>
	 <20100511055245.GA3252@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 May 2010 09:45:02 +0200
Message-ID: <1273563902.2126.26.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

El mar, 11-05-2010 a las 02:52 -0300, Gustavo F. Padovan escribió:
> Ho Santiago,
> 
> * Santiago Carot-Nemesio <sancane@gmail.com> [2010-05-10 12:15:27 +0200]:
> 
> > From: Santiago Carot Nemesio <sancane@gmail.com>
> > 
> > ---
> >  Makefile.am |    4 +-
> >  mcap/mcap.c |    2 +-
> >  mcap/sync.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 87 insertions(+), 3 deletions(-)
> >  create mode 100644 mcap/sync.c
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index 7d8f4b5..98dacdf 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -170,8 +170,8 @@ builtin_sources += plugins/service.c
> >  endif
> >  
> >  if MCAP
> > -mcap_sources += mcap/mcap_lib.h \
> > -		mcap/mcap_internal.h \
> > +mcap_sources += mcap/mcap_internal.h \
> > +		mcap/mcap_lib.h mcap/sync.c \
> >  		mcap/mcap.h mcap/mcap.c
> >  endif
> >  
> > diff --git a/mcap/mcap.c b/mcap/mcap.c
> > index a292dcd..0fd5b97 100644
> > --- a/mcap/mcap.c
> > +++ b/mcap/mcap.c
> > @@ -1500,7 +1500,7 @@ static void rsend_req(struct mcap_mcl *mcl)
> >  static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
> >  {
> >  	if ((cmd[0] >= MCAP_MD_SYNC_CAP_REQ) && (cmd[0] <= MCAP_MD_SYNC_INFO_IND)) {
> > -		send4B_cmd(mcl, cmd[0], MCAP_REQUEST_NOT_SUPPORTED, MCAP_MDLID_RESERVED);
> > +		proc_sync_cmd(mcl, cmd, len);
> >  		return;
> >  	}
> >  
> > diff --git a/mcap/sync.c b/mcap/sync.c
> > new file mode 100644
> > index 0000000..ede125a
> > --- /dev/null
> > +++ b/mcap/sync.c
> > @@ -0,0 +1,84 @@
> > +/*
> > + *
> > + *  MCAP for BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
> > + *
> > + *  Authors:
> > + *  Santiago Carot-Nemesio <sancane at gmail.com>
> > + *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
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
> > +#include <stdint.h>
> > +#include <netinet/in.h>
> > +
> > +#include "logging.h"
> > +
> > +#include "mcap.h"
> > +#include "mcap_lib.h"
> > +#include "mcap_internal.h"
> > +
> > +static int send_unsupported_req(struct mcap_mcl *mcl, uint8_t oc)
> > +{
> > +	uint8_t *rsp;
> > +	mcap4B_rsp *rsp_err;
> > +	int sent;
> > +
> > +
> > +	rsp = g_malloc0(sizeof(mcap4B_rsp));
> > +
> > +	rsp_err = (mcap4B_rsp *)rsp;
> > +	rsp_err->op = oc;
> > +	rsp_err->rc = MCAP_REQUEST_NOT_SUPPORTED;
> > +	rsp_err->mdl = htons (MCAP_MDLID_RESERVED);
> > +
> > +	sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc),
> > +					rsp,
> > +					sizeof(mcap4B_rsp));
> > +	g_free(rsp);
> > +	return sent;
> > +}
> > +
> > +void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
> > +{
> > +	switch (cmd[0]) {
> > +	case MCAP_MD_SYNC_CAP_REQ:
> > +		debug("TODO: received MCAP_MD_SYNC_CAP_REQ: %d",
> > +							MCAP_MD_SYNC_CAP_REQ);
> > +		break;
> > +	case MCAP_MD_SYNC_CAP_RSP:
> > +		debug("TODO: received MCAP_MD_SYNC_CAP_RSP: %d",
> > +							MCAP_MD_SYNC_CAP_RSP);
> > +		break;
> > +	case MCAP_MD_SYNC_SET_REQ:
> > +		debug("TODO: received MCAP_MD_SYNC_SET_REQ: %d",
> > +							MCAP_MD_SYNC_SET_REQ);
> > +		break;
> > +	case MCAP_MD_SYNC_SET_RSP:
> > +		debug("TODO: received MCAP_MD_SYNC_SET_RSP: %d",
> > +							MCAP_MD_SYNC_SET_RSP);
> > +		break;
> > +	case MCAP_MD_SYNC_INFO_IND:
> > +		debug("TODO: received MCAP_MD_SYNC_INFO_IND :%d",
> > +							MCAP_MD_SYNC_INFO_IND);
> > +		break;
> > +	}
> > +
> > +	/* Not implemented yet. Reply with unsupported request */
> > +        send_unsupported_req(mcl, cmd[0]);
> > +}
> 
> How are you thinking to handle the Clock Sync Protocol? It has to sync
> time with other Bluetooth devices, so I guess it needs some real time
> priority to run, doesn't it? Or Am I wrong?
> 
We are starting the work in CSP now. Elvis, Jose and I are thinking
about this issue. We don't have any precise idea yet. Of course, if you
have some ideas it will be pleasure for us to listen it.

Please, feel free to comment it.

Best regards.


