Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415987861-21068-1-git-send-email-jamuraa@chromium.org>
References: <1415987861-21068-1-git-send-email-jamuraa@chromium.org>
Date: Mon, 17 Nov 2014 15:30:11 +0200
Message-ID: <CABBYNZJ2WSDt-jxgfz=Cpheuow117W7CA9S-cBRDOBQVZe7ENQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] GATT shim to src/shared bt_att
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Nov 14, 2014 at 7:57 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> This patch implements a version of GAttrib which is backed by
> bt_att, which enables the simultaneous use of GAttrib and bt_att.
>
> This should enable smooth transition of profiles from the GAttrib
> API to the src/shared bt_att API.
>
> v2 -> v3:
>         * Shared queues and mem management instead of glib
>         * Formatting fixes
>

Applied, note that I had to do some fixes for a double free in
attrib_callbacks_destroy since it is not safe to do queue_remove
within the destroy callback passed to queue_destroy.
