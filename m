Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Nov 2010 14:59:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3 v2] Fix not canceling pending calls on maemo6
 telephony driver exit
Message-ID: <20101130125928.GA11000@jh-x301>
References: <1291120709-20658-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291120709-20658-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Nov 30, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This happens when the driver exit is called quickly after init due to
> adapter power changes.
> ---
>  audio/telephony-maemo6.c |   21 ++++++++++++++++++++-
>  1 files changed, 20 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
