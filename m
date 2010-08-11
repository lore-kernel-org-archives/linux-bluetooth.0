Return-Path: <cyrus@holtmann.org>
Message-ID: <4C620A8A.9030707@codeaurora.org>
Date: Tue, 10 Aug 2010 22:27:22 -0400
From: Ron Shaffer <rshaffer@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: patch for firmware download to Qualcomm Bluetooth chip
References: <4C619FA6.8030606@codeaurora.org> <1281474848.12579.218.camel@localhost.localdomain>
In-Reply-To: <1281474848.12579.218.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 8/10/2010 5:14 PM, Marcel Holtmann wrote:
> Hi Ron,
> 
>> Here's the a ping regarding the patch submitted by Matt back in March? I
>> believe. For you convenience I've included the patch again. Please take
>> a look, and provide your general comments. I'm sure there are changes
>> that need to be made.
>>
>> Fyi. sorry about the column wrap in the patch. Don't feel like fixing it
>> for just a quick review.
>>
>> From 76d0bdd82a0a4e5b3b9544bb864c31888f20cea1 Mon Sep 17 00:00:00 2001
>> From: Wilson, Matt <mtwilson@codeaurora.org>
>> Date: Thu, 11 Feb 2010 11:53:29 -0600
>> Subject: [PATCH] Firmware download for Qualcomm Bluetooth devices
>>
>> ---
>>  Makefile.tools             |    3 +-
>>  tools/hciattach.c          |    9 ++
>>  tools/hciattach.h          |    4 +
>>  tools/hciattach_qualcomm.c |  279
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 294 insertions(+), 1 deletions(-)
>>  create mode 100644 tools/hciattach_qualcomm.c
>>
>> diff --git a/Makefile.tools b/Makefile.tools
>> index 2735d68..7b92c8f 100644
>> --- a/Makefile.tools
>> +++ b/Makefile.tools
>> @@ -23,7 +23,8 @@ tools_l2ping_LDADD = lib/libbluetooth.la
>>  tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
>>  						tools/hciattach_st.c \
>>  						tools/hciattach_ti.c \
>> -						tools/hciattach_tialt.c
>> +						tools/hciattach_tialt.c \
>> +						tools/hciattach_qualcomm.c
>>  tools_hciattach_LDADD = lib/libbluetooth.la
>>
>>  tools_hciconfig_SOURCES = tools/hciconfig.c tools/csr.h tools/csr.c \
>> diff --git a/tools/hciattach.c b/tools/hciattach.c
>> index 364c5ff..d6aafbe 100644
>> --- a/tools/hciattach.c
>> +++ b/tools/hciattach.c
>> @@ -5,6 +5,7 @@
>>   *  Copyright (C) 2000-2001  Qualcomm Incorporated
>>   *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
>>   *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
>> + *  Copyright (C) 2010, Code Aurora Forum. All rights reserved.
>>   *
>>   *
>>   *  This program is free software; you can redistribute it and/or modify
>> @@ -299,6 +300,11 @@ static int texasalt(int fd, struct uart_t *u, struct
>> termios *ti)
>>  	return texasalt_init(fd, u->speed, ti);
>>  }
>>
>> +static int qualcomm(int fd, struct uart_t *u, struct termios *ti)
>> +{
>> +	return qualcomm_init(fd, u->speed, ti, u->bdaddr);
>> +}
>> +
>>  static int read_check(int fd, void *buf, int count)
>>  {
>>  	int res;
>> @@ -1071,6 +1077,9 @@ struct uart_t uart[] = {
>>  	/* Broadcom BCM2035 */
>>  	{ "bcm2035",    0x0A5C, 0x2035, HCI_UART_H4,   115200, 460800, FLOW_CTL,
>> NULL, bcm2035  },
>>
>> +	/* QUALCOMM BTS */
>> +	{ "qualcomm",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL,
>> NULL, qualcomm },
>> +
>>  	{ NULL, 0 }
>>  };
>>
>> diff --git a/tools/hciattach.h b/tools/hciattach.h
>> index 867563b..5c89013 100644
>> --- a/tools/hciattach.h
>> +++ b/tools/hciattach.h
>> @@ -3,6 +3,7 @@
>>   *  BlueZ - Bluetooth protocol stack for Linux
>>   *
>>   *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
>> + *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
>>   *
>>   *
>>   *  This program is free software; you can redistribute it and/or modify
>> @@ -45,3 +46,6 @@ int texas_post(int fd, struct termios *ti);
>>  int texasalt_init(int fd, int speed, struct termios *ti);
>>  int stlc2500_init(int fd, bdaddr_t *bdaddr);
>>  int bgb2xx_init(int dd, bdaddr_t *bdaddr);
>> +int qualcomm_init(int fd, int speed, struct termios *ti, const char
>> *bdaddr);
>> +
>> +
> 
> I am actually fine with this. Except strip it from claiming copyright on
> hciattach.c and hciattach.h since these changes are not really anything
> new. They are just wrapping code.
> 
> So fix this and submit a new clean patch.
> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Yes, will do.

-- 
Ron Shaffer
Employee of the Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
