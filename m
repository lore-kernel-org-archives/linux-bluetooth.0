Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+XVXfeBUaxBb1htPfZV_yiecedpvCWwuc91GXsYppxzKwTBog@mail.gmail.com>
References: <1331214279-27521-1-git-send-email-arik@wizery.com>
	<1331214279-27521-2-git-send-email-arik@wizery.com>
	<CAJdJm_NXZMwVtORcCX8tRF4zy-6k3KVF7i1a1WBNmWiDZS7fxA@mail.gmail.com>
	<CA+XVXfeBUaxBb1htPfZV_yiecedpvCWwuc91GXsYppxzKwTBog@mail.gmail.com>
Date: Wed, 14 Mar 2012 08:40:43 -0400
Message-ID: <CAJdJm_PPsjya_tLVzVhWZuHdCALuuW=KGt5uTVhYms-2rED9Qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "core: Add provision for terminating an ATT connection"
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Wed, Mar 14, 2012 at 8:11 AM, Arik Nemtsov <arik@wizery.com> wrote:
> The current disconnect command (exposed via D-Bus as
> Device.Disconnect()) works just fine for me.

This might have been fixed by other means in this case then.

And I see there is a btd_adapter_disconnect_device() (from
do_disconnect()) being called there, so what I proposed is what
actually happens :)

In this case, I think the patch is okay, we can revisit this if the
revert causes problems.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
