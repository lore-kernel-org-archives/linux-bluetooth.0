Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 20 Nov 2012 13:47:20 +0200
Message-ID: <CABBYNZKh3x73rS1ph4-u9iJ1C65_af_bmNvGvkQ1P7DRtiZY4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Adopt btd_profile for A2DP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Nov 15, 2012 at 9:27 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The proposal is to split A2DP roles into different btd_profile instances, in order to expose .connect and .disconnect.
>
> The changes in v2 include:
>
> - Renaming of functions as suggested by Luiz (avoid using local_xxx)
> - Merge of source_shutdown and source_disconnect: they were quite similar and having a generalized function seems a better idea (to be discussed if we can get rid of the gboolean shutdown parameter)
> - New patches have been added to address the sink part as well (v1 focused on the source role)
>
> Mikel Astiz (8):
>   audio: Trivial function renames
>   sink: Generalize disconnection function
>   source: Add missing code in source_disconnect()
>   source: Expose internal connection API
>   sink: Expose internal connection API
>   audio: Split A2DP into three btd_profile
>   source: Add profile .connect and .disconnect
>   sink: Add profile .connect and .disconnect
>
>  profiles/audio/a2dp.c    |  88 ++++++++---------
>  profiles/audio/a2dp.h    |   4 +-
>  profiles/audio/device.c  |   4 +-
>  profiles/audio/device.h  |   3 +
>  profiles/audio/manager.c | 242 +++++++++++++++++++++++++++++++++++++++++++----
>  profiles/audio/sink.c    | 179 ++++++++++++++++++-----------------
>  profiles/audio/sink.h    |   4 +-
>  profiles/audio/source.c  | 189 ++++++++++++++++++++----------------
>  profiles/audio/source.h  |   4 +-
>  9 files changed, 480 insertions(+), 237 deletions(-)
>
> --
> 1.7.11.7

First 5 patches are now pushed, I had to changed sink_disconnect and
source_disconnect since they were crashing. Please rebase the rest and
reasend.


--
Luiz Augusto von Dentz
