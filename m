Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <68C3A27C-6218-4DCA-BC3A-D6813E3F9EFC@holtmann.org>
References: <1362140773-13672-1-git-send-email-luiz.dentz@gmail.com>
	<1362140773-13672-3-git-send-email-luiz.dentz@gmail.com>
	<68C3A27C-6218-4DCA-BC3A-D6813E3F9EFC@holtmann.org>
Date: Fri, 1 Mar 2013 19:19:55 +0200
Message-ID: <CABBYNZL+s4ieP4ToSvqML3PkybRnggPOMg5W+_RFdNb27_7=DA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] core: Rename hcid.h to main.h
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 1, 2013 at 6:15 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>
>> main seems more logical than hcid which use to be the binary name of
>> bluetoothd really long time ago.
>> ---
>> Makefile.am                   | 2 +-
>> plugins/gatt-example.c        | 2 +-
>> plugins/neard.c               | 2 +-
>> profiles/proximity/main.c     | 2 +-
>> profiles/proximity/reporter.c | 2 +-
>> src/adapter.c                 | 2 +-
>> src/attrib-server.c           | 2 +-
>> src/device.c                  | 2 +-
>> src/main.c                    | 2 +-
>> src/{hcid.h => main.h}        | 0
>> src/plugin.c                  | 2 +-
>> src/profile.c                 | 2 +-
>> src/rfkill.c                  | 2 +-
>> src/sdpd-server.c             | 2 +-
>> src/sdpd-service.c            | 2 +-
>> 15 files changed, 14 insertions(+), 14 deletions(-)
>> rename src/{hcid.h => main.h} (100%)
>
> NAK. main.h is one single header we are not going to have. I do not want main.c to share anything actually. I want main.c to consume everything else.

Well what is left, bluetoothd.h? Since this is mainly for config
options I guess this would be fine or you have a better idea?


-- 
Luiz Augusto von Dentz
