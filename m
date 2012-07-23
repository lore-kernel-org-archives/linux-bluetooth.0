Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jul 2012 23:33:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] time: fix byte position
Message-ID: <20120723213349.GA14491@x220>
References: <20120719145519.GA3879@x220.P-661HNU-F1>
 <1342719992-3816-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1342719992-3816-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Thu, Jul 19, 2012, João Paulo Rechi Vita wrote:
> The position of the "Time Zone" and "Daylight Saving Time" fields on
> the Local Time Information characteristic was inverted. This commit
> fix their position.
> ---
>  profiles/time/server.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
