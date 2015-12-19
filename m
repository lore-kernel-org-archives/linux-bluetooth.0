Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sun, 20 Dec 2015 03:18:04 +0800
From: John Munroe <munddr@gmail.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <etPan.5675ad6c.5a2be03b.9abd@guardian>
Subject: Issue with gatt_discover_primary()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm using bluez on a GATT client (PC) and TI's SimpleBLEPeripheral code on a GATT server (PCB). The PCB's UUID is:

0000fff0-0000-1000-8000-00805f9b34fb

Using bluez, I have the following


static GAttrib *attrib = NULL;
...
static void cmd_primary(int argcp, char **argvp)
{
    bt_uuid_t uuid;

    if (conn_state != STATE_CONNECTED) {
        resp_error(err_BAD_STATE);
        return;
    }

    if (argcp == 1) {
        gatt_discover_primary(attrib, NULL, primary_all_cb, NULL);
        return;
    }

    if (bt_string_to_uuid(&uuid, argvp[1]) < 0) {
        resp_error(err_BAD_PARAM);
        return;
    }

    gatt_discover_primary(attrib, &uuid, primary_by_uuid_cb, NULL);
}

static void primary_by_uuid_cb(uint8_t status, GSList *ranges, void *user_data)
{
    GSList *l;

    if (status) {
        resp_error(err_COMM_ERR); // Todo: status
        return;
    }

    resp_begin(rsp_DISCOVERY);
    for (l = ranges; l; l = l->next) {
        struct att_range *range = l->data;
        send_uint(tag_RANGE_START, range->start);
        send_uint(tag_RANGE_END, range->end);
    }
    resp_end();
}


After successfully connecting to the PCB, running

cmd_primary(2, (char *[]){"svcs", "0000fff0-0000-1000-0000-000000000000”}) 

leads the callback primary_by_uuid_cb() to be called with the parameter ‘ranges' being NULL. If the service is recognised, ‘ranges' shouldn't be NULL - correct?

If that's the case, does anyone know why the service is not found (or why ‘ranges' is NULL if it shouldn't be)?

Any help will be appreciated.


Thanks

John
