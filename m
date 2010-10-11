Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Oct 2010 22:36:18 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request
 git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
Message-ID: <20101011213618.GA12650@jh-x301>
References: <AANLkTikWCgaXMyRZcpKAsZq19-NzPD_U7YpA=_cFtFQX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikWCgaXMyRZcpKAsZq19-NzPD_U7YpA=_cFtFQX@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 11, 2010, Luiz Augusto von Dentz wrote:
> The following changes since commit 646f0c7e6b557c5413825ce7b04bee52bf0129e8:
> 
>   Move remote name and version requests to hciops (2010-10-10 22:44:25 +0100)
> 
> are available in the git repository at:
>   git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
> 
> Luiz Augusto von Dentz (8):
>       Fix not always signalling new streams when acting as a sink
>       Fix not replying an error in case of endpoint request timeout
>       Add source if the device attempt to configure a stream with a local sink
>       Make use of avdtp category when setting errors
>       Fix blocking on setconf confirmation callback
>       Fix blocking on setconf indication callback
>       Fix blocking when calling endpoint on hsp/hfp connection
>       Remove unused code
> 
>  audio/a2dp.c   |  239 ++++++++++++++++++++++++++++++++++++++++----------------
>  audio/avdtp.c  |  117 ++++++++++++++++++----------
>  audio/avdtp.h  |   19 +++--
>  audio/media.c  |   54 +++++--------
>  audio/sink.c   |    4 +-
>  audio/source.c |    4 +-
>  6 files changed, 281 insertions(+), 156 deletions(-)

Thanks. The patches have been pushed upstream.

Johan
