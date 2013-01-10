Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357825038-21970-13-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
	<1357825038-21970-13-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 10 Jan 2013 12:02:55 -0400
Message-ID: <CAJdJm_Nu0Mo7wGYWQr547Mat9hqXyygRbgn23p1QnyY3GrYJnA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 13/13 v2] tools: Update mpris-player to register
 using MPRIS interface
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jan 10, 2013 at 9:37 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In addition fix not supporting new APIs for getting the adapter.
> ---

Got this compilation error after this patch:

  CC     tools/mpris-player.o
tools/mpris-player.c: In function ‘parse_metadata_entry’:
tools/mpris-player.c:154:2: error: unknown type name ‘DBusBasicValue’
tools/mpris-player.c: In function ‘parse_property’:
tools/mpris-player.c:315:2: error: unknown type name ‘DBusBasicValue’

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
