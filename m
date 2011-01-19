Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 20:36:26 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request
 git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
Message-ID: <20110119150626.GA2112@jh-x301>
References: <AANLkTikmELbxWrZkTe_9UcK0q01cwJoQsmFkMzppsEtV@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikmELbxWrZkTe_9UcK0q01cwJoQsmFkMzppsEtV@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jan 19, 2011, Luiz Augusto von Dentz wrote:
> The following changes since commit effe770cd43cf53fa5842291941dbfc82beab645:
> 
>   Use -DG_DISABLE_DEPRECATED compiler define (2011-01-18 14:56:31 +0100)
> 
> are available in the git repository at:
>   git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
> 
> Luiz Augusto von Dentz (7):
>       Fix use of deprecated glib on audio plugin
>       Fix use of deprecated glib on input plugin
>       Fix use of deprecated glib on network plugin
>       Fix use of deprecated glib on serial plugin
>       Fix use of deprecated glib on hciops plugin
>       Fix use of deprecated glib on core
>       Fix use of deprecated glib on tests
> 
>  audio/avdtp.c        |   10 ++-
>  audio/gstavdtpsink.c |  162 +++++++++++++++++++++++++-------------------------
>  audio/headset.c      |   13 +++--
>  audio/unix.c         |    2 +-
>  input/device.c       |   12 +++-
>  input/fakehid.c      |   10 ++-
>  network/connection.c |   14 ++--
>  plugins/hciops.c     |   24 ++++---
>  serial/proxy.c       |   40 ++++++------
>  src/rfkill.c         |   11 ++--
>  src/storage.c        |    2 +-
>  test/hciemu.c        |   15 +++--
>  12 files changed, 168 insertions(+), 147 deletions(-)

All patches have been pushed upstream. Thanks.

Johan
