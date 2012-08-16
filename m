Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120816092032.GA31761@x220>
References: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
	<1345042253-15053-5-git-send-email-jprvita@openbossa.org>
	<20120816092032.GA31761@x220>
Date: Thu, 16 Aug 2012 17:40:51 -0300
Message-ID: <CAAngNMa2r0SD1qRiO_fB69cNYidQZ1D-G0zxv_pqK1VKcKLgWg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 04/14] core: Add a list of LE devices to connect
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 16, 2012 at 6:20 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi João Paulo,
>
> On Wed, Aug 15, 2012, João Paulo Rechi Vita wrote:
>> +     device_get_address(device, &bdaddr, NULL);
>> +     if (g_slist_find_custom(adapter->connect_list, &bdaddr,
>> +                                     (GCompareFunc) device_bdaddr_cmp)) {
>> +             DBG("trying to add device %s which is already in the connect "
>> +                             "list, ignoring", device_get_path(device));
>> +             return;
>> +     }
>
> Why don't you just use g_slist_find here? If this is the only place
> where you need the new device_bdaddr_cmp then patch 03/14 can be
> removed.
>

I agree with this change, but device_bdaddr_cmp is also used on this chunk:

@@ -2930,6 +2973,16 @@ void adapter_update_found_devices(struct
btd_adapter *adapter,

        adapter->found_devices = g_slist_prepend(adapter->found_devices, dev);

+       if (bdaddr_type == BDADDR_LE_PUBLIC ||
+                                       bdaddr_type == BDADDR_LE_RANDOM) {
+               l = g_slist_find_custom(adapter->connect_list, bdaddr,
+                                       (GCompareFunc) device_bdaddr_cmp);
+               if (l) {
+                       g_idle_add(connect_pending_cb, l->data);
+                       stop_discovery(adapter);
+               }
+       }
+
 done:
        dev->rssi = rssi;


-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
