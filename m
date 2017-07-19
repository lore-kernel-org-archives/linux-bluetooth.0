Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <EA363361-431A-4DA1-A37E-8D38A98D584F@holtmann.org>
References: <20170718164627.20114-1-luiz.dentz@gmail.com> <20170718164627.20114-4-luiz.dentz@gmail.com>
 <EA363361-431A-4DA1-A37E-8D38A98D584F@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Jul 2017 16:08:27 +0300
Message-ID: <CABBYNZK8U0hnusA=Yfyq-_0vsUWNwk0h_Ma3Ed66f372WLMdcw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/7] monitor: Add basic decoding for Mesh Beacon
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jul 18, 2017 at 10:03 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This adds basic decoding for Mesh Beacon packets such as:
>>
>>> HCI Event: LE Meta Event (0x3e) plen 37
>>      LE Advertising Report (0x02)
>>        Num reports: 1
>>        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
>>        Address type: Random (0x01)
>>        Address: 36:47:34:FC:63:DA (Non-Resolvable)
>>        Data length: 25
>>        Mesh Beacon: 00dddd0000000000000000000000000000000000000000
>>          Unprovisioned Device Beacon (0x00)
>>          Device UUID: 00dddd00000000000000000000000000
>>          OOB Information: 0x0000
>>          URI Hash: 0x0000
>>        RSSI: -28 dBm (0xe4)
>>
>> < HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
>>        Length: 24
>>        Mesh Beacon: 0100c7005d732329eadf000000003e60e50797ef6d5c
>>          Secure Network Beacon (0x01)
>>          Flags: 0x01
>>          Network Id: 00c7005d732329ea
>>          IV Index: 0xdf000000
>>          Authentication Value: 003e60e50797ef6d
>> ---
>> monitor/packet.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 69 insertions(+)
>>
>> diff --git a/monitor/packet.c b/monitor/packet.c
>> index 1ec816c..3e6382e 100644
>> --- a/monitor/packet.c
>> +++ b/monitor/packet.c
>> @@ -3513,6 +3513,74 @@ static const struct {
>>       { }
>> };
>>
>> +static const struct {
>> +     uint8_t bit;
>> +     const char *str;
>> +} mesh_oob_table[] = {
>> +     { 0, "Other"                                                    },
>> +     { 1, "Eletronic / URI"                                          },
>> +     { 2, "2D machine-readable code"                                 },
>> +     { 3, "Bar code"                                                 },
>> +     { 4, "Near Field Communication (NFC)"                           },
>> +     { 5, "Number"                                                   },
>> +     { 6, "String"                                                   },
>> +     { 11, "On box"                                                  },
>> +     { 12, "Inside box"                                              },
>> +     { 13, "On piece of paper"                                       },
>> +     { 14, "Inside manual"                                           },
>> +     { 14, "On Device"                                               },
>> +     { }
>> +};
>> +
>> +static void print_mesh_beacon(const uint8_t *data, uint8_t len)
>> +{
>> +     int i;
>> +     uint16_t oob;
>
> my preference is to have iterator variable like i last in the list.
>
> Regards
>
> Marcel
>
>> +
>> +     if (len < 1)
>> +             return;
>
> At least use print_hex_field here. General rule of btmon is to print the data. Silently swallowing is bad idea. This is no longer hcidump ;)

Well if len < 1 that means there is nothing to print, packet_hexdump
won't print anything either:

if (!len)
  return;

>> +
>> +     switch (data[0]) {
>> +     case 0x00:
>> +             print_field("  Unprovisioned Device Beacon (0x00)");
>> +             if (len < 18)
>> +                     break;
>> +
>> +             print_hex_field("  Device UUID", data, 16);
>> +
>> +             oob = get_be16(&data[16]);
>> +             print_field("  OOB Information: 0x%4.4x", oob);
>> +
>> +             for (i = 0; mesh_oob_table[i].str; i++) {
>> +                     if (oob & (1 << mesh_oob_table[i].bit))
>> +                             print_field("    %s", mesh_oob_table[i].str);
>> +             }
>> +
>> +             if (len < 22)
>> +                     break;
>> +
>> +             print_field("  URI Hash: 0x%4.4x", get_be32(&data[18]));
>> +             break;
>> +     case 0x01:
>> +             print_field("  Secure Network Beacon (0x01)");
>> +             if (len < 21)
>> +                     break;
>> +
>> +             print_field("  Flags: 0x%2.2x", data[0]);
>> +
>> +             if (data[0] & 0x01)
>> +                     print_field("    Key Refresh");
>> +
>> +             if (data[0] & 0x02)
>> +                     print_field("    IV Update");
>> +
>> +             print_hex_field("  Network Id", &data[1], 8);
>> +             print_field("  IV Index: 0x%08x", get_be32(&data[9]));
>> +             print_hex_field("  Authentication Value", &data[13], 8);
>> +             break;
>> +     }
>
> And this should get a default: print_hex_field.

Ive added packet_dump for every case we cannot decode.

> Regards
>
> Marcel
>



-- 
Luiz Augusto von Dentz
