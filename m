Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 15:39:32 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove unregister interface in telephony-maemo6
Message-ID: <20110323133932.GA16373@jh-x301>
References: <1300886097-18032-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300886097-18032-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Mar 23, 2011, Dmitriy Paliy wrote:
> g_dbus_unregister_interface is removed from maemo6 telephony driver.
> Interface com.nokia.MaemoTelephony is not used as result of changes
> in csd back-end. CreateWith was replaced by Create and CreateFromLast
> method calls, and set last number is implemented directly in csd.
> 
> Registration of this interface was removed due to these changes.
> ---
>  audio/telephony-maemo6.c |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)

Pushed upstream. Thanks.

Johan
