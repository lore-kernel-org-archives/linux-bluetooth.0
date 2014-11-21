Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25TwHi2pJzsBqKm-4tZWZ8jPfpnJcq415RG6zCmSbiGUpw@mail.gmail.com>
References: <1416459821-16478-1-git-send-email-armansito@chromium.org>
	<CAHrH25TwHi2pJzsBqKm-4tZWZ8jPfpnJcq415RG6zCmSbiGUpw@mail.gmail.com>
Date: Fri, 21 Nov 2014 15:15:26 +0200
Message-ID: <CABBYNZJnYyV2z+3rvT+56MGDqad3CTxUDHCyyFtM6Guuu05e-Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/gatt-server: Fix bug in bt_gatt_server_unref.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Nov 21, 2014 at 1:54 AM, Arman Uguray <armansito@chromium.org> wrote:
> Hi,
>
>> On Wed, Nov 19, 2014 at 9:03 PM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch adds a check for NULL argument in bt_gatt_server_unref.
>> ---
>>  src/shared/gatt-server.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
>> index 2ef9269..ef91289 100644
>> --- a/src/shared/gatt-server.c
>> +++ b/src/shared/gatt-server.c
>> @@ -1215,6 +1215,9 @@ struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server)
>>
>>  void bt_gatt_server_unref(struct bt_gatt_server *server)
>>  {
>> +       if (!server)
>> +               return;
>> +
>>         if (__sync_sub_and_fetch(&server->ref_count, 1))
>>                 return;
>>
>> --
>> 2.1.0.rc2.206.gedb03e5
>>
>
> ping.
> --

This one is applied, see the comments about 2/2.


-- 
Luiz Augusto von Dentz
