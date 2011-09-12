Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315845241-17077-2-git-send-email-luiz.dentz@gmail.com>
References: <1315845241-17077-1-git-send-email-luiz.dentz@gmail.com> <1315845241-17077-2-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 12 Sep 2011 15:01:58 -0300
Message-ID: <CAMOw1v6Whx8w2etMWufzjBuhmBFh8oCdqHyov7EtXwPmAZp25Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/5 v2] AVRCP: rename avrcp_header to avc_header
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Sep 12, 2011 at 1:33 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> AVCTP carries AV/C packets/PDUs not AVRCP as avrcp_header suggests.
> ---
>  audio/control.c |   96 +++++++++++++++++++++++++++---------------------------
>  1 files changed, 48 insertions(+), 48 deletions(-)

Ack

Lucas De Marchi
