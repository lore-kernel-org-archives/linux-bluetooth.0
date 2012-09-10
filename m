Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Sep 2012 11:24:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/7 v4] client: Add filters to Phonebook.PullAll
Message-ID: <20120910082433.GA29032@x220>
References: <1347264179-31477-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347264179-31477-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Sep 10, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This avoid D-Bus round trips and is more aligned with what has been
> proposed for MessageAccess interface.
> ---
> v3: Fix patch 2/7
> v4: Fix not having an empty line before parse_filter in patch 1/7
> 
>  client/pbap.c | 256 +++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 210 insertions(+), 46 deletions(-)

The whole patch set has been applied. Thanks.

Johan
