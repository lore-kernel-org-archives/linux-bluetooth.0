Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315826997-13818-3-git-send-email-luiz.dentz@gmail.com>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com> <1315826997-13818-3-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 12 Sep 2011 10:47:23 -0300
Message-ID: <CAMOw1v5OOunZpxvvxVdCQkM-KbJpp3QBvNFOAROzvYCf6wU0jQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] AVRCP: rename avrcp_spec_avc_pdu to avrcp_header
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 12, 2011 at 8:29 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Since old avrcp_header got renamed to avc_header now we can use
> avrcp_header for AVRCP PDUs.
> ---
>  audio/control.c |   44 ++++++++++++++++++++++----------------------
>  1 files changed, 22 insertions(+), 22 deletions(-)

ack


Lucas De Marchi
