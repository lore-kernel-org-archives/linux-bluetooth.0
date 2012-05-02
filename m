Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335799587-10370-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335799587-10370-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Wed, 2 May 2012 14:56:45 +0300
Message-ID: <CABBYNZ+EJqTuhNM6_xQsiKT+PnXVWxQD=ABk=Cx5jnM35uKzhQ@mail.gmail.com>
Subject: Re: [PATCH obexd v1 0/6] client: rethink transfer data access in
 session API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Apr 30, 2012 at 6:26 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> This second version modifies patch v0 2/6 (now v1 3/6 due to new dependency) in order to use one single callback type in session API, according to the proposal from Luiz.
>
> From previous cover letter:
>
> This patch series proposes a change in the session API such that the concept of "active transfer" (session->p) is removed from the API. This is possible once the callbacks provide the pointer to the transfer object, which can be used by the modules to access the data they are interested in.
>
> This transfer object pointer is guaranteed to be valid during the duration of the callback, but nothing else can be assumed. In particular there is no ownership change involved.
>
> The new approach is less error-prone and avoids API duplication between transfer and session APIs.
>
> Mikel Astiz (6):
>  client: Minor buffer access API changes
>  client: Avoid GObex dependency from transfer.h
>  client: Give transfer pointer in session callbacks
>  client: Use new session callback style in modules
>  client: Remove deprecated part of session API
>  client: Remove transfer from queue before callback
>
>  client/driver.c   |    2 +
>  client/ftp.c      |   15 +++++---
>  client/manager.c  |   14 ++++++--
>  client/map.c      |   13 ++++---
>  client/opp.c      |    3 ++
>  client/pbap.c     |   27 +++++++++------
>  client/session.c  |   93 ++++++++++++++--------------------------------------
>  client/session.h  |    4 +--
>  client/sync.c     |    4 ++-
>  client/transfer.c |   14 ++++---
>  client/transfer.h |    8 ++--
>  11 files changed, 89 insertions(+), 108 deletions(-)
>
> --
> 1.7.7.6

I reviewed and did some testing but when I was about to apply them I
noticed that your email has changed after 1/6, could you please fix
that?


-- 
Luiz Augusto von Dentz
