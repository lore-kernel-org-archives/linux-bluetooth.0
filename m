Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
From: Arik Nemtsov <arik@wizery.com>
Date: Thu, 2 Feb 2012 00:48:31 +0200
Message-ID: <CA+XVXffynitA+JYzRnqiRJPQyyrTh+HMNUWQgb0LzD4iowoxpg@mail.gmail.com>
Subject: Re: [PATCH RFC BlueZ 0/5] Time Profile (server) improvements
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Anderson,

On Fri, Dec 2, 2011 at 20:34, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> This series implements two new features for GATT Time Profile (server role):
>
> * Reference Time Update Service (RTUS), with two drivers (called "providers"
>  here): dummy (for testing) and timed (for N9/harmattan)
> * Support for current time notifications

This series looks good overall. Are you planning to go ahead with it
(with a non-RFC series)?

>
> We are aware of the current plan of moving platform specific code out of BlueZ
> (to agents communicating over D-Bus). Is it feasible to be done now for GATT
> servers as well?

It seems this is handled well in your series. Or did you want to move
some more functionality to D-Bus?

Regards,
Arik
