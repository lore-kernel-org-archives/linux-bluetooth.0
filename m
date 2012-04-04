Return-Path: <cyrus@holtmann.org>
Message-ID: <4F7C4BCD.6070904@tu-ilmenau.de>
Date: Wed, 04 Apr 2012 15:25:33 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: james.steele@accenture.com, linux-bluetooth@vger.kernel.org
Subject: problem with ssp debug mode & pand
References: <4F7349EC.8080706@tu-ilmenau.de> <4F755663.1050508@tu-ilmenau.de> <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E12DC1@048-CH1MPN1-101.048d.mgd.msft.net> <4F75BB73.2010708@tu-ilmenau.de> <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E12E14@048-CH1MPN1-101.048d.mgd.msft.net> <4F7BE3A8.9010801@tu-ilmenau.de> <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E13D11@048-CH1MPN1-101.048d.mgd.msft.net>
In-Reply-To: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E13D11@048-CH1MPN1-101.048d.mgd.msft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now I installed hcidump, hope this helps you supporting me.
So again my 2 problems are:

a)
pand-connection doesn't work. "Connection refused".
hcidump at the device which is listening when I try to connect:

< ACL data: handle 11 flags 0x00 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
     Connection refused - security block

 > HCI Event: Disconn Complete (0x05) plen 4
     status: 0x00 handle 11 reason 0x13
     Reason: Remote User Terminated Connection


I see "security block" but... what can i do?


b)
It's possible to create a RFCOMM-connection between two 
Bluetooth3.0-Devices. For that I use a Sniffing-Tool (BPA500). When I 
enter the Link Key into the sniffing software, the connection can be 
captured by the sniffer. But if I don't use the link key and enable the 
sspdebug mode instead, the sniffer can't capture it. So maybe 
something's wrong with enabling the sspdebug mode.
hcidump when I enable the sspdebug mode:
< HCI Command: Write Simple Pairing Debug Mode (0x06|0x0004) plen 1
     mode 0x01
 > HCI Event: Command Complete (0x0e) plen 4
     Write Simple Pairing Debug Mode (0x06|0x0004) ncmd 1
     status 0x00


I see "status 0x00", i think that means sspdebug mode is enabled. So why 
can't the sniffer capture it?

If you need more information, just tell me.
Hope someone can help me :-)

Cheers,
Steffen



Am 04.04.2012 10:46, schrieb james.steele@accenture.com:
> If you can run hcidump you should be able to verify that a command is being sent correctly (and completed with a status code 0 ==OK) - you might need the patches I sent to the mailing list to decode the command correctly.
>
> Slave Page refers to the mechanism by which the sniffer follows and joins in with the piconet - I believe it means it tries to look for page requests to the slave device (i.e. the acceptor).  But that is for initiating the sniffing connection; if you can see some LMP in the sniff then you have successfully passed that stage and so Slave Page, Master Inquiry, etc. is not relevant to your problem.
>
> BR,
> James
>
> James Steele
> Accenture Mobility Services
> Cambridge
> Email: james.steele@accenture.com
>
> This message is for the designated recipient only and may contain confidential, privileged, proprietary, or otherwise private information. If you have received it in error, please notify the sender immediately and delete the original. Any other use of this email by you is prohibited.
>
> Communications with Accenture or any of its group companies (“Accenture Group”) including telephone calls and emails (including content), may be monitored by us for the purposes of security and the assessment of internal compliance with company policy. Accenture Group does not accept service by e-mail of court proceedings, other processes or formal notices of any kind.
>
> Accenture means Accenture (UK) Limited (registered number 4757301), Accenture Services Limited (registered number 2633864), or Accenture HR Services Limited (registered number 3957974), all registered in England and Wales with registered addresses at 30 Fenchurch Street, London EC3M 3BD, as the case may be.
>
>
>> From: Steffen Becker [mailto:steffen.becker@tu-ilmenau.de]
>> Sent: 04 April 2012 07:01
>> To: Steele, James
>> Subject: Re: problem with ssp debug mode
>>
>> Hi James,
>>
>> thank you again for your answer!
>> # hciconfig -a hci0 sspdebug 1
>> also didn't work... i think there is a problem using this command. Is
>> there a possibility that i can see if my device is in sspdebug mode or not?
>>
>> And what do you mean with "Slave Page"?
>>
>> Regards,
>> Steffen
>>
>>
>> Am 30.03.2012 16:02, schrieb james.steele@accenture.com:
>>> I think you are missing the '-a' switch on hciconfig for specifying the
>> particular controller to use i.e.
>>> hciconfig -a hci0 sspdebug 1
>>>
>>> If the parameter to the sspdebug mode is invalid it should be errored by
>> the controller.
>>> Also, I normally use the "Slave Page" type of sniffing when using the tool - I
>> don't know if that will make a difference for you.
>>> James Steele
>>> Accenture Mobility Services
>>> Cambridge
>>> Email: james.steele@accenture.com
>>>
>>> Communications with Accenture or any of its group companies (“Accenture
>> Group”) including telephone calls and emails (including content), may be
>> monitored by our systems for the purposes of security and the assessment
>> of internal compliance with company policy.  Accenture Group does not
>> accept service by e-mail of court proceedings, other processes or formal
>> notices of any kind.
>>> Accenture means Accenture (UK) Limited (registered number 4757301),
>> Accenture Technology Solutions Limited (registered number 4442596), or
>> Accenture HR Services Limited (registered number 3957974), all registered in
>> England and Wales with registered addresses at 30 Fenchurch Street, London
>> EC3M 3BD, as the case may be.
>>>
>>>
>>>> -----Original Message-----
>>>> From: Steffen Becker [mailto:steffen.becker@tu-ilmenau.de]
>>>> Sent: 30 March 2012 14:56
>>>> To: Steele, James
>>>> Subject: Re: problem with ssp debug mode
>>>>
>>>> Hi James,
>>>>
>>>> thank you very much for your answer!
>>>>
>>>> Sadly i didn't gain any new information to solve my problem, because i
>>>> tried it both ways (with my BT3.0 devices):
>>>> 1. enable page&   inquiry scan
>>>> 2. start sniffing
>>>> 3. enable sspdebug mode
>>>>        ->   but is "# hciconfig hci0 sspdebug 1" the correct command?
>>>> Because even if i enter "# hciconfig hci0 sspdebug xyz" there is no
>>>> failure message
>>>> 4. connect (via rfcomm)
>>>> ->   connection works, but sniffing failed
>>>>
>>>> alternative:
>>>> 1. enable page&   inquiry scan
>>>> 2. go to /var/lib/bluetooth/<local-bd-addr>/linkkeys
>>>> 3. enter the linkkey in the sniffing software (i even tried EVERY
>>>> linkkey that i found in that path)
>>>> 4. start sniffing
>>>> 5. connect (via rfcomm)
>>>> ->   connection works, but sniffing failed
>>>>
>>>> I think i did everything as you said, did I?
>>>> If yes, i think i have to contact the frontline support again...
>>>>
>>>> Regards,
>>>> Steffen
>>>>
>>>>
>>>> Am 30.03.2012 15:07, schrieb james.steele@accenture.com:
>>>>> Hi Steffen,
>>>>>
>>>>> Sorry not getting back to you sooner, what free time I get at work has
>> been
>>>> spent trying to get the patches I sent to the mailing list into a valid form to
>> be
>>>> committed ☺
>>>>>> The main problem is, that i use a sniffing tool (BPA500) to sniff the
>>>> connection between two Bluetooth3.0-dongles. But the sniffing software
>>>>>> has a problem to capture it. And i think i made a misstake by putting the
>>>> devices in ssp debug mode (because when i sniff two Bluetooth2.0
>>>>>> devices then everything works fine).
>>>>>> That's what i've done:
>>>>>>
>>>>>> I have two gentoo-PCs with two BT3.0 Dongles and i installed on both
>> PCs
>>>> the latest bluez (v4.99)&    your patch "Adding SSP debug mode
>>>>>> configuration to hciconfig" (from March, 19th) and even the second
>> patch
>>>> from March the 28th: "lib: Add HCI write SSP debug mode library
>>>>>> function" and "Adding SSP debug mode configuration to hciconfig."
>>>>>> then i did:
>>>>>> PC2 # hciconfig hci0 piscan
>>>>>> PC1 # hciconfig hci0 piscan
>>>>>> PC1 # hciconfig hci0 sspdebug 1
>>>>>> (in a 2nd try also: PC2 # hciconfig hci0 sspdebug 1)
>>>>>> click on "start sniffing" at the software
>>>>>> PC2 # rfcomm listen 0 1
>>>>>> PC1 # rfcomm -r connect 0<bluetooth-adress>    1
>>>>>>
>>>>>> The two PCs are connected now (as seen on the screens) but the
>> sniffing
>>>> software didn't captured it. Maybe i did something wrong by using
>>>>>> the "sspdebug" command?
>>>>>> It would be great if you can answer me.
>>>>> The reason v2.0 hardware works and v3.0 hardware doesn't relate to
>>>> changes made for Bluetooth v2.1.  A feature called secure simple pairing
>>>> (SSP) was added to improve the security of Bluetooth - part of that
>> mandates
>>>> that (most) Bluetooth logical channels must enable encryption before
>>>> connection.  So with v2.0 hardware as you haven't specified the '-E' option
>>>> then the link will not be encrypted, but with the v3.0 hardware the
>> Bluetooth
>>>> stack is mandated to encrypt the link before proceeding with the
>> connection.
>>>>>            Therefore if you use the -E option with the v2.0 hardware I believe
>> you
>>>> will see the same problem.
>>>>> Sniffers (like Frontline) can decode after encryption, *but* only if they
>>>> know the encryption key that is to be used.  They can acquire this
>>>> information either by observing the pairing process, or by having the link
>> key
>>>> entered manually. (Pairing generates a link key which is used to
>> authenticate
>>>> the link and from which the encryption key is derived).
>>>>> You enter this information normally on a dialog you can get to from the
>>>> dialog that shows the comprobe details (with the red/yellow/green/bluet
>>>> traffic light icon) - it is one of the buttons on there for configuring the
>>>> comprobe (I can't remember the exact text).
>>>>> For v2.0 and earlier - you may have to enter the PIN code into the
>> sniffing
>>>> tool before it is used for the pairing process (the sniffer can then also
>>>> generate the same link key as pairing proceeds).  For v2.1 and later you
>> just
>>>> have to indicate that SSP debug mode is being used (and so you have to
>>>> enable that on at least one of the devices).  Or you can enter the link key -
>> on
>>>> BlueZ you can find it somewhere like
>>>>>            /var/lib/Bluetooth/<BD_ADDR for local hardware>/linkkeys
>>>>> The 16 byte stream follows the BD_ADDR for the remote device the link
>>>> key is associated with.
>>>>> If you have entered this information in the sniffer before the connection
>> is
>>>> made you should be able to see the packets after encryption is enabled.
>>>> There are some "gotchas" though:
>>>>> * Sometimes the sniffer will fail to decode after encryption starts
>> anyway -
>>>> it is just sometimes not that reliable.  The only choice is to just try again.
>>>>> * If the devices are already paired then they do not need to exchange
>>>> information to generate the encryption key (i.e. so it can't be decoded).
>> You
>>>> have to make sure that the pairing occurs while the sniffer is operating
>> (with
>>>> the provided information).  Therefore be sure to "unbond" or "delete
>>>> device" before starting the sniffer and connection each time.
>>>>>            * The sniffer will often remember the key for that session, but I
>> mostly
>>>> always unbond the devices anyway.
>>>>> Cheers,
>>>>> James
>>>>>
>>>>> James Steele
>>>>> Accenture Mobility Services
>>>>> Cambridge
>>>>> Email: james.steele@accenture.com
>>>>>
>>>>> Communications with Accenture or any of its group companies
>> (“Accenture
>>>> Group”) including telephone calls and emails (including content), may be
>>>> monitored by our systems for the purposes of security and the
>> assessment
>>>> of internal compliance with company policy.  Accenture Group does not
>>>> accept service by e-mail of court proceedings, other processes or formal
>>>> notices of any kind.
>>>>> Accenture means Accenture (UK) Limited (registered number 4757301),
>>>> Accenture Technology Solutions Limited (registered number 4442596), or
>>>> Accenture HR Services Limited (registered number 3957974), all registered
>> in
>>>> England and Wales with registered addresses at 30 Fenchurch Street,
>> London
>>>> EC3M 3BD, as the case may be.
>>>>> ________________________________
>>>>> Subject to local law, communications with Accenture and its affiliates
>>>> including telephone calls and emails (including content), may be
>> monitored
>>>> by our systems for the purposes of security and the assessment of
>> internal
>>>> compliance with Accenture policy.
>>>>
>> __________________________________________________________
>>>> ____________________________
>>>>> www.accenture.com
>>> ________________________________
>>> Subject to local law, communications with Accenture and its affiliates
>> including telephone calls and emails (including content), may be monitored
>> by our systems for the purposes of security and the assessment of internal
>> compliance with Accenture policy.
>> __________________________________________________________
>> ____________________________
>>> www.accenture.com
>
> ________________________________
> Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
> ______________________________________________________________________________________
>
> www.accenture.com

