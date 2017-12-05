Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 5 Dec 2017 14:54:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] mesh: Make meshctl use bt_shell helpers
Message-ID: <20171205125448.GA19933@x1c.lan>
References: <20171205124717.30965-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171205124717.30965-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 05, 2017, Luiz Augusto von Dentz wrote:
> This makes meshctl use bt_shell to manage the menus and command
> handling.
> ---
>  mesh/config-client.c | 187 ++++++++---------
>  mesh/config-model.h  |   1 -
>  mesh/main.c          | 571 +++++++++++++++------------------------------------
>  mesh/onoff-model.c   |  88 +++-----
>  mesh/util.c          | 155 +-------------
>  mesh/util.h          |  16 +-
>  6 files changed, 278 insertions(+), 740 deletions(-)

This one seems to work fine, so feel free to merge it if you're
otherwise happy with it.

Johan
