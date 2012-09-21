Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 16:39:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Rafal Garbat <rafal.garbat@tieto.com>
Subject: Re: [PATCH v6 07/13] heartrate: Add HeartRateManager interface
Message-ID: <20120921133916.GB16944@x220>
References: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1348139690-26985-8-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348139690-26985-8-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Sep 20, 2012, Andrzej Kaczmarek wrote:
> This patch adds support for org.bluez.HeartRateManager interface on adapters
> which allows to register and unregister per-adapter watcher.
> ---
>  profiles/heartrate/heartrate.c | 154 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 153 insertions(+), 1 deletion(-)

This one will need to be redone due to the btd_get_dbus_connection
patches that went in.

Also, please go through all your commit messages and ensure that your
line widths are less than 74 (the summary line needs to be max 72 due to
"git shortlog" indenting by 8 characters so for simplicity you could
just configure your editor to use 72 for all commit messages).

Johan
