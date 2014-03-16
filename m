Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2427889.XSNVnQ96lj@leonov>
References: <1394804979-7270-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1394804979-7270-3-git-send-email-lukasz.rymanowski@tieto.com>
	<2427889.XSNVnQ96lj@leonov>
Date: Sun, 16 Mar 2014 23:33:29 +0100
Message-ID: <CAN_7+YbEcAiMHzsRoqPzUfqGqoU5-mNjNpp5-0=QWA15YYFUcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] android/gatt: Use Core profile for LE scan
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Mar 16, 2014 at 5:26 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi,
>
> On Friday 14 of March 2014 14:49:37 Lukasz Rymanowski wrote:
>> From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
>>
>> This makes gatt capable of triggering LE scan using functionality
>> exposed by Core API. GATT registers its own callbacks for discovering
>> events.
>> ---
>>  android/gatt.c | 102
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++-- 1 file changed,
>> 99 insertions(+), 3 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index b566470..38f7c1b 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -32,10 +32,12 @@
>>
>>  #include "ipc.h"
>>  #include "ipc-common.h"
>> -#include "lib/bluetooth.h"
>> +#include "lib/sdp.h"
>> +#include "bluetooth.h"
>>  #include "gatt.h"
>>  #include "src/log.h"
>>  #include "hal-msg.h"
>> +#include "utils.h"
>>  #include "src/shared/util.h"
>>  #include "src/shared/queue.h"
>>
>> @@ -47,6 +49,7 @@ struct gatt_client {
>>  static struct ipc *hal_ipc = NULL;
>>  static bdaddr_t adapter_addr;
>>  static struct queue *gatt_clients = NULL;
>> +static struct queue *scan_clients = NULL;
>>
>>  static bool match_client_by_uuid(const void *data, const void *user_data)
>>  {
>> @@ -64,6 +67,36 @@ static bool match_client_by_id(const void *data, const
>> void *user_data) return client->id == exp_id;
>>  }
>>
>> +static bool match_by_value(const void *data, const void *user_data)
>> +{
>> +     return data == user_data;
>> +}
>
> This is not directly related with this patch but I wonder if we should have
> API in queue for that...
>
>> +
>> +static void le_device_found_handler(bdaddr_t *addr, uint8_t addr_type, int
>> rssi, +                                       uint16_t eir_len, const void *eir)
>> +{
>> +     uint8_t buf[IPC_MTU];
>> +     struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
>> +     char bda[18];
>> +
>> +     if (queue_isempty(scan_clients))
>> +             return;
>> +
>> +     ba2str(addr, bda);
>> +     DBG("gatt: LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi,
>> +                                                     eir ? true : false);
>
> No need to prefix debugs, function name will be printed and is self
> explanatory.
>
>> +
>> +     bdaddr2android(addr, ev->bda);
>> +     ev->rssi = rssi;
>> +     ev->len = eir_len;
>> +
>> +     memcpy(ev->adv_data, eir, ev->len);
>> +
>> +     ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>> +                                             HAL_EV_GATT_CLIENT_SCAN_RESULT,
>> +                                             sizeof(ev) + eir_len, ev);
>
> Use ev->len instead of eir_len here.
>
>> +}
>> +
>>  static void handle_client_register(const void *buf, uint16_t len)
>>  {
>>       const struct hal_cmd_gatt_client_register *cmd = buf;
>> @@ -124,6 +157,13 @@ static void handle_client_unregister(const void *buf,
>> uint16_t len) goto failed;
>>       }
>>
>> +     queue_remove_if(scan_clients, match_by_value,
>> +                                             INT_TO_PTR(cmd->client_if));
>> +
>> +     /* If there is no client interesting in scan, just stop it */
>> +     if (queue_isempty(scan_clients))
>> +             bt_le_discovery_stop(NULL);
>> +
>>       free(cl);
>>       status = HAL_STATUS_SUCCESS;
>>
>> @@ -134,10 +174,59 @@ failed:
>>
>>  static void handle_client_scan(const void *buf, uint16_t len)
>>  {
>> -     DBG("");
>> +     const struct hal_cmd_gatt_client_scan *cmd = buf;
>> +     uint8_t status;
>> +     void *registered;
>> +     void *l;
>> +
>> +     DBG("new state %d", cmd->start);
>>
>> +     registered = queue_find(gatt_clients, match_client_by_id,
>> +                                             INT_TO_PTR(cmd->client_if));
>> +     /* Turn off scan */
>> +     if (!cmd->start) {
>> +             if (registered)
>> +                     queue_remove_if(scan_clients, match_by_value,
>> +                                             INT_TO_PTR(cmd->client_if));
>> +
>> +             if (queue_isempty(scan_clients)) {
>> +                     DBG("Stopping LE SCAN");
>> +                     bt_le_discovery_stop(NULL);
>> +             }
>> +
>> +             status = HAL_STATUS_SUCCESS;
>> +             goto reply;
>> +     }
>> +
>> +     /* If device already do scan, reply with success and avoid to add it
>> +      * again to the list
>> +      */
>> +     l = queue_find(scan_clients, match_by_value,
>> +                                             INT_TO_PTR(cmd->client_if));
>> +     if (l) {
>> +             status = HAL_STATUS_SUCCESS;
>> +             goto reply;
>> +     }
>> +
>> +     if (!bt_le_discovery_start(le_device_found_handler)) {
>> +             error("gatt: LE scan switch failed");
>> +             status = HAL_STATUS_FAILED;
>> +             goto reply;
>> +     }
>> +
>> +     /* Add scan client to the list if its registered */
>> +     if (registered && !queue_push_tail(scan_clients,
>> +                                             INT_TO_PTR(cmd->client_if))) {
>> +             error("gatt: Cannot push scan client");
>> +             status = HAL_STATUS_FAILED;
>> +             goto reply;
>> +     }
>> +
>> +     status = HAL_STATUS_SUCCESS;
>> +
>> +reply:
>>       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_SCAN,
>> -                                                     HAL_STATUS_FAILED);
>> +                                                                     status);
>>  }
>>
>>  static void handle_client_connect(const void *buf, uint16_t len)
>> @@ -530,6 +619,13 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t
>> *addr) return false;
>>       }
>>
>> +     scan_clients = queue_new();
>> +     if (!scan_clients) {
>> +             error("gatt: Cannot allocate scan_clients");
>> +             queue_destroy(gatt_clients, NULL);
>> +             return false;
>> +     }
>> +
>>       return true;
>>  }
>
Next version will fix all those issues.

> --
> BR
> Szymon Janc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
