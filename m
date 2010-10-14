Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Oct 2010 23:35:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix not responding Not Found when no entry is found
Message-ID: <20101014203557.GA9894@jh-x301>
References: <1287063243-23296-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287063243-23296-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 14, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Accourding to PBAP spec PSE must reply Not Found when:
> 
> "The function was recognized and all the parameters are proper, but the
> vCard handle or the phone book object could not be found."
> ---
>  plugins/pbap.c              |   15 +++++++++++++++
>  plugins/phonebook-tracker.c |   12 +++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
