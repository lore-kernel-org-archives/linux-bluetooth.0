Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Jul 2013 21:45:15 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] audio/AVRCP: Rework role detection
Message-ID: <20130724044515.GB14367@x220.p-661hnu-f1>
References: <1374583952-16361-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374583952-16361-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jul 23, 2013, Luiz Augusto von Dentz wrote:
> This makes AVRCP agnostic to any roles so the same session can be used
> both for controller and target role.
> ---
>  profiles/audio/avrcp.c | 427 +++++++++++++++++++++++++------------------------
>  1 file changed, 219 insertions(+), 208 deletions(-)

All four patches have been applied. Thanks.

Johan
