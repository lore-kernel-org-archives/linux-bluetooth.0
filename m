Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4265820A.2000400@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] error on connect
References: <425FFF54.6000701@gmx.ch> <1113607202.16433.42.camel@pegasus>	 <42616275.1090103@gmx.ch> <1113682195.18450.0.camel@pegasus>	 <4261BCFB.8040204@gmx.ch> <1113702363.18450.26.camel@pegasus>	 <426237CF.5060604@gmx.ch>  <4263F8DF.1040400@gmx.ch>	 <1113849662.16233.118.camel@pegasus>  <42651A2E.2080601@gmx.ch>	 <1113923580.2469.7.camel@pegasus>  <426522C6.10700@gmx.ch>	 <1113925620.2469.26.camel@pegasus>  <42652B35.7060803@gmx.ch>	 <1113927187.2469.40.camel@pegasus>  <4265329A.3030100@gmx.ch> <1113929462.2469.52.camel@pegasus>
In-Reply-To: <1113929462.2469.52.camel@pegasus>
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
Date: Wed, 20 Apr 2005 00:11:22 +0200

Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>Do I get this right:
>>- The ACL packet that cause the problem is sent before the connection is 
>>etablished. This is ok and defined in the specification.
> 
> 
> this is not ok and can also not happen since you only get the connection
> handle from the connect complete event. In BlueZ this is indicated with
> the hci_proto_connect_cfm() and only at that time the L2CAP layer starts
> sending out its connect request. Please check the sender side again.

yes. I got this wrong. this way it makes much more sense...


>>- The received dongle is responsible to keep this packet back until the 
>>connection is etablished and process them then.
> 
> In general yes, they should queue the data packet.
> 
> 
>>- the csr dongles seem to handle this correct.
> 
> 
> So far I've never seen this problem with a CSR dongle. Not even with the
> very old ones.
> 
> 
>>- the broadcom dongle seem to don't handle this correct. they probably 
>>suffer a race condition. so they may work or may not work.
> 
> 
> Maybe the stacks Broadcom tested their dongles with are needing some
> time before they can send out the first ACL data packet. Or they do
> other HCI tasks before they start L2CAP. However this is a problem with
> the dongle, because the ACL data packet is not allowed at that time.

ok. that leads me to some questions:
- what would be the behaviour of the listening dongle if you fix the 
flow control after this error occured?
- (just curious) How can you find out that this packet was processed too 
early? does bluez always know the order of processed packets like the 
hcidump shows?
- Are you interested in having this ACL datapacket queue you supposed 
inside bluez (kernel)? respectively, did you mean to do this in the program?

and two comments:
- you told bluez might be too fast for ednet. actually bluez looks like 
it's too fast for the nokia 6230 too. i've to wait 1 second before I 
close a connection, else the mobile phone doesn't get all packets.
maybee this is a bigger problem (the speed thing)...

- I made a try with windows. it played the listening part with the 
broadcom dongle. Unfortunately i haven't a hcidump here, but from more 
than 100 connection tries, every single one worked...
but as I said, this is not reliable because I don't know what windows is 
doing in background...


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
