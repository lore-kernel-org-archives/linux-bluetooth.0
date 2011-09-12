Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315845241-17077-1-git-send-email-luiz.dentz@gmail.com>
References: <1315845241-17077-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 12 Sep 2011 14:57:17 -0300
Message-ID: <CAMOw1v65ksB1e4TkrsjT6dO_kJPodxqiJCHjAM8+gV8EZP8XSw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5 v2] AVRCP: use a vtable to simplify PDU parsing/handling
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On Mon, Sep 12, 2011 at 1:33 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This simplify a bit the handling by introducing common checks before
> calling the handler callback, it is also much easier to add/remove
> new PDUs in this way.
> ---
>  audio/control.c |  321 +++++++++++++++++++++----------------------------------
>  1 files changed, 124 insertions(+), 197 deletions(-)
>

Ack.

Lucas De Marchi
