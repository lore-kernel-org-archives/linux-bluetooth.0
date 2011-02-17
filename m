Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 15:45:44 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix not responding to pbap GET when data is
 already cached
Message-ID: <20110217184544.GA18025@jh-x301>
References: <1297932809-3460-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297932809-3460-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Feb 17, 2011, Luiz Augusto von Dentz wrote:
> When data is cached but no stream/body is set the driver .write is never
> called so no response is generated.
> ---
>  src/obex.c |   35 +++++++++++++++--------------------
>  1 files changed, 15 insertions(+), 20 deletions(-)

Thanks. Both patches have been pushed upstream.

Johan
