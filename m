Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 20:52:15 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Add proper tracking mechanism to NREC
Message-ID: <20110119152215.GG2112@jh-x301>
References: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
 <1295344815-1404-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295344815-1404-4-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 18, 2011, Luiz Augusto von Dentz wrote:
> NREC may change during the connections so it has to be tracked in order
> to signal changes to applications.
> ---
>  audio/headset.c   |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  audio/headset.h   |    6 +++++
>  audio/transport.c |   17 ++++++++++++++
>  3 files changed, 84 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
