Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] piconet..
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003901c4df9e$a3fead20$6401000a@zool>
References: <00c901c4df6a$f8c11f70$6401000a@zool>
	 <1102764489.19086.15.camel@pegasus>  <016d01c4df70$a8e297d0$6401000a@zool>
	 <1102767035.19086.18.camel@pegasus> <01a901c4df7a$666d4da0$6401000a@zool>
	 <002d01c4df96$cc2e2080$6401000a@zool> <1102783440.19086.28.camel@pegasus>
	 <003901c4df9e$a3fead20$6401000a@zool>
Content-Type: text/plain
Message-Id: <1102786636.19086.34.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 11 Dec 2004 18:37:16 +0100

Hi Steffen,

> I got the two others:
> 
>  hci0: Type: USB
> BD Address: 00:01:53:00:14:EE ACL MTU: 192:8 SCO MTU: 64:8
> UP RUNNING PSCAN ISCAN
> RX bytes:81 acl:0 sco:0 events:10 errors:0
> TX bytes:39 acl:0 sco:0 commands:10 errors:0
> Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> Link policy:
> Link mode: SLAVE ACCEPT
> Name: 'knoglen'
> Class: 0x000000
> Service Classes: Unspecified
> Device Class: Miscellaneous,
> HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
> Manufacturer: Cambridge Silicon Radio (10)
> 
> hci0: Type: USB
> BD Address: 00:01:53:00:0D:B5 ACL MTU: 192:8 SCO MTU: 64:8
> UP RUNNING PSCAN ISCAN
> RX bytes:87 acl:0 sco:0 events:11 errors:0
> TX bytes:39 acl:0 sco:0 commands:10 errors:0
> Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> Link policy:
> Link mode: SLAVE ACCEPT
> Name: 'JESPER'
> Class: 0x000000
> Service Classes: Unspecified
> Device Class: Miscellaneous,
> HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
> Manufacturer: Cambridge Silicon Radio (10)

these two are HCI 16.4 and so there should be no problem. See my CSR
page why it is good to have HCI 16.x at least.

> > so far so good, but check with "hciconfig hci0 revision" for the
> > firmware version. This one is too old. It should be HCI 16.4 or newer,
> > but if this is a DBT-120 Rev. B3 you might have a chance to update it.
> 
> Well. It is the B3 revision, so I would be able to do that. :-)

I suppose you do that (at your own risk of course).

> Hmm.. This dosn't really answer my question. I am using fork()., and would
> like to get my application to work. I tried to compare it towards the
> l2test, but couldn't see that much difference. And the l2test works with the
> same dongles; connecting two clients against one server. Can you point
> somewhere in my code, where I should do some changes, so it could work??

Getting the fork stuff right is not very easy. You must carefully think
about what file descriptors to close at what time and in what process. I
am not going to check your code for such mistakes, because it will take
me too much time and the other reason is that it is C++ and not C.

> I really starts to nag me, why my code dosn't work. All things works fine
> (like connecting/disconnecting etc.) with one clients, but with two... :-(
> And I have tried to make my server MASTER by setting the L2CAP_LM_MASTER in
> the link manager.

Update the dongle or try to swap the pre HCI 16.4 one. The master option
can help, but you must choose the master device carefully.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
