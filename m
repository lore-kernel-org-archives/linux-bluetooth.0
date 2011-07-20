Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Wed, 20 Jul 2011 11:21:46 +0300
Message-ID: <CABBYNZLG9E46Ls1Rtj76OKNb1bFnPvM89Ru3EtXZsV0A+sffGQ@mail.gmail.com>
Subject: Re: [RFC 00/19] Implement AVRCP 1.3 profile - TG role
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Jul 19, 2011 at 10:49 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> This series implement all the mandatory and some optional features in AVRCP 1.3
> profile, target role.
>
> It passed all the related PTS tests and it's slightly tested with a Sony
> MEX-BT2900 car kit.
>
> Current limitation:
>  * It does not support message continuation in case the metadata
>   doesn't fit one AV/C packet.
>  * The D-Bus API doesn't use an agent. Thus it's possible that two applications
>   screw up the data passed to the control interface. I made this on purpose,
>   since it allows me to easily test the interface. Future versions shall
>   remove this limitation.

I don't think it is a good idea to introduce a new API knowing its
limitation, also in some systems we can have different players e.g.
video player and music player and iirc some pdus can address those
players separately. So if you really want this for testing purpose I
would suggest using another interface which should be disabled by
default, this way applications know it is unstable and we can
experiment with it.

> I preferred the API written on doc/control-api.txt rather than the past tentatives
> of using mpris. I'm not sure it's worth supporting it, but I'd like to hear
> opinions. Considering both approaches need the client to be modified in
> order to support the agent, maybe using mpris would just be too much hassle.

I think we might need an agent API anyway, since MPRIS players might
be siting in the session bus so bluetoothd cannot really connect to
them directly, in the other hand there is nothing preventing someone
to write an agent that uses MPRIS to talk to players.

> regards,
> Lucas De Marchi
>
>
>
> Lucas De Marchi (19):
>  avrcp: handle query for company ids
>  avrcp: implement ChangeSetting() method for TG role
>  avrcp: handle ListPlayerApplicationSettingAttributes pdu
>  avrcp: handle ListPlayerApplicationSettingValues pdu
>  avrcp: handle GetCurrentPlayerAplicationSettingValue pdu
>  avrcp: handle SetPlayerApplicationSettingValue pdu
>  avrcp: handle commands for future extension
>  avrcp: handle InformDisplayableCharacterSet pdu
>  avrcp: handle InformBatteryStatusOfCT pdu
>  avrcp: implement ChangePlayback() method
>  avrcp: handle GetPlayStatus pdu
>  avrcp: implement ChangeTrack() method
>  Add script to test control interface
>  avrcp: handle RegisterNotification pdu
>  avrcp: answer query for supported events
>  avrcp: handle GetElementAttributes pdu
>  avrcp: send response for registered events
>  avrcp: change TG record to use version 1.3
>  avrcp: update copyright
>
>  audio/control.c     | 1193 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  doc/control-api.txt |   18 +-
>  test/test-control   |   67 +++
>  3 files changed, 1268 insertions(+), 10 deletions(-)
>  create mode 100755 test/test-control
>
> --
> 1.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
