Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Prepare patch bluez for the CoD in hci_conn
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1102354847.2296.3.camel@debian>
References: <1102340081.653.6.camel@debian>
	 <1102315236.8510.55.camel@pegasus>  <1102345868.2011.2.camel@debian>
	 <1102317505.8510.66.camel@pegasus>  <1102348405.3281.4.camel@debian>
	 <1102322516.8510.74.camel@pegasus>  <1102352066.640.3.camel@debian>
	 <1102323875.8510.78.camel@pegasus>  <1102354847.2296.3.camel@debian>
Content-Type: text/plain
Message-Id: <1102326999.9644.0.camel@pegasus>
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
Date: Mon, 06 Dec 2004 10:56:39 +0100

Hi Chen,

> > it is only compile tested, but actually from a code review it should do
> > exactly what was requested. If you wanna test it, you must change the
> > ie->data into ie->info, because the inquiry_data change is not yet
> > merged back into mainline. A new -mh patch will follow soon.
> > 
> 
> I have test my patch, and I will test yours too. 
> 
> And I wanna know which kernel version you current work on? Your new -mh
> patch will only apply to the newest kernel or olders too?
> 
> I don't know much about your patch convention.

if it says patch-2.6.9-mh4 then it applies cleanly against 2.6.9.

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
