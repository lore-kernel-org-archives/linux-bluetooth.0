Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <EA26EA18-6833-47B2-808A-85D43E9768EE@sense.com>
References: <CA+M2ft9OM_rZhmZy7hxEffE2mw5kGEjvS0WcJcKxkkt_jcxtRQ@mail.gmail.com>
 <CABBYNZLAD5Z_FP96weVpCMezdjU+Ebu8BQcY1bNdwf8-r2Dxcw@mail.gmail.com> <EA26EA18-6833-47B2-808A-85D43E9768EE@sense.com>
From: Barry Byford <31baz66@gmail.com>
Date: Sun, 14 May 2017 21:55:39 +0100
Message-ID: <CAAu3APYYQ3dZXgw3Ba+39TVt3eDmycdPG8ZrRnZ9-oVX+ML1JQ@mail.gmail.com>
Subject: Re: Clarification on deprecated tools (e.g. hciconfig)
To: Jonah Petri <jonah@sense.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        John Hendy <jw.hendy@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 14 May 2017 at 18:25, Jonah Petri <jonah@sense.com> wrote:
>
>> On May 14, 2017, at 12:19 PM, Luiz Augusto von Dentz <luiz.dentz@gmail.c=
om> wrote:
>>> I'd be happy to update the arch wiki to point to any new information
>>> provided. For what it's worth, I think the information would be
>>> relevant in a widely accessible place (the official bluez site in my
>>> opinion); this question has already popped up in various places. [4]
>>> [5] [6] [7]
>>
>> I guess the most practical solution would be to switch everything to
>> use bluetoothctl as much as possible, going with raw or mgmt socket
>> should only be mentioned as a last resort in case something went
>> wrong.
>
> Is bluetoothctl scriptable?  It doesn=E2=80=99t seem to be able to take c=
ommands in anything but interactive mode.  As far as I can tell, where I us=
ed to do =E2=80=9Chciconfig hci0 up=E2=80=9D as one line in a shell script,=
 I now need to write a fully-fledged dbus application to bring up the inter=
face.  Is my conclusion correct?

You can do some scripting like the following with bluetoothctl:

bluetoothctl << EOF
power on
EOF


You can also do DBus on the command line. Depending on your system it
might need to be gdbus, dbus-send or busctl etc.

For example with busctl on my system I can do:

busctl call org.bluez /org/bluez/hci0 org.freedesktop.DBus.Properties
Set ssv org.bluez.Adapter1 Powered b true

busctl call org.bluez /org/bluez/hci0 org.freedesktop.DBus.Properties
Set ssv org.bluez.Adapter1 Powered b false


>
> Jonah--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
