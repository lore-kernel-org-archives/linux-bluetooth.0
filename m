Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2dp on maemo/nokia770
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051219134257.GJ20677@null.research.nokia.com>
References: <43A18AB3.2090507@xmission.com>
	 <20051216130359.GD20677@null.research.nokia.com>
	 <1134743177.4239.29.camel@localhost>
	 <20051219134257.GJ20677@null.research.nokia.com>
Content-Type: text/plain
Message-Id: <1135000982.31688.28.camel@localhost>
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
Date: Mon, 19 Dec 2005 15:03:02 +0100

Hi Ville,

> > since I've already seen Nokia phones with A2DP Source capabilities, the
> > question is now is this a bought solution or is developed inside Nokia.
> > If it is developed inside Nokia you might wanna share it or help us out
> > to get our SBC in shape and really good and fast.
> 
> I wouldn't hold my breath to see that happening. Whan is the situation
> with current SBC? What is missing? Is performance optimal? I have
> followed discussions about it and there seems to be fixed point
> implementaion allready but that has poor quality compared to floating
> point version. 

this is what I know. Bard of course would have more details since I
haven't done any SBC related work for some time. I am not a codec expert
and so not really helpful, but I still think that fixed point is the
only way to go. Some people at the UPFs acknowledge this, but of course
without any details about actual code.

> > The Nokia 770 is using a TI chip and basically nobody of us has real
> > experiences with these chips. I have seen them in an iPAQ and now the
> > 770, but that's it. Do you think Nokia is willing to donate some of the
> > TI development kits to BlueZ? Especially the SCO and eSCO stuff needs a
> > lot of testing and I would prefer to do it with an i386 or x86_86 based
> > system.
> 
> I'll try to arrange something.

This would be great, thanks.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
