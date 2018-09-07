Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7f2b35cd6792989b5fb8ca7231dc7dbba7d7a0e7.camel@intel.com>
References: <20180817143545.26700-1-andri@yngvason.is> <7f2b35cd6792989b5fb8ca7231dc7dbba7d7a0e7.camel@intel.com>
From: Andri Yngvason <andri@yngvason.is>
Date: Fri, 7 Sep 2018 18:19:59 +0000
Message-ID: <CAFNQBQyc_ugja=Eo--wMB26F7wzP-EYwpEznOF32kSroZvkRNg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] tools/mesh: Add basic sensor model
To: "Stotland, Inga" <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

2018-08-24 7:10 GMT+00:00 Stotland, Inga <inga.stotland@intel.com>:
>> diff --git a/tools/mesh/sensor-model.c b/tools/mesh/sensor-model.c
>> new file mode 100644
>> index 000000000..37ca55631
>> --- /dev/null
>> +++ b/tools/mesh/sensor-model.c
>> @@ -0,0 +1,255 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2017  Intel Corporation. All rights reserved.
>> + *  Copyright (C) 2018  Andri Yngvason <andri@yngvason.is>
>> + *
>> + *
>> + *  This library is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU Lesser General Public
>> + *  License as published by the Free Software Foundation; either
>> + *  version 2.1 of the License, or (at your option) any later version.
>> + *
>> + *  This library is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  Lesser General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU Lesser General Public
>> + *  License along with this library; if not, see <http://www.gnu.org/licenses/>.
>
> Let's stay consistent with the rest of bluez and not introduce new
> style for the license text.
Linux's check-patch script complains that the address may change. Is
this not a concern?
[...]
>> diff --git a/tools/meshctl.c b/tools/meshctl.c
>> index 3e1484f61..08bba9a13 100644
>> --- a/tools/meshctl.c
>> +++ b/tools/meshctl.c
>> @@ -58,6 +58,7 @@
>>  #include "mesh/prov-db.h"
>>  #include "mesh/config-model.h"
>>  #include "mesh/onoff-model.h"
>> +#include "mesh/sensor-model.h"
>>
>>  /* String display constants */
>>  #define COLORED_NEW  COLOR_GREEN "NEW" COLOR_OFF
>> @@ -1990,6 +1991,9 @@ int main(int argc, char *argv[])
>>       if (!onoff_client_init(PRIMARY_ELEMENT_IDX))
>>               g_printerr("Failed to initialize mesh generic On/Off client\n");
>>
>> +     if (!sensor_client_init(PRIMARY_ELEMENT_IDX))
>> +             g_printerr("Failed to initialize mesh sensor client\n");
>> +
>
> I suggest that you add the model id for sensor client to the device
> composition section in local_node.json.
> Otherwise, meshctl will print the above error and fail to initialize
> sensor menu.
Yeah, I managed to get this working, but I wasn't quite sure how the
configuration.elements section was supposed to look, so I  just
replaced the on-off index with the sensor model index and that worked
for me.
Is the format documented somewhere?

Regards,
Andri
