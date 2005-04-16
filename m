Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] inquiry,connect and connect timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <313624802.29794@eyou.net>
References: <313624802.29794@eyou.net>
Content-Type: text/plain
Message-Id: <1113625809.16433.55.camel@pegasus>
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
Date: Sat, 16 Apr 2005 06:30:09 +0200

Hi,

>     I'm programming with BlueZ,but now there are three questions.
>     1.How to inquiry with CoD?
>       I use  hci_inquiry(...) to achieve the inquiry procedure ,and now I want to filter the inquiry responses with CoD directly,instead of by the return value of inquiry_info. 

there exists a HCI_Set_Event_Filter command in the specification for
this, but actually I never tried it and I don't know how many chips are
really supporting it.

>     2.How to connect with clock offset?
>       I use the RFCOMM socket to connect the remote device,and I have gotten the remote clock offset through the previous inquiry procedure.I want to accelerate the connect procedure, but I don't know  where I should cache the clock offset so that the later connect procedure will use it automatically . In a word, I would like to know the correct methods to accelerate the connect procedure.

No need to, because the kernel keeps track of creating the ACL link and
it uses the clock offset from its inquiry cache if it is still valid.

>    3. timeout of the connect procedure.
>       I want to make it clear What the default value of timeout is, when I use  the connect(...) of RFCOMM socket to setup connection with the remote device.What's more , I want to know whether I could modify the value of timeout and how.

I think you are talking about the page timeout. Look at the HCI command
to modify it or use "hciconfig pageto ..." for it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
