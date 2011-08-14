Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313161215.2254.6.camel@THOR>
References: <1313161215.2254.6.camel@THOR>
Date: Sun, 14 Aug 2011 22:57:43 +0300
Message-ID: <CABBYNZ+3jC+1LbvHgie5LX_8Xr_kRT6G-ed7dsn-pEUzoVam=g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] Increase timeout before initiating AVDTP connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Aug 12, 2011 at 6:00 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> AVDTP_CONNECT_TIMEOUT controls the delay between HSP/HFP
> connection establishment and AVDTP signal channel establishment.
> The original value of 1 sec. is too short to avoid racing for AVDTP
> connection establishment (eg., if the device continues to configure
> the HFP service level connection with add'l AT cmds).
>
> Some devices have broken AVDTP implementations that just cannot
> handle the race conditions that arise if both devices are attempting
> stream establishment at the same time. However, these conditions arise
> only when the remote device is the ACL initiator (and in practice, the
> RFCOMM initiator as well).  This fix bumps out the timeout value only
> when the headset has initiated the link.
> ---
>
> v2: Follow established naming convention

How about if we add some retry logic? I think it would be more
efficient since it would not add an extra delay for devices that do
not have such problem, perhaps we can even eliminate the 1 sec we
currently have and just retry if we detect a collision has happened.

-- 
Luiz Augusto von Dentz
