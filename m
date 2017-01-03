Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APaqB9Dm0iB=RcGYALAAdHS8y5XN_SQi7ZAJ2Rbyn33wTg@mail.gmail.com>
References: <20170102133013.14169-1-luiz.dentz@gmail.com> <CAAu3APaqB9Dm0iB=RcGYALAAdHS8y5XN_SQi7ZAJ2Rbyn33wTg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Jan 2017 15:05:05 +0200
Message-ID: <CABBYNZ+OXBHZKbtKYi0goCBmtUd9hnOsrm2PeNHHB97zo+STBA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Add UUIDs of BBC micro:bit services
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Mon, Jan 2, 2017 at 4:46 PM, Barry Byford <31baz66@gmail.com> wrote:
> Hello Luiz,
>
> On 2 January 2017 at 13:30, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This add the UUID of GATT attributes used in BBC micro:bit services as
>> specified bellow:
>>
>> https://lancaster-university.github.io/microbit-docs/resources/bluetooth/bluetooth_profile.html
>> ---
>>  monitor/uuid.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/monitor/uuid.c b/monitor/uuid.c
>> index 6660bc7..d2e0af8 100644
>> --- a/monitor/uuid.c
>> +++ b/monitor/uuid.c
>> @@ -562,6 +562,54 @@ static const struct {
>>                 "(Advanced) Factory reset"                              },
>>         { "a3c8750c-8ed3-4bdf-8a39-a01bebede295",
>>                 "(Advanced) Remain Connectable"                         },
>> +       /* BBC micro:bit Bluetooth Profiles */
>> +       { "e95d0753-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Accelerometer Service"                        },
>> +       { "e95dca4b-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Accelerometer Data"                           },
>> +       { "e95dfb24-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Accelerometer Period"                         },
>> +       { "e95df2d8-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Magnetometer Service"                         },
>> +       { "e95dfb11-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Magnetometer Data"                            },
>> +       { "e95d386c-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Magnetometer Period"                          },
>> +       { "e95d9715-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Magnetometer Bearing"                         },
>> +       { "e95d9882-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Button Service"                               },
>> +       { "e95dda90-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Button A State"                               },
>> +       { "e95dda91-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Button B State"                               },
>> +       { "e95d127b-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit IO PIN Service"                               },
>> +       { "e95d8d00-251d-470a-a062-fa1922dfa9a8", "MicroBit PIN Data"   },
>> +       { "e95d5899-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit PIN AD Configuration"                         },
>> +       { "e95dd822-251d-470a-a062-fa1922dfa9a8", "MicroBit PWM Control" },
>> +       { "e95dd91d-251d-470a-a062-fa1922dfa9a8", "MicroBit LED Service" },
>> +       { "e95d7b77-251d-470a-a062-fa1922dfa9a8", "MicroBit LED Matrix state" },
>> +       { "e95d93ee-251d-470a-a062-fa1922dfa9a8", "MicroBit LED Text"   },
>> +       { "e95d0d2d-251d-470a-a062-fa1922dfa9a8", "MicroBit Scrolling Delay" },
>> +       { "e95d93af-251d-470a-a062-fa1922dfa9a8", "MicroBit Event Service" },
>> +       { "e95db84c-251d-470a-a062-fa1922dfa9a8", "MicroBit Requirements" },
>> +       { "e95d9775-251d-470a-a062-fa1922dfa9a8", "MicroBit Event Data" },
>> +       { "e95d23c4-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Client Requirements"                          },
>> +       { "e95d5404-251d-470a-a062-fa1922dfa9a8", "MicroBit Client Events" },
>> +       { "e95d93b0-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit DFU Control Service"                          },
>> +       { "e95d93b1-251d-470a-a062-fa1922dfa9a8", "MicroBit DFU Control" },
>> +       { "e95d6100-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Temperature Service"                          },
>> +       { "e95d1b25-251d-470a-a062-fa1922dfa9a8",
>> +               "MicroBit Temperature Period"                           },
>> +       /* Nordic UART Port Emulation */
>> +       { "6e400001-b5a3-f393-e0a9-e50e24dcca9e", "Nordic UART Service" },
>> +       { "6e400002-b5a3-f393-e0a9-e50e24dcca9e", "Nordic UART TX"      },
>> +       { "6e400002-b5a3-f393-e0a9-e50e24dcca9e", "Nordic UART RX"      },
>
> Well done for adding these.
>
> I have noticed that you have the same UUID for both the TX and RX
> characteristic.
> The "Nordic UART RX" should be  "6e400003-b5a3-f393-e0a9-e50e24dcca9e"

Ive applied this after fixing the RX, thanks.

> Cheers,
> Barry
>
>>         { }
>>  };
>>
>> --
>> 2.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
