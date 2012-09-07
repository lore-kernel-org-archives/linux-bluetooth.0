Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Sep 2012 13:23:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v5 04/14] core: Add a list of LE devices to connect
Message-ID: <20120907102314.GA9130@x220>
References: <1346785482-13359-1-git-send-email-jprvita@openbossa.org>
 <1346785482-13359-5-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1346785482-13359-5-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 04, 2012, João Paulo Rechi Vita wrote:
> This commit creates a per-adapter list of LE devices to connect when a
> advertising from them is seen during a scan.
> ---
>  src/adapter.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/adapter.h |  5 +++++
>  2 files changed, 63 insertions(+), 1 deletion(-)

I applied patches 2-4 as they didn't seem to directly depend on the
first one. So no need to resend those when resending this patch set.

Johan
