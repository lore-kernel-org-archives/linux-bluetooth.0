Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jul 2012 16:19:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sathish narasimman <nsathish41@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: AVDTP RECONFIGURE COMMAND & RESPONSE
Message-ID: <20120729141929.GA18701@x220>
References: <CAOVXEJJawhMTvVLvF1E0YjPpJsOD6fNy4G8m3oxS9G=vQYP=3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOVXEJJawhMTvVLvF1E0YjPpJsOD6fNy4G8m3oxS9G=vQYP=3A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Satish,

On Mon, Jul 23, 2012, Sathish narasimman wrote:
> i am trying to send AVDTP_RECONFIGURE command but every time i am just
> getting AVDTP_MSG_TYPE_GEN_REJECT . I saw in avdtp.c that response for
> RECONFIGURE command is always set to reply as unknown command i.e
> response is rejected.. I want to know whether reconfigure is possible
> in bluez.

AVDTP Reconfigure is an optional feature, so implementations are allowed
to return an error for it. BlueZ has opted to not support it (neither
sending nor receiving) since we in any case need to deal with
implementations that do not support it.

Johan
