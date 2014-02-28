Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140228073113.GA3771@adam-laptop>
References: <1393571362-27898-1-git-send-email-adam8157@gmail.com>
	<04802ECE-6B8D-4DF4-BFFD-EABBD42BD30F@holtmann.org>
	<20140228073113.GA3771@adam-laptop>
Date: Fri, 28 Feb 2014 08:22:17 -0400
Message-ID: <CAJdJm_OnnyvMvLmCtYuLGOvUL0igK22gOCAP1G5KBvcJseaayw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: retry connect_dbus() several times
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Adam Lee <adam8157@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Fri, Feb 28, 2014 at 3:31 AM, Adam Lee <adam8157@gmail.com> wrote:
> connect_dbus() fails sometimes with Intel 7260 bluetooth, sleeping 0.5s
> before executing bluetoothd workarounds it. I assume the firmware
> patching slows down hardware initialization then fails to connect.
>
> Any other possibility? I'm not a D-Bus guru :)

Please provide more details, e.g. the bluetoothd logs showing the
problems, btmon output and which steps you are using to reproduce it.
If you are using bluetoothctl, tell us which commands you are using.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
