Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Dec 2010 01:10:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove bt_discover_services function from glib-helper
Message-ID: <20101220231024.GA7423@jh-x301>
References: <1292886362-19755-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292886362-19755-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Mon, Dec 20, 2010, Sheldon Demario wrote:
> There is no reference in the code for this function. SDP discovery in
> the bluetoothd core and plugins are now using bt_search_service only.
> ---
>  src/glib-helper.c |   10 ----------
>  src/glib-helper.h |    3 ---
>  2 files changed, 0 insertions(+), 13 deletions(-)

Pushed upstream. Thanks.

Johan
