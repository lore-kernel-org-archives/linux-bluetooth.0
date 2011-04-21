Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <padovan@profusion.mobi>
Date: Thu, 21 Apr 2011 11:24:41 +0300
Subject: RE: [PATCH v2 6/6] Bluetooth: Respect local MITM req in io_cap reply
Message-ID: <99B09243E1A5DA4898CDD8B7001114481086306D89@EXMB04.eu.tieto.com>
References: <1303372461-11848-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1303372461-11848-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110421081048.GA23120@jh-x301>
In-Reply-To: <20110421081048.GA23120@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, 

>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -2369,7 +2369,7 @@ static inline u8 hci_get_auth_req(struct 
>> hci_conn *conn)
>>  
>>  	/* If remote requests no-bonding follow that lead */
>>  	if (conn->remote_auth == 0x00 || conn->remote_auth == 0x01)
>> -		return 0x00;
>> +		return conn->auth_type & 0x01;
>>  
>>  	return conn->auth_type;
>>  }
>
>Your other patches seem ok to me, but have you verified this 
>one with the BITE tester? This logic is directly copied from 
>how it is in user space right now and that's something we have 
>arrived at after multiple iterations with the BITE tester over 
>the last few years. So I'd be very careful when changing it.
>

No, I did not. I don't have an access to BITE directly, but I will see if I can verify this.

I simply did some combination of manual tests with three different dongles (2.0 and two 2.1), with sspmode on/off , with auth and encrypt on/off, with required sec_level 1,2,3 in security mode 2 and 4.

Waldek