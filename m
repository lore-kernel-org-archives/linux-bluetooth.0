Return-Path: <cyrus@holtmann.org>
Message-ID: <4CC6DC40.2000209@openbossa.org>
Date: Tue, 26 Oct 2010 09:48:48 -0400
From: Anderson Briglia <anderson.briglia@openbossa.org>
MIME-Version: 1.0
To: Ville Tervo <ville.tervo@nokia.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] SMP initial draft
References: <linux-bluetooth@vger.kernel.org> <1287791820-22693-1-git-send-email-anderson.briglia@openbossa.org> <20101026093808.GE15050@null>
In-Reply-To: <20101026093808.GE15050@null>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/26/2010 05:38 AM, Ville Tervo wrote:
> Hi,
>
> On Sat, Oct 23, 2010 at 01:56:54AM +0200, ext Anderson Briglia wrote:
>    
>> This RFC is about Security Manager Protocol (SMP).
>> Basically this patchset implements the initial negotiation over L2CAP and LE
>> connections between a Master and a Slave. TK and STK keys are not being generated
>> and/or exchanged yet, do not expect real encryption/decryption by now.
>> Actually, our next tasks are related to integrate current implementation and
>> Criptographic Toolbox ah, c1 and s1 functions for TK and STK key generation for
>> Just Works SMP pairing method.
>>      
> I think some kind of mechanism to start encryption on already existing
> connection is needed. It depends on attribute if security is needed or not. One
> might read unsecure attributes and then needs to start encryption because it
> wants to read encrypted attribute.
>
> Is that already planned somehow?
>    

Not yet. After we get the SMP keys generation and exchange working we 
could start working on it.

>    
>> To test this RFC you need to have the Ville Tervo[1] kernel tree with LE connection
>> patches. Of course you need LE devices and bluez git tree (master branch). Just run
>> the bluetoothd and try to list the primary services using gatttool over an LE channel.
>> eg.: gatttool --primary --le -i hci0 -b 00:17:E7:DD:08:FF
>>      
> I guess I should take patches which are fixing plain LE (2/6) and (5/6)
> connection to my tree alread. How it sounds to you?
>    

I think this is ok. Just update your kernel tree and we could make a 
rebase here and separate the "pure" SMP patches on top of your patches.
>    
>> Comments are welcome.
>>
>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/vtervo/bluetooth-le-2.6.git
>>
>> [PATCH 1/6] Bluetooth: Add SMP command structures
>> [PATCH 2/6] Bluetooth: fix receiving L2CAP packets over LE
>> [PATCH 3/6] Bluetooth: Implement the first SMP commands
>> [PATCH 4/6] Bluetooth: Start SMP procedure
>> [PATCH 5/6] Bluetooth: Fix initiated LE connections
>> [PATCH 6/6] Bluetooth: simple SMP pairing negotiation
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>      

