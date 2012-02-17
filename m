Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 16:27:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v4 0/6] Several minor fixes
Message-ID: <20120217142746.GA5494@x220>
References: <1329483336-25853-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329483336-25853-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Feb 17, 2012, Mikel Astiz wrote:
> This fourth version fixes some style-issues (patches 2 and 3) and
> removes a potential warning due to a missing 'static' keyword.
> 
> Mikel Astiz (6):
>   client: fix memory leak in obc_session_put
>   client: fix unreported error case
>   client: fix incorrect error check
>   client: fix pbap select when same path given twice
>   client: queue transfers in ftp sessions
>   client: queue transfers in pbap sessions
> 
>  client/ftp.c     |   39 ++++---------
>  client/pbap.c    |  176 ++++++++++++++++++++++++------------------------------
>  client/session.c |   23 ++++++-
>  3 files changed, 109 insertions(+), 129 deletions(-)

All patches in this set have now been applied. Thanks.

Johan
