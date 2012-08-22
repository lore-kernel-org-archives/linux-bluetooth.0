Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <503545C5.80607@globaledgesoft.com>
References: <503545C5.80607@globaledgesoft.com>
Date: Wed, 22 Aug 2012 08:24:16 -0400
Message-ID: <CAJdJm_NHy82UOofuQv1jGObJPg4MOj68R3D_xcBjNhCZWdy9Hw@mail.gmail.com>
Subject: Re: Re : BLE -Multiple connection
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay KV <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Wed, Aug 22, 2012 at 4:49 PM, Ajay KV <ajay.kv@globaledgesoft.com> wrote:
>             I think we already discussed about this issue  . following is
> our previous conversation. please go through it

Please, try to disable HTML on your email client and send plain text
e-mails. It is difficult to follow your discussion with all this HTML.
It is very likely people are not helping you because your emails are
unreadable for a lot of people here.

Much information is missing from your previous messages:

1) You did not provide the exact steps you followed (which commands
you run after plugging the bluetooth dongle). Therefore it is
difficult to reproduce your tests.
2) Your HCI dump output shows just the command giving error. This is
not enough, you should provide the entire dump since the adapter was
plugged, including the first "B to A" connection you described, and
the second LE advertising attempt, otherwise it is not possible to
identify at which state the LE controller is when the LE adv. enable
command is issued.

Also, do you realize that you are not allowed by the current Core spec
v4.0 to have one dual mode device connected to another dual mode over
the LE link? The spec says that a dual mode device in "connectable
mode" (like device "A" in you original scenario) shall not be issuing
connectable advertising over the LE channel. This is not enforced by
the controller (and we actually do this for testing BlueZ to BlueZ
connections over LE), but the spec explicitly forbids it.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
