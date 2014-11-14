Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415900357-27027-5-git-send-email-jamuraa@chromium.org>
References: <1415900357-27027-1-git-send-email-jamuraa@chromium.org>
	<1415900357-27027-5-git-send-email-jamuraa@chromium.org>
Date: Fri, 14 Nov 2014 14:51:24 +0200
Message-ID: <CABBYNZKwUsbT5-pVpTb6K9YnOrALB18XM5wvp_FPk7t2COb29Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/4] GATT shim to src/shared bt_att
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Thu, Nov 13, 2014 at 7:39 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> This patch implements a version of GAttrib which is backed by
> bt_att, which enables the simultaneous use of GAttrib and bt_att.
>
> This should enable smooth transition of profiles from the GAttrib
> API to the src/shared bt_att API.
> ---

Lets not mix glib and shared code here, so please use new0, queue,
etc. Also there are a few coding style problems like mixing tabs and
spaces, you should never use spaces for indentation.


-- 
Luiz Augusto von Dentz
