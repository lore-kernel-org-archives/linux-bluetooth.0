Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4265329A.3030100@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] error on connect
References: <425FFF54.6000701@gmx.ch> <1113607202.16433.42.camel@pegasus>	 <42616275.1090103@gmx.ch> <1113682195.18450.0.camel@pegasus>	 <4261BCFB.8040204@gmx.ch> <1113702363.18450.26.camel@pegasus>	 <426237CF.5060604@gmx.ch>  <4263F8DF.1040400@gmx.ch>	 <1113849662.16233.118.camel@pegasus>  <42651A2E.2080601@gmx.ch>	 <1113923580.2469.7.camel@pegasus>  <426522C6.10700@gmx.ch>	 <1113925620.2469.26.camel@pegasus>  <42652B35.7060803@gmx.ch> <1113927187.2469.40.camel@pegasus>
In-Reply-To: <1113927187.2469.40.camel@pegasus>
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
Date: Tue, 19 Apr 2005 18:32:26 +0200

Hello Marcel

Do I get this right:
- The ACL packet that cause the problem is sent before the connection is 
etablished. This is ok and defined in the specification.
- The received dongle is responsible to keep this packet back until the 
connection is etablished and process them then.
- the csr dongles seem to handle this correct.
- the broadcom dongle seem to don't handle this correct. they probably 
suffer a race condition. so they may work or may not work.


regards
Marco


Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>>>>>It looks like this too early packet now causes the (sensefull) 
>>>>>>"hci_acldata_packet: hci1 ACL packet for unknown connection handle 6" 
>>>>>>kernel error message. The dongle then waits for this acl package and thinks 
>>>>>>this connection is in etablishing phase, so it is blocked.
>>>>>
>>>>>>>From a quick look at the kernel code, it seems that an ACL packet for an
>>>>>unknown connection handle may corrupt the HCI flow control.
>>>>
>>>>I think exactly this happens...
>>>
>>>However even if I fix the HCI flow control problem, the packet is still
>>>lost, because we don't know the connection handle at that time.
>>
>>yes, thats what seems strainge: why is this ACL packet sent that early?
>>that doesn't make sense for me (but I din't develop bluetooth)...
>>In my opinion, it should be sent after the connection is etablished.
> 
> 
> It is not only your opinion. The specification defines it this way. This
> is simply a race condition inside the link manager.



>>>>>>The question now is, who is responsible for holding this packed back? The 
>>>>>>kernel? The dongle itself?
>>>>>
>>>>>The dongle is responsible for that and actually it is only allowed to
>>>>>send data packets after the "Connect Complete" event. Otherwise we don't
>>>>>know its handle and thus can't correctly assign it to a connection.



>>>>but then it's strainge that these ACL packets are always sent before the 
>>>>"connection" successfull packet. or do I right now miss something?
>>>
>>>This must be a bug in the Broadcom link manager firmware. Seems like
>>>BlueZ is "too fast" for these chips.
>>>
>>>If you wanna workaround this problem you must put potential ACL data
>>>packets into a queue and then check this queue after you received the
>>>connection handle.
>>
>>that's pretty ugly. Maybe there's another solution for this. I think 
>>that the problem isnt yet fully understood.
> 
> 
> The problem is clear. The Broadcom link manager has a race condition
> here. It should queue the package until they send the connect complete
> event.
> 
> 
>> > You only saw that on the listing side, right?
>>
>>what do you mean with this?
>>on the sending side - if i remember right - the acl packet is alway sent 
>>before the connection is successfull etablished. I'll check again...
> 
> 
> Please do so, but there should be no problem. We only send any data to
> the chip after we received the connect complete. All previous packages
> are queued.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: New Crystal Reports XI.
> Version 11 adds new functionality designed to reduce time involved in
> creating, integrating, and deploying reporting solutions. Free runtime info,
> new features, or free trial, at: http://www.businessobjects.com/devxi/728
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
