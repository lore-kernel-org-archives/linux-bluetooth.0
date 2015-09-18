Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Seungyoun Ju <sy39.ju@samsung.com>
Date: Fri, 18 Sep 2015 16:39:50 +0900
Message-ID: <CAB512Gtwysk7k8dr9PPLDr_n+iGke01Z39YaW0mZBmuo1YUw0w@mail.gmail.com>
Subject: Query about GATT Client WriteValue dbus method
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, All.

If a remote GATT server's characteristic only supports
BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP, src/gatt-clieint.c's WriteValue
dbus method reaches to bt_gatt_client_write_without_response().
And the return value is kept in chrc->write_id.

But there is no point to clear this chrc->write_id.
So next time WriteValue call is failed with in progress error.

If chrc->write_id is cleared immediately after
bt_gatt_client_write_without_response(),
client->pending_requests queue would be grown up infinitely when
application calls this method repeatedly and fastly after dbus method
return.

Is there anyone who meets such an issue ?

If there is anyone who struggled with this kind of issue,
can you help me how to solve this ?

Thanks and Regards,
Seungyoun Ju.
