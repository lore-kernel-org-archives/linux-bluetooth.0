Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ V2] Mesh: Fix TTL in Config Heartbeat Publication
 Set
To: "Gix, Brian" <brian.gix@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20180322104442.27650-1-robert.lubas@silvair.com>
 <EC1DC23A-0357-4500-939A-98229F1BF561@intel.com>
From: Robert Lubas <robert.lubas@silvair.com>
Message-ID: <fbdff2a6-8724-0372-0c2b-15cd34d2588c@silvair.com>
Date: Fri, 23 Mar 2018 12:20:00 +0100
MIME-Version: 1.0
In-Reply-To: <EC1DC23A-0357-4500-939A-98229F1BF561@intel.com>
Content-Type: text/plain; charset=windows-1250; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 03/22/2018 10:33 PM, Gix, Brian wrote:
> I am unable to look at all the code in context at the moment, but using the DEFAULT_TTL (0xff) for any TTL value, will automatically get replaced with whatever the default TTL has been set to. It is a handy value which means “use the system setting” without needing to look it up.
> 
>> On Mar 22, 2018, at 3:45 AM, Robert Lubaœ <robert.lubas@silvair.com> wrote:
>>
>> In Mesh Profile spec 4.2.17.4 Heartbeat Publication TTL value range is
>> 0x00-0x7F. In cmd_hb_pub_set heartbeat ttl was set to DEFAULT_TTL 0xFF, this
>> patch fix this by adding ttl param to hb-pub-set.
>> ---
>> mesh/config-client.c | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/mesh/config-client.c b/mesh/config-client.c
>> index 19e617d62..0b5b8677b 100644
>> --- a/mesh/config-client.c
>> +++ b/mesh/config-client.c
>> @@ -1042,7 +1042,7 @@ static void cmd_hb_pub_set(int argc, char *argv[])
>>     n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
>>
>>     parm_cnt = read_input_parameters(argc, argv);
>> -    if (parm_cnt != 5) {
>> +    if (parm_cnt != 6) {
>>         bt_shell_printf("Bad arguments: %s\n", argv[1]);
>>         return bt_shell_noninteractive_quit(EXIT_FAILURE);
>>     }
>> @@ -1056,12 +1056,12 @@ static void cmd_hb_pub_set(int argc, char *argv[])
>>     /* Period Log */
>>     msg[n++] = parms[2];
>>     /* Heartbeat TTL */
>> -    msg[n++] = DEFAULT_TTL;
>> +    msg[n++] = parms[3];
>>     /* Features */
>> -    put_le16(parms[3], msg + n);
>> +    put_le16(parms[4], msg + n);
>>     n += 2;
>>     /* NetKey Index */
>> -    put_le16(parms[4], msg + n);
>> +    put_le16(parms[5], msg + n);
>>     n += 2;
>>
>>     if (!config_send(msg, n)) {
>> @@ -1167,8 +1167,8 @@ static const struct bt_shell_menu cfg_menu = {
>>                         "Set relay"},
>>     {"relay-get",           NULL,                   cmd_relay_get,
>>                         "Get relay"},
>> -    {"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>",
>> -                cmd_hb_pub_set,     "Set heartbeat publish"},
>> +    {"hb-pub-set", "<pub_addr> <count> <period> <ttl> <features> <net_idx>",
>> +                cmd_hb_pub_set,    "Set heartbeat publish"},
>>     {"hb-pub-get",           NULL,                   cmd_hb_pub_get,
>>                         "Get heartbeat publish"},
>>     {"hb-sub-set", "<src_addr> <dst_addr> <period>",
>> -- 
>> 2.11.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
I see your point. You know the mesh specification very well, but I will 
just refer to it to construct the reply. The Mesh Profile specification 
says: if the publish TTL is set to 0xFF the message use the Default TTL 
(4.2.2.5). The Default TTL valid values are 0x00, 0x02-0x7F. Prohibited 
are 0x01, 0x80-0x7FF (4.2.7).

However in terms of Heartbeat publication TTL the valid values are 
0x00-0x7F. Prohibited are 0x80-0xFF (4.2.17.4). Taking into account 
valid ranges the heartbeat TTL should be masked with 0x7F or in case of 
0xFF the node Default TTL from db should be used.

I think that it will be helpful e.g. to assess the basic reliability of 
the mesh network having the heartbeat publication TTL as a parameter. 
Then, for example you can very easy build the metric which depends on TTL.
