Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Nu0Mo7wGYWQr547Mat9hqXyygRbgn23p1QnyY3GrYJnA@mail.gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
	<1357825038-21970-13-git-send-email-luiz.dentz@gmail.com>
	<CAJdJm_Nu0Mo7wGYWQr547Mat9hqXyygRbgn23p1QnyY3GrYJnA@mail.gmail.com>
Date: Thu, 10 Jan 2013 18:56:47 +0200
Message-ID: <CABBYNZJ4es9AJ09u+DemW4SBA=AKR8NMBgbeRhndsC2ezGbMFg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 13/13 v2] tools: Update mpris-player to register
 using MPRIS interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Thu, Jan 10, 2013 at 6:02 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Luiz,
>
> On Thu, Jan 10, 2013 at 9:37 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> In addition fix not supporting new APIs for getting the adapter.
>> ---
>
> Got this compilation error after this patch:
>
>   CC     tools/mpris-player.o
> tools/mpris-player.c: In function ‘parse_metadata_entry’:
> tools/mpris-player.c:154:2: error: unknown type name ‘DBusBasicValue’
> tools/mpris-player.c: In function ‘parse_property’:
> tools/mpris-player.c:315:2: error: unknown type name ‘DBusBasicValue’

Just send a fix for this, can you try and let me know if it fix the problem.


--
Luiz Augusto von Dentz
