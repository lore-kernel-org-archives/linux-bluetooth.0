Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <64470655-51FF-4B41-ADCD-7B94EB7E9B80@holtmann.org>
References: <20170719130909.24702-1-luiz.dentz@gmail.com> <20170719130909.24702-3-luiz.dentz@gmail.com>
 <64470655-51FF-4B41-ADCD-7B94EB7E9B80@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Jul 2017 13:25:01 +0300
Message-ID: <CABBYNZ+Hbee9T=F7gCP=ejMRHjW1+obxZEh1NGwtK+WnPJYNOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] monitor: Filter duplicated advertisements
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 19, 2017 at 8:43 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This reduces the verbosity and give a precise picture of how unique
>> each report is.
>> ---
>> monitor/packet.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 89 insertions(+)
>>
>> diff --git a/monitor/packet.c b/monitor/packet.c
>> index cc24165..4ed0faa 100644
>> --- a/monitor/packet.c
>> +++ b/monitor/packet.c
>> @@ -42,7 +42,9 @@
>> #include "lib/hci.h"
>> #include "lib/hci_lib.h"
>>
>> +#include "src/shared/mainloop.h"
>> #include "src/shared/util.h"
>> +#include "src/shared/queue.h"
>> #include "src/shared/btsnoop.h"
>> #include "display.h"
>> #include "bt.h"
>> @@ -100,6 +102,9 @@
>>
>> #define COLOR_PHY_PACKET              COLOR_BLUE
>>
>> +#define ADV_TIMEOUT                  3000
>> +#define ADV_MAX_CACHE                        100
>> +
>> static time_t time_offset = ((time_t) -1);
>> static int priority_level = BTSNOOP_PRIORITY_INFO;
>> static unsigned long filter_mask = 0;
>> @@ -267,11 +272,20 @@ void packet_select_index(uint16_t index)
>>
>> #define MAX_INDEX 16
>>
>> +struct adv_data {
>> +     struct bt_hci_evt_le_adv_report evt;
>> +     void *data;
>> +     size_t frame;
>> +     int timeout;
>> +     struct queue *cache;
>> +};
>> +
>> struct index_data {
>>       uint8_t  type;
>>       uint8_t  bdaddr[6];
>>       uint16_t manufacturer;
>>       size_t  frame;
>> +     struct queue *adv_cache;
>> };
>>
>> static struct index_data index_list[MAX_INDEX];
>> @@ -8587,12 +8601,86 @@ static void le_conn_complete_evt(const void *data, uint8_t size)
>>               assign_handle(le16_to_cpu(evt->handle), 0x01);
>> }
>>
>> +static void adv_free(void *data)
>> +{
>> +     struct adv_data *adv = data;
>> +
>> +     free(adv->data);
>> +     free(adv);
>> +}
>> +
>> +static bool match_adv(const void *data, const void *user_data)
>> +{
>> +     const struct adv_data *adv = data;
>> +     const struct bt_hci_evt_le_adv_report *evt = user_data;
>> +
>> +     if (memcmp(&adv->evt, evt, sizeof(*evt)))
>> +             return false;
>> +
>> +     return memcmp(adv->data, evt->data, evt->data_len) == 0;
>> +}
>> +
>> +static void adv_timeout(int id, void *data)
>> +{
>> +     struct adv_data *adv = data;
>> +
>> +     /* Remove from check (adv is freed after returning) */
>> +     queue_remove(adv->cache, adv);
>> +
>> +     mainloop_remove_timeout(adv->timeout);
>> +}
>> +
>> static void le_adv_report_evt(const void *data, uint8_t size)
>> {
>>       const struct bt_hci_evt_le_adv_report *evt = data;
>> +     struct index_data *idata = &index_list[index_current];
>> +     struct adv_data *match;
>> +     struct adv_data *adv;
>>       uint8_t evt_len;
>>       int8_t *rssi;
>>
>> +     if (!idata->adv_cache)
>> +             idata->adv_cache = queue_new();
>> +
>> +     adv = queue_remove_if(idata->adv_cache, match_adv, (void *) evt);
>> +     if (adv) {
>> +             /* Update cache and modify expire timeout */
>> +             if (mainloop_modify_timeout(adv->timeout, ADV_TIMEOUT) < 0) {
>> +                     mainloop_remove_timeout(adv->timeout);
>> +                     adv->timeout = mainloop_add_timeout(ADV_TIMEOUT,
>> +                                                     adv_timeout, adv,
>> +                                                     adv_free);
>> +             }
>> +             queue_push_head(idata->adv_cache, adv);
>> +             print_field("Duplicate of #%zu", adv->frame);
>> +             size = 0;
>> +             goto rssi;
>> +     }
>> +
>> +     match = new0(struct adv_data, 1);
>> +     match->evt = *evt;
>> +
>> +     match->data = malloc(evt->data_len);
>> +     memcpy(match->data, evt->data, evt->data_len);
>> +
>> +     match->cache = idata->adv_cache;
>> +     match->frame = idata->frame;
>> +     match->timeout = mainloop_add_timeout(ADV_TIMEOUT, adv_timeout, match,
>> +                                             adv_free);
>> +     if (match->timeout <= 0) {
>> +             print_field("Cannot cache: %s (%d)", strerror(-match->timeout),
>> +                                                     match->timeout);
>> +             adv_free(match);
>> +             goto print;
>> +     }
>
> for a tool like btmon since is clearly the wrong approach. If the wire is verbose, then so be it. If someone wants to filter via BPF, that is fine, but this magic is not scalable.

Wireshark and the like seems to be able to detect duplicated
referencing the frame it has occurred which is what Im attempting to
do here.

There doesn't seems to be a way to save context in BPF, the filter
runs on each packet, and even if we could build things like a packet
cache in BPF asm might not be the most trivial thing to maintain.

The scalable part I don't really get it, there are limits for both
number of entries and time they stay in cache so the lookups are quite
cheap actually and we can actually reduce the number even further if
we just maintain the last adv per address.

-- 
Luiz Augusto von Dentz
