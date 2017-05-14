Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Clarification on deprecated tools (e.g. hciconfig)
From: Jonah Petri <jonah@sense.com>
In-Reply-To: <CABBYNZLAD5Z_FP96weVpCMezdjU+Ebu8BQcY1bNdwf8-r2Dxcw@mail.gmail.com>
Date: Sun, 14 May 2017 13:25:42 -0400
Cc: John Hendy <jw.hendy@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <EA26EA18-6833-47B2-808A-85D43E9768EE@sense.com>
References: <CA+M2ft9OM_rZhmZy7hxEffE2mw5kGEjvS0WcJcKxkkt_jcxtRQ@mail.gmail.com> <CABBYNZLAD5Z_FP96weVpCMezdjU+Ebu8BQcY1bNdwf8-r2Dxcw@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On May 14, 2017, at 12:19 PM, Luiz Augusto von Dentz =
<luiz.dentz@gmail.com> wrote:
>> I'd be happy to update the arch wiki to point to any new information
>> provided. For what it's worth, I think the information would be
>> relevant in a widely accessible place (the official bluez site in my
>> opinion); this question has already popped up in various places. [4]
>> [5] [6] [7]
>=20
> I guess the most practical solution would be to switch everything to
> use bluetoothctl as much as possible, going with raw or mgmt socket
> should only be mentioned as a last resort in case something went
> wrong.

Is bluetoothctl scriptable?  It doesn=E2=80=99t seem to be able to take =
commands in anything but interactive mode.  As far as I can tell, where =
I used to do =E2=80=9Chciconfig hci0 up=E2=80=9D as one line in a shell =
script, I now need to write a fully-fledged dbus application to bring up =
the interface.  Is my conclusion correct?

Jonah=
