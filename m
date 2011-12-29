Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_PJPx7tze9zioH4kT-d9_9j7jHFqmW-H4ufDfVHB_kE3A@mail.gmail.com>
References: <1325177984-26383-1-git-send-email-dh.herrmann@googlemail.com>
	<CAJdJm_PJPx7tze9zioH4kT-d9_9j7jHFqmW-H4ufDfVHB_kE3A@mail.gmail.com>
Date: Thu, 29 Dec 2011 18:20:21 +0100
Message-ID: <CANq1E4RAHCKFY_Rc_5jKcGrMpPEGs0vtawOiR58TNpG+xvNfcQ@mail.gmail.com>
Subject: Re: [PATCH] Fix wiimote device_get_address to use new API
From: David Herrmann <dh.herrmann@googlemail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 29, 2011 at 6:15 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi David,
>
> On Thu, Dec 29, 2011 at 12:59 PM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
>> Commit b06899eace1f484b387aae0e568fb1da988b468c introduced a new API for
>> device_get_name but apparently missed fixing the call in plugins/wiimote.c. This
>> patch converts the plugin to use the new API.
>
> You should consider adding this plugin to bootstrap-configure, so it
> is not forgotten again. Currently it is not built by running
> "./bootstrap-configure"

Ah, I didn't know of it. I've sent a separate patch. Thanks.
