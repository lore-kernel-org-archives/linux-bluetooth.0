Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4E9CF709.6080706@globaledgesoft.com>
References: <4E9CF709.6080706@globaledgesoft.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 18 Oct 2011 20:13:30 -0200
Message-ID: <CAMOw1v7vqcsqFS3AmuoxHxQXXo-CWea8xJFSomyfDgkFo3b4FQ@mail.gmail.com>
Subject: Re: AVRCP
To: sathish <sathish.n@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sathish

On Tue, Oct 18, 2011 at 1:48 AM, sathish <sathish.n@globaledgesoft.com> wrote:
> Hi,
>   I like to know , how to implement avrcp between two systems in Linux using
> bluez . Is there any one one who can help me. where bluez supports both
> control and target. but how to implement it .

The functionality provided in control role is very limited. It's only
some pieces of 1.0 spec. Since target only reacts to commands coming
from CT, you'll not be able to do anything useful with 2 systems using
Linux.


If you want to use it only as target, it has all the mandatory
features of AVRCP 1.3 + some optional ones. Then you can use it by:

1) Enable the Media interface in /etc/bluetooth/audio.conf
2) Start bluetoothd service
3) Start test/mpris-player
4) Use a media player that supports mpris 2.0: amarok, rhytmbox and a
few others.

If you are going to implement it in a media player, I suggest
implementing our dbus interface, so you can cut the 3rd step.


regards,
Lucas De Marchi
