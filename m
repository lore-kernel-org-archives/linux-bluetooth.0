Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: "Ademar de Souza Reis Jr." <ademar@conectiva.com.br>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40E02D93.8090305@conectiva.com.br>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
	 <20040627125235.GA15938@gmx.net>  <40E02D93.8090305@conectiva.com.br>
Content-Type: text/plain
Message-Id: <1088434128.4614.27.camel@pegasus>
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
Date: Mon, 28 Jun 2004 16:48:48 +0200

Hi Ademar,

> While we're at this topic: Is there a way to get a license to use the bluez 
> code in a comercial, closed-source, product? (I was thinking about something 
> like what QT/Trolltech does).

the kernel part of BlueZ is GPL and will stay as GPL forever. Another
license makes no sense here.

For the BlueZ library and the utilities we can talk about it. Some time
ago people asked for a LGPL version of the library and actually I tend
to agree with that. However this can't be decided by me alone, because
part of the code is copyright by Qualcomm and also by Maxim Krasnyansky
himself. For the utilities I don't see any need for a different license.

I believe in the GPL and from my view releasing the Linux Bluetooth
library under LGPL is the only step I wanna make forward to allow closed
source products based on BlueZ.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
