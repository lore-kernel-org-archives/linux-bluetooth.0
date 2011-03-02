Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
References: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
Date: Wed, 2 Mar 2011 18:12:56 -0300
Message-ID: <AANLkTikGvm5bjwyypJA6Pb47QmBcE1677dJdGQxo+3G7@mail.gmail.com>
Subject: Re: [PATCH 0/4] Message Access Profile plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: lkslawek@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 2, 2011 at 6:36 AM,  <lkslawek@gmail.com> wrote:
> These are the first ones of upcoming series of patches implementing Message
> Access Profile (server role) in obexd.
>
> The work is more than less complete (~4k lines now), but as advised by Johan,
> I'm cutting the whole thing into smaller pieces before sending this here.
>
> Regards,
> Slawomir Bochenski
>
>  .gitignore               |    1 +
>  Makefile.am              |   10 ++-
>  configure.ac             |   12 ++
>  plugins/mas.c            |  338 ++++++++++++++++++++++++++++++++++++++++++++++
>  plugins/messages-dummy.c |   28 ++++
>  plugins/messages.h       |   37 +++++
>  src/main.c               |   11 ++-
>  src/obex.h               |    1 +
>  8 files changed, 435 insertions(+), 3 deletions(-)

I guess naming the file and plugin 'map' would make more sense here,
we don't want to confuse people what this file is about.

Also Ive been thinking on removing this internal APIs for backend,
each would implemented as plugin/mimetype driver directly and we can
create basic drivers for pbap and map and export its callbacks on
pbap.h and map.h respectively as we do for pcsuite which uses ftp
driver callbacks.

-- 
Luiz Augusto von Dentz
Computer Engineer
