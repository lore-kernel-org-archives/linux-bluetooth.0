Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
Date: Wed, 08 Oct 2003 18:12:54 -0700
To: Marcel Holtmann <marcel@holtmann.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Bluetooth update for 2.4.23-pre2
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1063406933.28891.361.camel@pegasus>
References: <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
 <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 03:48 PM 9/12/2003, Marcel Holtmann wrote:
>> --- 1.5/net/bluetooth/hci_conn.c        Fri Mar 21 04:26:29 2003
>> +++ 1.6/net/bluetooth/hci_conn.c        Thu Aug 21 06:11:42 2003
>> @@ -168,6 +168,9 @@
>>  
>>         hci_dev_hold(hdev);
>>  
>> +       if (hdev->notify)
>> +               hdev->notify(hdev, HCI_NOTIFY_CONN_ADD, (unsigned long) conn);
>> +
>> 
>> I believe I mentioned that before. Above patch basically means that driver has to keep 
>> its own counter of ACL and SCO connection (ie check conn->type and stuff). That does 
>> not make sense to me. Core already has that information. It's part of hci_conn_hash. 
>> Currently we single counter. So we probably need to split it. And if we do it that way 
>> there is no need for the third argument to hdev->notify().
>
>you mention that, but I only thought of it as some kind of additional
>modification so we don't have to count the number of ACL and SCO in the
>driver itself.
>
>I want to keep the the third parameter to be save in future if we need
>to send other notifications down to the HCI driver for which we can use
>it eventually. Bluetooth 1.2 and 2.0 will come with new stuff that may
>need it.
Unlikely. In any case we can add it later of needed.

>For the CONN_ADD and CONN_DEL I think we should also send the "conn"
>down to the driver so it can read from it if needed.
But the only thing useful for the driver is the connection type. We might as 
well just pass that instead of a pointer to the whole struct. Anyway core should
count connections not the driver.

>If not, it has to go by itself through the hash and I don't see any way that the 
>driver can find out the current added connection. Am I wrong?
conn_hash has 'num' field which is total number of connections. So we just need to
keep two separate counters for ACL and SCO.
I'll try to find some time this week to implement that.

>> ><marcel@holtmann.org> (03/07/31 1.1019.1.7)
>> >   [Bluetooth] Set initial value of RFCOMM credits to zero
>> >   
>> We talked about this one too. With that change we're going to ask
>> for credits every time we send PN request even if other side already told 
>> us that they don't support CFC. This is not right. We need to negotiate CFC 
>> only once.
>
>Yes, you told me that. And I put a note on my TODO list that this needs
>further attention. But your suggestions was to change the credits value
>from uint to int and don't find the time to check if a type change may
>not causes other problems. And as I also said a new flag may be a better
>solution.
>Anyway I took the patch in, because it fixes the problem and whithout we
>have a bug with incoming 1.0b connections. The double negotiation only
>takes place on the second outgoing connections to the same 1.0b device.
>And how much 1.0b devices do you have or do you know of? My only 1.0b
>device is a Ericsson T39m and even my old Nokia 6210 already supports
>CFC. And my HBH-10 don't count, because it support only one RFCOMM
>connection ;)
What I'm saying is that we should fix the write way not just some hack that 
fixes first negotiation. It will pass certification with Ceticomm (or whatever 
the name of that company) but will fail if tester code does proper checking ie second 
connection, etc.
It should be a trivial fix. I take a look at it tonight.

Max
