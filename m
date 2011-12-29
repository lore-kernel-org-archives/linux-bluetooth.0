Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1325177984-26383-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325177984-26383-1-git-send-email-dh.herrmann@googlemail.com>
Date: Thu, 29 Dec 2011 13:15:12 -0400
Message-ID: <CAJdJm_PJPx7tze9zioH4kT-d9_9j7jHFqmW-H4ufDfVHB_kE3A@mail.gmail.com>
Subject: Re: [PATCH] Fix wiimote device_get_address to use new API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Thu, Dec 29, 2011 at 12:59 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Commit b06899eace1f484b387aae0e568fb1da988b468c introduced a new API for
> device_get_name but apparently missed fixing the call in plugins/wiimote.c. This
> patch converts the plugin to use the new API.

You should consider adding this plugin to bootstrap-configure, so it
is not forgotten again. Currently it is not built by running
"./bootstrap-configure"

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
