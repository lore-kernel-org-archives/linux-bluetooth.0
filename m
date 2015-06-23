Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABKPALo_wHz4LifYPH7vmHabJ50fKmYRvF5VWzBQh=TVWEFXeQ@mail.gmail.com>
References: <CABKPALo_wHz4LifYPH7vmHabJ50fKmYRvF5VWzBQh=TVWEFXeQ@mail.gmail.com>
Date: Tue, 23 Jun 2015 11:48:01 +0300
Message-ID: <CABBYNZK5pVgLRbAZQF=Z7mJAMWO7TAVEo2SvdHnkB0AQ7HZmjg@mail.gmail.com>
Subject: Re: SeviceData PropertiesChanged
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Neil Martin <neil@vnp.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Neil,

On Tue, Jun 23, 2015 at 2:59 AM, Neil Martin <neil@vnp.com> wrote:
> I’ve just installed 5.31 and started looking at the new advertising
> data that's been added to Device1.  I'm seeing odd behavior for
> ServiceData.  I live within range of a large number of bluetooth
> devices and for one of them, I'm getting PropertiesChanged signals for
> ServiceData that get fired multiple times each minute. Each time the
> dictionary contains another entry for the same key and all the data
> entries are identical.  Here are the first two signals from
> dbus-monitor:
>
>
> signal sender=:1.0 -> dest=(null destination) serial=43
> path=/org/bluez/hci0/dev_C2_A9_8A_AE_A5_28;
> interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
>    string "org.bluez.Device1"
>    array [
>       dict entry(
>          string "ServiceData"
>          variant             array [
>                dict entry(
>                   string "180a"
>                   variant                      array of bytes [
>                         02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
>                      ]
>                )
>                dict entry(
>                   string "180a"
>                   variant                      array of bytes [
>                         02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
>                      ]
>                )
>             ]
>       )
>    ]
>    array [
>    ]
>
>
> signal sender=:1.0 -> dest=(null destination) serial=50
> path=/org/bluez/hci0/dev_C2_A9_8A_AE_A5_28;
> interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
>    string "org.bluez.Device1"
>    array [
>       dict entry(
>          string "ServiceData"
>          variant             array [
>                dict entry(
>                   string "180a"
>                   variant                      array of bytes [
>                         02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
>                      ]
>                )
>                dict entry(
>                   string "180a"
>                   variant                      array of bytes [
>                         02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
>                      ]
>                )
>                dict entry(
>                   string "180a"
>                   variant                      array of bytes [
>                         02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
>                      ]
>                )
>             ]
>       )
>    ]
>    array [
>    ]
>
> These signals keep coming and every time there is one more “dict
> entry”.  Can anyone explain what I’m seeing?

There is a bug in the code detecting the data was previously found,
the following patch should fix it:
diff --git a/src/shared/ad.c b/src/shared/ad.c
index e841d1d..485bd7b 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -590,7 +590,7 @@ bool bt_ad_add_service_data(struct bt_ad *ad,
const bt_uuid_t *uuid, void *data,
        if (len > (MAX_ADV_DATA_LEN - 2 - (size_t)bt_uuid_len(uuid)))
                return false;

-       new_data = queue_find(ad->service_uuids, service_uuid_match, uuid);
+       new_data = queue_find(ad->service_data, service_uuid_match, uuid);
        if (new_data) {
                if (new_data->len == len && !memcmp(new_data->data, data, len))
                        return false;


-- 
Luiz Augusto von Dentz
