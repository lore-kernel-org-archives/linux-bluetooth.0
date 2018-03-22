Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL3b6M5hnKpvGXXTB+q8Ma6wtC2SoC+_iKvTjtwGeSrLg@mail.gmail.com>
References: <20180321165900.7879-1-robert.lubas@silvair.com> <CABBYNZL3b6M5hnKpvGXXTB+q8Ma6wtC2SoC+_iKvTjtwGeSrLg@mail.gmail.com>
From: =?UTF-8?Q?Robert_Luba=C5=9B?= <robert.lubas@silvair.com>
Date: Thu, 22 Mar 2018 06:59:16 +0100
Message-ID: <CACgnnkmcaGymnV=ryM7OCzVhjdNQPSo8ecq1ao5MTtUDb6vYaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Mesh: Fix TTL in Config Heartbeat Publication Set
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Sorry, I have another thing in my my mind. DEFAULT_TTL was set to 0xFF
(not 0x77)
and this is out of valid range(my device does not  acknowledge the message)=
.
I will follow with V2.

About the extra formatting - I just took as a example the pub-set command.

with extra formatting config help looks like :
relay-get                                        Get relay
hb-pub-set <pub_addr> <count> <period> <ttl> <features> <net_idx>
                                                     Set heartbeat publish
hb-pub-get                                      Get heartbeat publish

without extra formatting:
relay-get                                        Get relay
hb-pub-set <pub_addr> <count> <period> <ttl> <features> <net_idx> Set
heartbeat publish
hb-pub-get                                     Get heartbeat publish

What do you think?

Robert

2018-03-21 19:39 GMT+01:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Robert,
>
> On Wed, Mar 21, 2018 at 6:59 PM, Robert Luba=C5=9B <robert.lubas@silvair.=
com> wrote:
>> In 4.2.17.4 Heartbeat Publication TTL value range is 0x00-0x7F.
>> In cmd_hb_pub_set heartbeat ttl was set to DEFAULT_TTL 0x77, this
>> patch fix this by adding ttl param to hb-pub-set.
>
> I don't follow, is 0x77 not valid? It should be if the range is really
> 0x00-0x7F.
>
>> ---
>>  mesh/config-client.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/mesh/config-client.c b/mesh/config-client.c
>> index 19e617d62..9757e2625 100644
>> --- a/mesh/config-client.c
>> +++ b/mesh/config-client.c
>> @@ -1042,7 +1042,7 @@ static void cmd_hb_pub_set(int argc, char *argv[])
>>         n =3D mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
>>
>>         parm_cnt =3D read_input_parameters(argc, argv);
>> -       if (parm_cnt !=3D 5) {
>> +       if (parm_cnt !=3D 6) {
>>                 bt_shell_printf("Bad arguments: %s\n", argv[1]);
>>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>>         }
>> @@ -1056,12 +1056,12 @@ static void cmd_hb_pub_set(int argc, char *argv[=
])
>>         /* Period Log */
>>         msg[n++] =3D parms[2];
>>         /* Heartbeat TTL */
>> -       msg[n++] =3D DEFAULT_TTL;
>> +       msg[n++] =3D parms[3];
>>         /* Features */
>> -       put_le16(parms[3], msg + n);
>> +       put_le16(parms[4], msg + n);
>>         n +=3D 2;
>>         /* NetKey Index */
>> -       put_le16(parms[4], msg + n);
>> +       put_le16(parms[5], msg + n);
>>         n +=3D 2;
>>
>>         if (!config_send(msg, n)) {
>> @@ -1167,8 +1167,9 @@ static const struct bt_shell_menu cfg_menu =3D {
>>                                                 "Set relay"},
>>         {"relay-get",           NULL,                   cmd_relay_get,
>>                                                 "Get relay"},
>> -       {"hb-pub-set", "<pub_addr> <count> <period> <features> <net_idx>=
",
>> -                               cmd_hb_pub_set,     "Set heartbeat publi=
sh"},
>> +       {"hb-pub-set", "<pub_addr> <count> <period> <ttl> <features> "
>> +                               "<net_idx>",
>> +                               cmd_hb_pub_set, "\n\t\t\t\t\t\t  Set hea=
rtbeat publish"},
>
> I don't really like the idea of having extra formatting on the command
> description, bt_shell should do the right thing and if that doesn't
> fit in the terminal it should wrap around automatically.
>
>>         {"hb-pub-get",           NULL,                   cmd_hb_pub_get,
>>                                                 "Get heartbeat publish"}=
,
>>         {"hb-sub-set", "<src_addr> <dst_addr> <period>",
>> --
>> 2.11.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Robert Luba=C5=9B
Software Developer

Silvair by Seed Labs
Jasnog=C3=B3rska 44
31-358 Krakow
POLAND

www.silvair.com
