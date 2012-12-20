Return-Path: <cyrus@holtmann.org>
Message-ID: <50D2C258.4000908@linux.intel.com>
Date: Thu, 20 Dec 2012 09:46:32 +0200
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gdbus: Fix double free when calling g_dbus_remove_all_watches
References: <20121128122318.GA30710@x220.ger.corp.intel.com> <1355918497-21944-1-git-send-email-tomasz.bursztyka@linux.intel.com> <CAMOw1v40+w62ToR4SKnNLnKfLzBSz_MKK1fXwoW66z7cXbTw4A@mail.gmail.com>
In-Reply-To: <CAMOw1v40+w62ToR4SKnNLnKfLzBSz_MKK1fXwoW66z7cXbTw4A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> @@ -309,6 +309,9 @@ static void filter_data_call_and_free(struct filter_data *data)
>                  g_free(cb);
>          }
>
> +       g_slist_free(data->callbacks);
> +       data->callbacks = NULL;
> +
>
> why not just removing the g_free(cb)  above?
>

I did so to avoid filter_data_free() to go through the list once again,
but indeed if the list is not going to be big, it's superfluous then.

Tomasz
