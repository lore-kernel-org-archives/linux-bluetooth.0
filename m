Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
References: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 9 Sep 2013 17:40:46 +0300
Message-ID: <CABBYNZLM6vahniCiRZ3st6mBEHBgHEnJtOB9j+Vj-eK+7vyjfQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/10 v3] Fix message order
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 3, 2013 at 2:21 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> s set fixes a couple of issues introduced with the use of ObjectManager due
> the processing of signals on idle to group changes, this has been causing
> issues with external components such as ofono and pulseaudio that sometimes
> receives connections from devices objects that have pending signals thus
> cannot be properly processed or have to be assumed paired and with certain
> UUIDs which is not ideal.
>
> v2: Fixes some commit messages as suggested by Lucas Demarchi, in addition to
> that rework flush mechanism to honor the order of the pending signals and make
> it work with any connection.
>
> v3: Add comments regarding the use of dbus_connection_send to prevent recursive
> calls to g_dbus_flush.
>
> Luiz Augusto von Dentz (10):
>   build: Fix not rebuilding bluetoothd if gdbus changes
>   unit: Add gdbus/client_check_order
>   gdbus: Fix sending ObjectManager/Properties signals out of order
>   gdbus: Add g_dbus_send_message_with_reply
>   gdbus: Avoid calling dbus_connection_send*
>   gdbus: Fix emitting PropertiesChanged twice
>   core: Make use of g_dbus_send_message_with_reply
>   neard: Make use of g_dbus_send_message_with_reply
>   audio/media: Make use of g_dbus_send_message_with_reply
>   obexd: Make use of g_dbus_send_message*
>
>  Makefile.am                   |   2 +-
>  gdbus/client.c                |  14 ++--
>  gdbus/gdbus.h                 |   3 +
>  gdbus/object.c                | 176 ++++++++++++++++++++++++------------------
>  obexd/plugins/bluetooth.c     |   2 +-
>  obexd/plugins/pcsuite.c       |   5 +-
>  obexd/plugins/syncevolution.c |   6 +-
>  obexd/src/manager.c           |   3 +-
>  plugins/neard.c               |   2 +-
>  profiles/audio/media.c        |   2 +-
>  src/agent.c                   |  12 +--
>  src/profile.c                 |   4 +-
>  unit/test-gdbus-client.c      |  71 +++++++++++++++++
>  13 files changed, 200 insertions(+), 102 deletions(-)
>
> --
> 1.8.3.1

I went ahead and pushed this upstream.


-- 
Luiz Augusto von Dentz
