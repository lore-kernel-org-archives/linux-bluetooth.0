Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Feb 2011 13:51:30 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] telephony-ofono: reset indicators when a network
 is found
Message-ID: <20110218165130.GA8010@jh-x301>
References: <1298046241-8655-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298046241-8655-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 18, 2011, Luiz Augusto von Dentz wrote:
> Indicators may have invalid values set from the last time they were used
> ---
>  audio/telephony-ofono.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Be careful with the commit message line lengths. The summary line of
your second patch was too long for git log on a 80-character wide
terminal (I fixed this manually).

Johan
