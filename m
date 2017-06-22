Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 22 Jun 2017 09:18:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Matias Karhumaa <matias.karhumaa@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] obexd: Fix null pointer dereference.
Message-ID: <20170622061810.GA30856@x1c.home>
References: <20170621061358.GA17661@makarhum-e6330>
 <20170621094148.GA27878@x1c>
 <CABBYNZLfN-u0xOqut3f35jaX5xRwusY5SW0oL1M_XzOF283oLQ@mail.gmail.com>
 <CABBYNZJOO+v0FHh2F65iMk6kDZedwG2bOXRn5Ycr4uu=qx9NHw@mail.gmail.com>
 <20170622043241.GA31744@makarhum-e6330>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170622043241.GA31744@makarhum-e6330>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matias,

On Thu, Jun 22, 2017, Matias Karhumaa wrote:
> > >> It seems to me that the bug is with opp.c passing the service_data to
> > >> manager_request_authorization(), and service_data is expected to be the
> > >> obex_transfer object. However, currently the code creates this object
> > >> only upon CONNECT (in opp_connect).
> > >>
> > >> I think one possible way to solve this would be to trigger a call to
> > >> os->service->connect if CONNECT hasn't been explicitly issued, however
> > >> then the code needs to track this in some other way since service_data
> > >> seems too unreliable.
> > 
> > How about the following:
> > 
> > https://gist.github.com/Vudentz/1736d6af9608b9332b93858d92a3feff
> 
> Your fix seems solid to me and fixes the crash with OPP. I checked ftp.c
> also and saw potentially similar problem in ftp_chkput. Should we call
> os->service->connect also in case of OBEX_FTP?

OPP is the only service where the specification allows skipping the
connect step. This is why os->service gets pre-initialized to OPP (in
the obex_session_start function). Also, if the OPP plugin isn't
available os->service will be NULL before CONNECT, and that's something
the code already seems to check for (e.g. in cmd_put). So unless I've
misunderstood something, you shouldn't be able get to a situation where
os->service points at FTP but CONNECT hasn't been issued.

Johan
