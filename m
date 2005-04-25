Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <426D3661.5000600@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: bluez with scatternet
References: <2621d9af0504221144179aa2b4@mail.gmail.com> <2621d9af0504251117144b3a92@mail.gmail.com>
In-Reply-To: <2621d9af0504251117144b3a92@mail.gmail.com>
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
Date: Mon, 25 Apr 2005 20:26:41 +0200

just create usual connections.
check the bluetooth specification for the definition of master/slave roles 
and role switching.

regards
Marco


N. I. wrote:
> Thanks for reply Marcel.
> Can you please tell me how to create an ACL link?
> I'm running Java application on top of the stack, hence the only thing
> I can do is executing the tools command like hcitool etc.
> 
> How do I create ACL link to reflect the master - slave configuration
> as described?
> 
> thanks
> 
> On 4/22/05, N. I. <neutralidea@gmail.com> wrote:
> 
>>I'm new to Bluetooth, as well as scatternet type of network.
>>
>>I'm trying to create a scatternet network as followed:
>>
>>Piconet 1:
>>Master A
>>Slave B, C, D
>>
>>Piconet 2:
>>Master C (slave in piconet 1)
>>Slave M, N, Q.
>>
>>My questions:
>>
>>1) What are the steps to create this type of scatternet?
>>  What should be done to configure master/slave C to play this role
>>in the network?
>>
>>2) Assuming that the scatternet is created succesfully. If
>>Master/Slave C dies, how can slaves M, N and Q be able to route
>>messages to Master A?
>>
>>3) For this current configuration of network, what should I consider
>>in pairing devices in sunny situation (Master/Slave C up and running)
>>and when master/slave C dies (rainy condition)?
>>
>>Please help,
>>
>>Thanks
>>
>>N.I.
>>
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
