Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v4UseGTxfjLjZ2okiv8=RNSFjXv47VQZ9mkmRAmwM6wiQ@mail.gmail.com>
References: <1332844093-1818-1-git-send-email-michal.labedzki@tieto.com>
	<CAMOw1v4UseGTxfjLjZ2okiv8=RNSFjXv47VQZ9mkmRAmwM6wiQ@mail.gmail.com>
Date: Mon, 2 Apr 2012 18:24:30 -0300
Message-ID: <CABBYNZKLuSMym8H6eBZR-ifXQrjzus3AfjAYwQjPj_Lpz+FK7A@mail.gmail.com>
Subject: Re: [PATCH] AVRCP: Add support for changing active player
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Michal Labedzki <michal.labedzki@tieto.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

On Mon, Apr 2, 2012 at 9:28 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hi Michal
>
> On Tue, Mar 27, 2012 at 7:28 AM, Michal Labedzki
> <michal.labedzki@tieto.com> wrote:
>> There is possibility to register more then one player, so this patch
>> allow to change active player to the freely chosen previously
>> registered player.

IMO this should be in the MediaPlayer interface, something like Active
property, but Im not really sure this will be useful because afaik
there could be only one addressed player and this normally comes from
the CT so bluetoothd alone should be able to stop forwarding the
commands to player not being addressed, but maybe it can be useful for
1.3 because it lacks addressed player support.

For changes coming from the TG side it is not very efficient to have
this as a Method as multiple player can be active so they could fight
to be the addressed one endlessly.


-- 
Luiz Augusto von Dentz
