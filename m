Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180327131932epcms5p319b3d9a169914cf4c632970b0637fad1@epcms5p3>
References: <1521445336-15582-1-git-send-email-a.rai@samsung.com>
 <CGME20180319074231epcas2p40d1a1ce4df102b678bf18c95af49a4c4@epcms5p3>
 <1521558707.3681.6.camel@intel.com> <20180327131932epcms5p319b3d9a169914cf4c632970b0637fad1@epcms5p3>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Mar 2018 17:08:41 +0300
Message-ID: <CABBYNZ+bhX0bkuQC56Udr0T5J8Jks-9k4LrdMB1f3C4dfu09KQ@mail.gmail.com>
Subject: Re: Re: [PATCH v3] Mesh: add 'node-reset' command
To: Atul Rai <a.rai@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        Anupam Roy <anupam.r@samsung.com>,
        SACHIN DEV SHARMA <sachin.dev@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Atul,

On Tue, Mar 27, 2018 at 4:19 PM, Atul Kumar Rai <a.rai@samsung.com> wrote:
> Ping.
>
>> Hi Atul,
>>
>> On Mon, 2018-03-19 at 13:12 +0530, Atul Rai wrote:
>>> This patch adds 'node-reset' command which can be used to reset a
>>> node (other than a Provisioner) and remove it from the network.
>>> ---
>>>  mesh/config-client.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/mesh/config-client.c b/mesh/config-client.c
>>> index 19e617d..a6cd87e 100644
>>> --- a/mesh/config-client.c
>>> +++ b/mesh/config-client.c
>>> @@ -342,6 +342,17 @@ static bool client_msg_recvd(uint16_t src,
>>> uint8_t *data,
>>>                  bt_shell_printf("Min Hops\t%2.2x\n", data[7]);
>>>                  bt_shell_printf("Max Hops\t%2.2x\n", data[8]);
>>>                  break;
>>> +
>>> +        /* Per Mesh Profile 4.3.2.54 */
>>> +        case OP_NODE_RESET_STATUS:
>>> +                bt_shell_printf("Node %4.4x reset status %s\n",
>>> +                                src, mesh_status_str(data[0]));
>>> +
>>> +                net_release_address(node_get_primary(node),
>>> +                                (node_get_num_elements(node)));
>>> +                /* TODO: Remove node info from database */
>>> +                node_free(node);
>>> +                break;
>>>          }
>>>
>>>          return true;
>>> @@ -1124,6 +1135,11 @@ static void cmd_ttl_get(int argc, char
>>> *argv[])
>>>          cmd_default(OP_CONFIG_DEFAULT_TTL_GET);
>>>  }
>>>
>>> +static void cmd_node_reset(int argc, char *argv[])
>>> +{
>>> +        cmd_default(OP_NODE_RESET);
>>> +}
>>> +
>>>  static const struct bt_shell_menu cfg_menu = {
>>>          .name = "config",
>>>          .desc = "Configuration Model Submenu",
>>> @@ -1179,6 +1195,8 @@ static const struct bt_shell_menu cfg_menu = {
>>>                                  cmd_sub_add,    "Add subscription"},
>>>          {"sub-get", "<ele_addr> <model id>",
>>>                                  cmd_sub_get,    "Get subscription"},
>>> +        {"node-reset",                NULL,                    cmd_n
>>> ode_reset,
>>> +                                "Reset a node and remove it from
>>> network"},
>>>          {} },
>>>  };
>>>
>> This looks fine.
>> Thanks,
>> Inga

Applied, thanks.

-- 
Luiz Augusto von Dentz
