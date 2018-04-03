Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] Mesh: Add Config Beacon to Configuration Model
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20180402192920.19111-1-robert.lubas@silvair.com>
 <CABBYNZ+t6tETeaFq1ABionGg0KNR+Oaz1cVt9seybnBJQXKMNw@mail.gmail.com>
From: Robert Lubas <robert.lubas@silvair.com>
Message-ID: <cc368289-3c04-2bb8-07fe-84b9449b6ddd@silvair.com>
Date: Tue, 3 Apr 2018 14:09:12 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+t6tETeaFq1ABionGg0KNR+Oaz1cVt9seybnBJQXKMNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 04/03/2018 10:18 AM, Luiz Augusto von Dentz wrote:
> Hi Robert,
> 
> On Mon, Apr 2, 2018 at 10:29 PM, Robert Lubaś <robert.lubas@silvair.com> wrote:
>> This patch adds two commands (set and get) to menu config and handles the
>> incomming status message.
>> ---
>>   mesh/config-client.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/mesh/config-client.c b/mesh/config-client.c
>> index 95297bfee..4e5e06258 100644
>> --- a/mesh/config-client.c
>> +++ b/mesh/config-client.c
>> @@ -179,6 +179,13 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
>>                                  mesh_status_str(data[0]));
>>                  break;
>>
>> +       case OP_CONFIG_BEACON_STATUS:
>> +               if (len != 1)
>> +                       return true;
>> +               bt_shell_printf("Node %4.4x Config Beacon Status 0x%02x\n",
>> +                               src, data[0]);
>> +               break;
>> +
>>          case OP_CONFIG_RELAY_STATUS:
>>                  if (len != 2)
>>                          return true;
>> @@ -689,6 +696,37 @@ static void cmd_bind(int argc, char *argv[])
>>          return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>>   }
>>
>> +static void cmd_beacon_set(int argc, char *argv[])
>> +{
>> +       uint16_t n;
>> +       uint8_t msg[2 + 1];
>> +       int parm_cnt;
>> +
>> +       if (!verify_config_target(target))
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +
>> +       n = mesh_opcode_set(OP_CONFIG_BEACON_SET, msg);
>> +
>> +       parm_cnt = read_input_parameters(argc, argv);
>> +       if (parm_cnt != 1) {
>> +               bt_shell_printf("bad arguments\n");
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       msg[n++] = parms[0];
>> +
>> +       if (!config_send(msg, n)) {
>> +               bt_shell_printf("Failed to send \"SET BEACON\"\n");
>> +               return;
>> +       }
>> +
>> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);}
> 
> You should have a like break before }
> 
>> +
>> +static void cmd_beacon_get(int argc, char *argv[])
>> +{
>> +       cmd_default(OP_CONFIG_BEACON_GET);
>> +}
>> +
>>   static void cmd_ident_set(int argc, char *argv[])
>>   {
>>          uint16_t n;
>> @@ -1178,6 +1216,10 @@ static const struct bt_shell_menu cfg_menu = {
>>                                                  "Set node identity state"},
>>          {"ident-get",           "<net_idx>",            cmd_ident_get,
>>                                                  "Get node identity state"},
>> +       {"beacon-set",           "<state>",             cmd_beacon_set,
>> +                                               "Set node identity state"},
>> +       {"beacon-get",           NULL,                  cmd_beacon_get,
>> +                                               "Get node beacon state"},
>>          {"relay-set",           "<relay> <rexmt count> <rexmt steps>",
>>                                                  cmd_relay_set,
>>                                                  "Set relay"},
>> --
>> 2.11.0
> 
> Other than this looks good, lets see if Inga has anything to comment.
> 
The broken line goes to V2.

Thanks
