Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C01238DC7
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770119; cv=none; b=PqvnZR4gXUGEPWKwYs+M3/GUlXh0s7wmFsukd+H0+7pRteArYeP+mKo/f9Xtnl1bBIPxPsk3ug+sgRQSosAPaM9n7jV2zPkvHa6P8540EYxRzhShB9qvdENr5hJzQV6fPGynNKcgkOb0rOSwXvlRK4rlNZTZkDwz02uaHCTuz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770119; c=relaxed/simple;
	bh=vpX6c8Q/kiuZehSRrPePVmK9k7hoxQ1CHnRB4lEdTn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMLiGHHPFI5EncmAC1jntfyCDCOuGxowYVmSTJFktJ6D2vI56pLiOCMMl/urFmK5OAM6JntyVSu9nEIXR3FeBP2rt1PSvdqOBJDIvJpseQtTGbwL4fkq/OzvvCMnsP6p/UqMPT9DwsUcruOC+7JN87Crc/scwUclq20Kb0ok3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iRQxNSe9; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iRQxNSe9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=JzU9JEhFLemCsdtPjg3mYnzXUzHiHaJVBhw3JNIFQw8=;
	b=iRQxNSe97tdddx3oPKgIRKw3OZ2xtkPD68Y+E288O+zwCxGK13J8msGebBXwzO
	YHCT1oUJY9N9NMij/Cmp1gsHiIi43ct/YokqOJa220jD+exe//d4/+3DrsyjtihY
	aB4QyPMal0y0amFlEQ3NBeHMDEz3wwBrgaHys2ZGyhxE8=
Received: from [192.168.50.76] (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3P8ak481mkcgEBQ--.40136S2;
	Tue, 27 Aug 2024 22:33:09 +0800 (CST)
Message-ID: <4b897b9f-8ea5-45ad-9a41-faae01d2ed18@126.com>
Date: Tue, 27 Aug 2024 22:33:08 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
Content-Language: en-GB
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Robin Candau <antiz@archlinux.org>, quic_chejiang@quicinc.com,
 linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
References: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
 <55903fdb-e970-4b89-b620-daa93bad7811@archlinux.org>
 <CABBYNZ+X1gWovfui7Vyaag80PFz_1q4A_F7r=wpgF_gm9f9orA@mail.gmail.com>
 <e4be48f5-1139-4871-a229-8dae7a7d745f@126.com>
 <CABBYNZK6qYdvAkKJDTfgxOxC2+qBxRriaprH3ooxV0jRMsf8fQ@mail.gmail.com>
From: Yao Xiao <xiaokeqinhealth@126.com>
In-Reply-To: <CABBYNZK6qYdvAkKJDTfgxOxC2+qBxRriaprH3ooxV0jRMsf8fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P8ak481mkcgEBQ--.40136S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3CF1kGr13Zw1rCryfXr1rtFb_yoW8JF15uo
	WFvr1fZr4fJr1UAayUA348XFWagaykKa15urWUA39rWa12qa43tFyrJw4rXa9xGF1UKwnr
	t34xKryfZrZrJF4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUz9a9UUUUU
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6AZI1WVLdQnUQgAAs3

Hi Luiz,

On 2024/8/27 20:52, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Aug 27, 2024 at 3:41 AM Yao Xiao <xiaokeqinhealth@126.com> wrote:
>>
>> Hi luiz,
>> The kernel should always report the correct address type for all kinds
>> of keys. Older kernels ignore the derivation of keys, which prevents the
>> user layer from knowing the correct address type. This can cause a lot
>> of confusion for users. For example, when a user connects to a
>> traditional Bluetooth audio device, due to the default activation of key
>> derivation, bluetoothd reports both BREDR and BLE pairing and binding,
>> and the address is updated to LE public. When the user actively calls
>> the Connect method of org.bluez.Device1 to reconnect, sometimes the
>> address type is set to LE public, leading to a failed connection, and
>> vice versa.
> 
> The correct address type can only be the ones listed on mgmt-api
> otherwise we are breaking APIs, also except if there are some new case
> I don't know and Load Keys and Load LTK are bearer specific.
> 
>> We should enable bluetoothd to know the reason for the generation of
>> keys as much as possible. Older kernels always assume the address type
>> of linkey is BREDR, and ltk/irk/csrk are LE public. Therefore, we can
>> use this as a basis for judgment, allowing bluetoothd to handle various
>> issues, such as reloading keys and handling unpaired devices. Below is a
>> pseudo-code that is not running in practice but just a thought. Please
>> help review it.
> 
> Yeah, and what exactly was wrong with that? What you mention about
> having keys for both BR/EDR and LE public is not an issue, that
> basically the very definition of a dual-mode device and bluetoothd
> shall be able to tell when to connect to BR/EDR and LE public, if it
> doesn't we shall fix that and not start breaking APIs.
Returning to my original issue: When BlueZ acts as a sink device and a 
phone connects to it, pairs successfully, and derives related keys, 
BlueZ reports to the user layer that bonded (both bredr_state.bonded and 
dev->le_state.bonded) are true, and addr_type is LE_PUBLIC. If the 
device restarts and the org.bluez.Device1:Connect method is called to 
reconnect to the phone, according to the rules in select_conn_bearer, 
addr_type will be set to LE_PUBLIC, leading to a failed reconnection 
when device_connect_le is called.

In this situation, how should bluetoothd choose the correct address type 
when it doesn't know the physical bearer layer? Should there be a 
configuration option to turn key derivation on or off? Additionally, 
there's another use case: When a phone connects to a BlueZ device, it 
continuously transmits custom data via BLE and music via traditional 
Bluetooth (BREDR). If the user only wants to unpair the BREDR, it may 
cause the BLE connection to be disconnected as well, leading to data 
transmission interruption. Should we also consider turning off key 
derivation in this scenario?

> 
>> -------------------------------------------
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 85ddfc165..babe7c9b2 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -4958,6 +4958,7 @@ static void load_devices(struct btd_adapter *adapter)
>>            struct irk_info *irk_info;
>>            struct conn_param *param;
>>            uint8_t bdaddr_type;
>> +        bool derived_key;
>>
>>            if (entry->d_type == DT_UNKNOWN)
>>                entry->d_type = util_get_dt(dirname, entry->d_name);
>> @@ -4976,10 +4977,21 @@ static void load_devices(struct btd_adapter
>> *adapter)
>>                g_clear_error(&gerr);
>>            }
>>
>> +        derived_key = g_key_file_get_boolean(key_file, "General",
>> +                                "DerivedKey", NULL);
>> +
>> +        /* For link key */
>>            bdaddr_type = get_addr_type(key_file);
>> +        if (!derived_key)
>> +            bdaddr_type = BDADDR_BREDR;
>>
>>            key_info = get_key_info(key_file, entry->d_name, bdaddr_type);
>>
>> +        /* For ltk/irk/csrk */
>> +        bdaddr_type = get_addr_type(key_file);
>> +        if (!derived_key)
>> +            bdaddr_type = BDADDR_LE_PUBLIC;
>> +
>>            ltk_info = get_ltk_info(key_file, entry->d_name, bdaddr_type);
>>
>>            peripheral_ltk_info = get_peripheral_ltk_info(key_file,
>> @@ -8673,6 +8685,12 @@ static void new_link_key_callback(uint16_t index,
>> uint16_t length,
>>            return;
>>        }
>>
>> +    /*
>> +     * For older kernels, the address type is always BREDR.
>> +     */
>> +    if (addr->type == BDADDR_LE_PUBLIC)
>> +        device->derived_key = true;
>> +
>>        if (ev->store_hint) {
>>            const struct mgmt_link_key_info *key = &ev->key;
>>
>> @@ -8791,6 +8809,12 @@ static void new_long_term_key_callback(uint16_t
>> index, uint16_t length,
>>            return;
>>        }
>>
>> +    /*
>> +     * For older kernels, the address type is always BDADDR_LE_PUBLIC.
>> +     */
>> +    if (addr->type == BDADDR_BREDR)
>> +        device->derived_key = true;
>> +
>>        /*
>>         * Some older kernel versions set store_hint for long term keys
>>         * from resolvable and unresolvable random addresses, but there
>> @@ -8855,6 +8879,9 @@ static void new_csrk_callback(uint16_t index,
>> uint16_t length,
>>            return;
>>        }
>>
>> +    if (addr->type == BDADDR_BREDR)
>> +        device->derived_key = true;
>> +
>>        device_set_csrk(device, key->val, 0, key->type, ev->store_hint);
>>    }
>>
>> @@ -8941,6 +8968,9 @@ static void new_irk_callback(uint16_t index,
>> uint16_t length,
>>            return;
>>        }
>>
>> +    if (addr->type == BDADDR_BREDR)
>> +        device->derived_key = true;
>> +
>>        device_update_addr(device, &addr->bdaddr, addr->type);
>>
>>        if (duplicate)
>> diff --git a/src/device.c b/src/device.c
>> index a1dc0750c..062b9c49d 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -272,6 +272,7 @@ struct btd_device {
>>        struct csrk_info *remote_csrk;
>>        struct ltk_info *ltk;
>>        struct queue    *sirks;
>> +    bool        derived_key;            /* key is derived. */
>>
>>        sdp_list_t    *tmp_records;
>>
>> @@ -482,6 +483,9 @@ static gboolean store_device_info_cb(gpointer user_data)
>>        g_key_file_set_boolean(key_file, "General", "Blocked",
>>                                device->blocked);
>>
>> +    g_key_file_set_boolean(key_file, "General", "DerivedKey",
>> +                            device->derived_key);
>> +
>>        if (device->wake_override != WAKE_FLAG_DEFAULT) {
>>            g_key_file_set_boolean(key_file, "General", "WakeAllowed",
>>                           device->wake_override ==
>> @@ -1829,7 +1833,11 @@ static void bonding_request_cancel(struct
>> bonding_req *bonding)
>>        struct btd_device *device = bonding->device;
>>        struct btd_adapter *adapter = device->adapter;
>>
>> -    adapter_cancel_bonding(adapter, &device->bdaddr, device->bdaddr_type);
>> +    if (device->derived_key) {
>> +        adapter_cancel_bonding(adapter, &device->bdaddr, BDADDR_BREDR);
>> +        adapter_cancel_bonding(adapter, &device->bdaddr, BDADDR_LE_PUBLIC);
>> +    } else
>> +        adapter_cancel_bonding(adapter, &device->bdaddr,
>> device->bdaddr_type);
>>    }
>>
>>    static void dev_disconn_service(gpointer a, gpointer b)
>> @@ -3196,12 +3204,19 @@ static DBusMessage
>> *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
>>    {
>>        struct btd_device *device = data;
>>        struct bonding_req *req = device->bonding;
>> +    uint8_t bdaddr_type;
>>
>>        DBG("");
>>
>>        if (!req) {
>> -        btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
>> -                        device->bdaddr_type);
>> +        if (device->derived_key) {
>> +            btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
>> +                            BDADDR_BREDR);
>> +            btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
>> +                            BDADDR_LE_PUBLIC);
>> +        } else
>> +            btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
>> +                            device->bdaddr_type);
>>            return btd_error_does_not_exist(msg);
>>        }
>>
>> @@ -3833,6 +3848,9 @@ next:
>>            gerr = NULL;
>>        }
>>
>> +    device->derived_key = g_key_file_get_boolean(key_file, "General",
>> +                            "DerivedKey", NULL);
>> +
>>        if (store_needed)
>>            store_device_info(device);
>>    }
>>
>> On 2024/8/27 5:12, Luiz Augusto von Dentz wrote:
>>> Hi Xiao,
>>>
>>> On Fri, Dec 15, 2023 at 8:06 PM Robin Candau <antiz@archlinux.org> wrote:
>>>>
>>>> On 12/11/23 17:27, Xiao Yao wrote:
>>>>
>>>> From: Xiao Yao <xiaoyao@rock-chips.com>
>>>>
>>>> According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3,
>>>> Part H, 2.4.24/2.4.25, The LE LTK and BR/EDR link keys can be
>>>> converted between each other, so the addr type can be either
>>>> BREDR or LE, so fix it.
>>>>
>>>> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
>>>> ---
>>>>    src/adapter.c | 20 ++++++++++++++------
>>>>    1 file changed, 14 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/src/adapter.c b/src/adapter.c
>>>> index 86fff72bc..ee70b00d2 100644
>>>> --- a/src/adapter.c
>>>> +++ b/src/adapter.c
>>>> @@ -170,6 +170,7 @@ static GSList *conn_fail_list = NULL;
>>>>
>>>>    struct link_key_info {
>>>>     bdaddr_t bdaddr;
>>>> + uint8_t bdaddr_type;
>>>>     unsigned char key[16];
>>>>     uint8_t type;
>>>>     uint8_t pin_len;
>>>> @@ -3964,7 +3965,9 @@ static bool is_blocked_key(uint8_t key_type, uint8_t *key_value)
>>>>     return false;
>>>>    }
>>>>
>>>> -static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
>>>> +static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer,
>>>> + uint8_t bdaddr_type)
>>>> +
>>>>    {
>>>>     struct link_key_info *info = NULL;
>>>>     char *str;
>>>> @@ -3976,6 +3979,7 @@ static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
>>>>     info = g_new0(struct link_key_info, 1);
>>>>
>>>>     str2ba(peer, &info->bdaddr);
>>>> + info->bdaddr_type = bdaddr_type;
>>>>
>>>>     if (!strncmp(str, "0x", 2))
>>>>     str2buf(&str[2], info->key, sizeof(info->key));
>>>> @@ -4343,7 +4347,7 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
>>>>     struct link_key_info *info = l->data;
>>>>
>>>>     bacpy(&key->addr.bdaddr, &info->bdaddr);
>>>> - key->addr.type = BDADDR_BREDR;
>>>> + key->addr.type = info->bdaddr_type;
>>>>     key->type = info->type;
>>>>     memcpy(key->val, info->key, 16);
>>>>     key->pin_len = info->pin_len;
>>>> @@ -4598,14 +4602,18 @@ static void load_conn_params(struct btd_adapter *adapter, GSList *params)
>>>>     btd_error(adapter->dev_id, "Load connection parameters failed");
>>>>    }
>>>>
>>>> -static uint8_t get_le_addr_type(GKeyFile *keyfile)
>>>> +static uint8_t get_addr_type(GKeyFile *keyfile)
>>>>    {
>>>>     uint8_t addr_type;
>>>>     char *type;
>>>>
>>>> + /* The AddressType is written to file only When dev->le is
>>>> + * set to true, as referenced in the update_technologies().
>>>> + * Therefore, When type is NULL, it default to BDADDR_BREDR.
>>>> + */
>>>>     type = g_key_file_get_string(keyfile, "General", "AddressType", NULL);
>>>>     if (!type)
>>>> - return BDADDR_LE_PUBLIC;
>>>> + return BDADDR_BREDR;
>>>>
>>>>     if (g_str_equal(type, "public"))
>>>>     addr_type = BDADDR_LE_PUBLIC;
>>>> @@ -4914,9 +4922,9 @@ static void load_devices(struct btd_adapter *adapter)
>>>>     g_clear_error(&gerr);
>>>>     }
>>>>
>>>> - key_info = get_key_info(key_file, entry->d_name);
>>>> + bdaddr_type = get_addr_type(key_file);
>>>>
>>>> - bdaddr_type = get_le_addr_type(key_file);
>>>> + key_info = get_key_info(key_file, entry->d_name, bdaddr_type);
>>>>
>>>>     ltk_info = get_ltk_info(key_file, entry->d_name, bdaddr_type);
>>>>
>>>>
>>>> Hello,
>>>>
>>>> It seems like the above commit introduced a regression where the initial auto-connect for Bluetooth devices doesn't work anymore.
>>>>
>>>> Indeed, at system startup, starting a Bluetooth device will cause it to go in a "connected/disconnected" state loop, requiring to initialize a manual connection first (with sometimes multiple attempts needed) before getting it connected correctly and working as intended.
>>>>
>>>> `systemctl status bluetooth` reports the following error:
>>>>
>>>> [...]
>>>> déc. 15 11:03:18 Arch-Desktop bluetoothd[592]: Failed to load link keys for hci0: Invalid Parameters (0x0d)
>>>> [...]
>>>>
>>>> I bisected the bug with `git bisect` and it pointed out this commit [1] as the "faulty" one.
>>>> I can confirm that reverting it solves the issue.
>>>>
>>>> I reported this bug including details in the GitHub repo [2].
>>>>
>>>> I remain available if any additional information are needed.
>>>>
>>>> [1] https://github.com/bluez/bluez/commit/d5536e0cd431e22be9a1132be6d4af2445590633
>>>> [2] https://github.com/bluez/bluez/issues/686
>>>>
>>>> --
>>>> Regards,
>>>> Robin Candau / Antiz
>>>
>>> Perhaps related to:
>>> https://github.com/bluez/bluez/issues/875#issuecomment-2311100872?
>>
> 
> 

