Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1300215293-30294-3-git-send-email-johan.hedberg@gmail.com>
References: <1300215293-30294-1-git-send-email-johan.hedberg@gmail.com>
	<1300215293-30294-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 15 Mar 2011 15:57:49 -0400
Message-ID: <AANLkTin6vrCYOUdrob5Y42adqXXig3RUMeni99YW_yVb@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: mgmt: Add support for setting the local name
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Mar 15, 2011 at 2:54 PM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@nokia.com>
>
> This patch adds a new set_local_name management command as well as a
> local_name_changed management event. With these user space can both
> change the local name as well as monitor changes to it by others.
>
> The management messages reserve 249 bytes for the name instead of 248
> (like in the HCI spec) so that there is always a guarantee that it is
> nul-terminated. That way it can safely be passed onto string
> manipulation functions.

I wonder if it is "future-proof" to use 248 and 249 along the code
without using some #define for the the spec defined value. Someone may
look at the code later and think there is a bug, even though it is
clear from the commit message.

My two cents,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
