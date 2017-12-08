Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 8 Dec 2017 13:10:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 01/10] shared/shell: Omit menu command if there are no
 submenus
Message-ID: <20171208111041.GA12008@x1c.lan>
References: <20171208105256.18635-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208105256.18635-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Dec 08, 2017, Luiz Augusto von Dentz wrote:
> There is no need to show menu as a command if there are no submenus
> to select.
> ---
>  src/shared/shell.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

I went ahead and applied the whole set now, since at least some basic
tests I did work fine. I hope you've done thorough testing yourself as
well, considering that we're about to tag a new release?

Johan
