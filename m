Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Oct 2010 16:42:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix regression when formatting timestamps from tracker
Message-ID: <20101019134224.GA13310@jh-x301>
References: <1287489236-4558-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287489236-4558-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 19, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Tracker format user delimiters like '-' and ':' which need to be keep in
> order to sscanf to work.
> ---
>  plugins/phonebook-tracker.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
