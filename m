Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Jun 2013 11:49:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH 1/9] adapter: fix setting of discoverable timeout
Message-ID: <20130617084930.GA15980@x220>
References: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jun 11, 2013, Gustavo Padovan wrote:
> The mgmt_cp_set_discoverable struct was getting reset for no reason after
> we set up the discoverable timeout value.
> ---
>  src/adapter.c | 3 ---
>  1 file changed, 3 deletions(-)

The first four patches have been applied. For the rest we'll wait until
after the next BlueZ release. Thanks.

Johan
