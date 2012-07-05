Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1341509854-9875-1-git-send-email-jprvita@openbossa.org>
References: <1341509854-9875-1-git-send-email-jprvita@openbossa.org>
Date: Thu, 5 Jul 2012 18:39:27 -0300
Message-ID: <CAJdJm_NjTgwanMe-eSZ6RYQLV1-4V5tetpidr1Qd4aS2P7=XFA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] time: fix byte position
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Thu, Jul 5, 2012 at 2:37 PM, João Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> The position of the "Time Zone" and "Daylight Saving Time" fields on
> the Local Time Information characteristic was inverted. This commit
> fix their position.
> ---
>  time/server.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Patch looks good.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
