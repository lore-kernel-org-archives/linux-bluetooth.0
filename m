Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Adding services in the Service Class ID list
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050425013050.76433.qmail@web20927.mail.yahoo.com>
References: <20050425013050.76433.qmail@web20927.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1114515608.10706.217.camel@pegasus>
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
Date: Tue, 26 Apr 2005 13:40:08 +0200

Hi Arch,

> I have been trying to add services in the Service Class ID list like
> as shown below:
>  
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x1112 - HeadsetAudioGateway
>     UUID16 : 0x1203 - GenericAudio
>  
> It seemed that the 2 services have been added successfully.
> However, when I use sdptool to browse for the services, only the last
> service is the one reflected in the service and not both.
>  
> Please advice as on how I can successfully add the 2 services in the
> service class ID list.

show us the source code you are using.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
