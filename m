Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329230829-27046-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329230829-27046-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 16 Feb 2012 10:01:00 +0200
Message-ID: <CABBYNZ+5gBhETm94QKPCHDEiBzVsZOtCXx=oCqrpVt=2MZ7=Mg@mail.gmail.com>
Subject: Re: [PATCH obexd v2 0/6] Several minor fixes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 14, 2012 at 4:47 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> This second series includes the patches acked in the previous proposal (patches 1, 4, 5, 6) and the reviewed patches 2 and 3.
>
> Patch 2 now considers the possibility of unreferencing the session inside the transfer callback.
>
> Patch 3 now follows more strictly the glib convention on error reporting parameters.
>
> Mikel Astiz (6):
>  client: fix memory leak in obc_session_put
>  client: fix unreported error case
>  client: fix incorrect error check
>  client: fix pbap select when same path given twice
>  client: queue transfers in ftp sessions
>  client: queue transfers in pbap sessions
>
>  client/ftp.c     |   39 ++++---------
>  client/pbap.c    |  176 ++++++++++++++++++++++++------------------------------
>  client/session.c |   22 ++++++-
>  3 files changed, 109 insertions(+), 128 deletions(-)
>
> --
> 1.7.6.5

Ack

-- 
Luiz Augusto von Dentz
