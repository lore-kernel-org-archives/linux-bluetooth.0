Return-Path: <survivor@uni-paderborn.de>
Message-ID: <4149C231.4070505@uni-paderborn.de>
Date: Thu, 16 Sep 2004 18:41:21 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   =?ISO-8859-1?Q?Bernd_E=DFmann?= <psycho@uni-paderborn.de>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de>	 <1095234376.5263.10.camel@pegasus>  <41484B1B.2000000@uni-paderborn.de>	 <1095282542.19426.9.camel@pegasus>  <41496B2C.1030103@uni-paderborn.de>	 <1095330875.19426.28.camel@pegasus>  <41496D78.3080807@uni-paderborn.de> <1095332448.19426.50.camel@pegasus>
In-Reply-To: <1095332448.19426.50.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi!

Now all my problems are solved using hci_write_page_timeout and 
hci_write_supervision_timeout.
It's probably not the most elegant way since one has to be root and it 
disturbs other programs using the same device, but I think there is no 
other way if you don't want one unreachable device to freeze your whole 
application.

I learned a lot during this long thread and I think we can close it now :).

Regards
Stefan
