Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300706012143s1444d9c9l98f2a06c8a05171b@mail.gmail.com>
References: <d89ddf300706012143s1444d9c9l98f2a06c8a05171b@mail.gmail.com>
Date: Sun, 03 Jun 2007 10:13:10 +0200
Message-Id: <1180858390.6872.5.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] fleshing out audio daemon scenarios
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Brad,

> I spent some time digging through the alsa api and experimenting with
> the daemons in plugz. I also looked over the traces as some alsa
> clients including kphone and twinkle. 
> 
> I came across two problems to the design we've discussed 
> 
> * for combo headsets, we incorrectly assumed we'd get a device open
> that was either write-only or read-write and use that to decide
> whether to use a2dp or sco
> * we didn't have any provisions for two headsets connecting
> independently which we might as well get right (imagine a voip
> appliance) 

please stop worrying so much about the combo headsets and the
complicated cases. We can fix them later. The goal should be to get
simple headsets working.

This means for me we have no ALSA plugin configuration option right now.
Let the ALSA plugin connect to the audio service and use whatever
headset or headphone it has available. Currently it is really not
important to get all possible scenarios covered.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
