Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <426522C6.10700@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] error on connect
References: <425FFF54.6000701@gmx.ch> <1113607202.16433.42.camel@pegasus>	 <42616275.1090103@gmx.ch> <1113682195.18450.0.camel@pegasus>	 <4261BCFB.8040204@gmx.ch> <1113702363.18450.26.camel@pegasus>	 <426237CF.5060604@gmx.ch>  <4263F8DF.1040400@gmx.ch>	 <1113849662.16233.118.camel@pegasus>  <42651A2E.2080601@gmx.ch> <1113923580.2469.7.camel@pegasus>
In-Reply-To: <1113923580.2469.7.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 19 Apr 2005 17:24:54 +0200

Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>>I don't had the time to search my Broadcom dongles.
>>
>> > Maybe you should try to get yourself some CSR based dongles.
>>
>>Unfortunately I'm bound to the broadcom dongles for multipe reasons, so I'd 
>>be very grateful if you could take a look at the problem.
>>
>>I did some hcidump tests and I think I figured out the source of the 
>>problem. Please forgive me that this email contains some information I 
>>already postet, it's just to give a whole picture...
>>This is the start of a successfull connection (please note my added #N#):
>>
>> > HCI Event: Connect Request (0x04) plen 10
>>     bdaddr 00:02:72:C3:F2:10 class 0x3e0100 type ACL
>>< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>>     bdaddr 00:02:72:C3:F2:10 role 0x01
>>     Role: Slave
>> > HCI Event: Command Status (0x0f) plen 4
>>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
>>#1#
>>#1#
>> > HCI Event: Connect Complete (0x03) plen 11
>>     status 0x00 handle 7 bdaddr 00:02:72:C3:F2:10 type ACL encrypt 0x00
>>< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>>     handle 7 policy 0x0f
>>     Link policy: RSWITCH HOLD SNIFF PARK
>> > HCI Event: Command Complete (0x0e) plen 6
>>     Write Link Policy Settings (0x02|0x000d) ncmd 1
>>     status 0x00 handle 7
>>< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>>     handle 7 ptype 0xcc18
>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>>#2# > ACL data: handle 7 flags 0x02 dlen 12
>>#2#     L2CAP(s): Connect req: psm 3 scid 0x0040
>>
>>
>>If a broadcom dongle is listening, sometimes the ACL packet marked with #2# 
>>is received where the #1# lines are. Actually, looking at the hcidump of 
>>the sending dongle, that's the time the packet is sent (alway, dongle 
>>independant).
> 
> 
> do you have a dump where this actually happens?

the dump of the listeining or the sending dongle?
for the listening one, I sent a hcidump from a successfull and failed 
connection. with a diff, you see exactly what I described.

>>It looks like this too early packet now causes the (sensefull) 
>>"hci_acldata_packet: hci1 ACL packet for unknown connection handle 6" 
>>kernel error message. The dongle then waits for this acl package and thinks 
>>this connection is in etablishing phase, so it is blocked.
> 
> 
>>>From a quick look at the kernel code, it seems that an ACL packet for an
> unknown connection handle may corrupt the HCI flow control.

I think exactly this happens...

>>The question now is, who is responsible for holding this packed back? The 
>>kernel? The dongle itself?
> 
> 
> The dongle is responsible for that and actually it is only allowed to
> send data packets after the "Connect Complete" event. Otherwise we don't
> know its handle and thus can't correctly assign it to a connection.

but then it's strainge that these ACL packets are always sent before the 
"connection" successfull packet. or do I right now miss something?


regards
Marco


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
