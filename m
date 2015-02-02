Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKoWUUsejivik-PpN6=8R1q=veSNTSJ39HJ4PZv420vkQ@mail.gmail.com>
References: <1422664149-16322-1-git-send-email-armansito@chromium.org>
	<CABBYNZKoWUUsejivik-PpN6=8R1q=veSNTSJ39HJ4PZv420vkQ@mail.gmail.com>
Date: Mon, 2 Feb 2015 09:40:52 -0800
Message-ID: <CAHrH25QhyX8Es+k28j+h21wwV0w5qUGRmqMgWwpWgvin5OAd9A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/5] core: gatt: Support enabling notifications
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Mon, Feb 2, 2015 at 5:53 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Sat, Jan 31, 2015 at 2:29 AM, Arman Uguray <armansito@chromium.org> wrote:
>> *v2: Cancel ongoing CCC writes in bt_gatt_client_free.
>>
>> *v1: Make bt_gatt_register_notify cancellable via bt_gatt_unregister_notify.
>>      notify_client_free now unregisters its notify id, which will cancel any
>>      pending CCC write, as well as unregister a registered notify callback.
>>
>> This patch sets brings support for enabling notifications while in GATT
>> client-role. The changes that are introduced are:
>>
>>   1. Implemented the StartNotify and StopNotify methods of the
>>      GattCharacteristic1 interface. This are internally tied to
>>      bt_gatt_client_register_notify and bt_gatt_client_unregister_notify.
>>      These also manage notification sessions on a per dbus sender basis.
>>
>>   2. The exported GATT API objects are not removed in the event of a disconnect,
>>      if the devices are bonded. All notification sessions are also persisted and
>>      automatically re-enabled on reconnection. Also, adding new notification
>>      sessions via StartNotify is allowed during disconnects.
>>
>> Arman Uguray (5):
>>   shared/gatt: Make register_notify cancellable
>>   core: gatt: Implement GattCharacteristic1.StartNotify
>>   core: gatt: Implement GattCharacteristic1.StopNotify
>>   core: device: Don't check ready in service_removed
>>   core: gatt: Keep objects over disconnects
>>
>>  src/device.c             |  22 ++-
>>  src/gatt-client.c        | 435 +++++++++++++++++++++++++++++++++++++++++++++--
>>  src/shared/gatt-client.c | 129 ++++++++------
>>  src/shared/gatt-client.h |   7 +-
>>  tools/btgatt-client.c    |  17 +-
>>  5 files changed, 530 insertions(+), 80 deletions(-)
>>
>> --
>> 2.2.0.rc0.207.ga3a616c
>
> Pushed, but note that I had made a couple of changes. You should
> really stop sending with your internal change-id and I really mean it
> since it wasn't the first time, I know this is because you had these
> patches for a while but we should really try to revert this trend now
> that most API is upstream.
>

This started happening again after I moved things around on my
machine, though I did remove the Change-Id lines in v3, looks like you
applied v2. Sorry about the confusion.

> Also, lets try a little bit the test cases running valgrind, Id just
> had a smoke test with a HoG device and while it worked (luckily the
> device has battery service and supported notifications) and this
> showed up:
>
> http://fpaste.org/180066/87602814/
>

Thanks for doing that. Since I've been debugging on ChromiumOS devices
and not my Ubuntu desktop, I've run into a few issues with running
valgrind that I'm trying to resolve, hopefully things should be fixed
soon.

> I managed to fix the problems but Im not that happy that it too a
> little while to figure out them because the code is a bit convoluted
> in a few places, which is another reason things don't get applied as
> quickly, furthermore the use of the same filename is really bad when
> debugging and Im very tempted to move this code to gatt-dbus.{c,h} or
> create gatt-dbus-client.{c,h}.
>

I thought the src vs src/shared namespacing would be sufficient but we
could rename this to gatt-dbus-client or gatt-client-dbus to prevent
confusion with the term "D-Bus client".

>
> --
> Luiz Augusto von Dentz

Thanks,
Arman
