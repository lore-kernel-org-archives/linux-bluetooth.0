Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 22:57:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Basic attribute permission support
Message-ID: <20101207205711.GA24045@jh-x301>
References: <1291400782-24736-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291400782-24736-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Dec 03, 2010, Anderson Lizardo wrote:
> Changes since V1:
> 
> * Simplified permission scheme according to discussion on IRC.
> * Fixed incorrect error sent by server.
> 
> This patchset adds initial support for attribute permission checks. Currently,
> only access and authentication permissions are checked. Authorization
> permissions require integration with the BlueZ agent, which is not implemented
> yet.
> 
> There are some pending issues necessary for a minimum complete attribute
> permission support (all of them are being worked on):
> 
> * The attribute client, upon receiving the "Insufficient Encryption" error,
>   shall increase the security level and resend the failed request.
> * The attribute server shall verify the connection permissions on each ATT
>   request, and not just once on connection callback.
> * On kernel side, increasing the security level (using setsockopt()) shall
>   trigger SMP negotiation for a LE connection, blocking next socket I/O until
>   negotiation is finished.
> * On BR/EDR, link encryption is mandatory for GATT (see Vol 3, Part G, 2.4
>   "Profile Fundamentals").
> 
> Albeit the above issues, we believe these patches are ready for commit.

All three patches have been pushed upstream. Thanks.

Johan
