Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
References: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 29 Jun 2011 15:57:07 -0300
Message-ID: <BANLkTika3jp4Y2vyU-PWpgf+oDBX_xgN_Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] Make use of g_slist_free_full when elements are dynamically-allocated
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jun 29, 2011 at 5:52 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This avoid having to iterate twice in the list to free its elements.

I like this. Another thing that I think it'd be nice to use is
g_io_channel_set_close_on_unref() instead of unref() + shutdown() in
several places. What do you think?


Lucas De Marchi
