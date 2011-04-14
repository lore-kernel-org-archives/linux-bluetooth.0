Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Apr 2011 20:13:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix unregistering a2dp sep while it is locked
Message-ID: <20110414171352.GA10623@jh-x301>
References: <1302686450-5961-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302686450-5961-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Apr 13, 2011, Luiz Augusto von Dentz wrote:
> If sep is locked it should not be unregistered until properly unlocked.
> ---
>  audio/a2dp.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
