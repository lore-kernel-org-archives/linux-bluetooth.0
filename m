Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCI data bits corruption
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de46576041208102112be98ee@mail.gmail.com>
References: <2de46576041208102112be98ee@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1102533371.9988.85.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 08 Dec 2004 20:16:11 +0100

Hi Manjunath,

> I am communicating between 2 d-link DBT-120 dongles. I am using the
> l2test for sending known data. I am using the DH packets to avoid FEC.
> I am measuring the link quality for various scenarios.
> I try and compare the link quality values to corresponding BER values
> as per the CSR article at your website. I use hcidump to record
> received bytes, but with link quality dropping as low as 180-170, I am
> unable to see any corrupted bits. With the l2test, the connection
> terminates even before the assigned bytes are sent with link quality
> going bad, but there is no data corruption. Could you tell me how I
> could get the corrupted data bits???I want some sort of error over air
> interface.

there might be some CSR vendor commands to get these information, but
the HCI specification has no standard way for it. However the ACL link
is per definition reliable.

> I am also looking to study the behaviour of HCI and LM firmware. Is
> this available at the Bluez or are the firmware well guarded by the
> manufacturers and not to be given to users.

The lower part of the HCI is part of the firmware. Actually the HCI
commands and events are abstractions to the LMP. You can do everything
what is written in the HCI specification and everything below that is up
to the manufacturers.

> I also wanted to know if there are any bluetooth Test development kit,
> in hardware and software as we could build a BT device. Buying a
> Trainer/Analyser is a little over budget for my project.

Sorry, but I think you need expensive hardware for this.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
