Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Master, Slave and Maximal Peers Questions
From: Marcel Holtmann <marcel@holtmann.org>
To: ag@new-media-artists.de
Cc: Bluez Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <FJENILNPNAGPJMMDOKDCMEBHDMAA.ag@new-media-artists.de>
References: <FJENILNPNAGPJMMDOKDCMEBHDMAA.ag@new-media-artists.de>
Content-Type: text/plain
Message-Id: <1074353316.2629.148.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 17 Jan 2004 16:28:37 +0100

Hi Andreas,

> >I don't see any reason why you can't connect a third device into this
> >piconet. Run "hcidump -w <file>" for the third connection, so we can see
> >what happens on the HCI layer.
> 
> you where right, there is no problem with connecting more than two with
> rfcomm. I just saw "device or resource busy" from rfcomm often in my logs so
> i assumed it would be that reason but it wasnt. Now i have to find out what
> was the reason for this. Any what would be the most obvious reasons for
> this, if any?

what is the correct errno that would be returned? Run hcidump as I told
you.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
