Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Setup of a Bluetooth mouse using software
	version 2.03
From: Marcel Holtmann <marcel@holtmann.org>
To: Eric Gandt <EricGandt@netscape.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <0135FF90.5D970D71.0241D6B9@netscape.net>
References: <0135FF90.5D970D71.0241D6B9@netscape.net>
Content-Type: text/plain
Message-Id: <1090395597.21683.43.camel@pegasus>
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
Date: Wed, 21 Jul 2004 09:39:57 +0200

Hi Eric,

> I'm trying to setup my microsoft bluetooth mouse under Linux (SuSE 9.1 Pro) and have the base packages that come with SuSE installed these are:
> bluez-bluefw: 1.0-202
> bluez-libs: 2.5.43
> bluez-pan: 1.1-109
> bluez-sdp: 1.5-59
> bluez-utils: 2.4.65
> 
> With the given software installed and running I can find the mouse id: 00:50:F2:7F:XX:XX without issue, but can not discover any way to connect the device to a serial port so that I may use the mouse.  All of the information I can find on setting up a mouse requires the use of bthid or hcidd I have neither of these as they appear to be part of version 2.08, however my attempts to install 2.08, after removing all old SuSE 9.1 BT related software frist, results in my being unable to install bluez-util as it can not find a few needed links in the lbluebooth libary, however I also can not build bluez-util againist the version 2.5 that comes with SuSE so I'm out of luck with that as well.  Thus I want to use what I have and configure my mouse can it be done?  Has anyone actaully got it to work.

what do you need is only bluez-libs-2.8 and bluez-utils-2.8. If you
don't get any updates of the BlueZ packages for SuSE 9.1 then you have
to install them by yourself from the source code. And of course you need
a least a 2.6.7-mh2 or 2.6.8-rc2 kernel to get your mouse working.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
