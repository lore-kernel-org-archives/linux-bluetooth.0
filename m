Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] tcsendbreak and flow control on hciattach (csr
	chip)
From: Marcel Holtmann <marcel@holtmann.org>
To: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <39417DF3286A66428FA558987839F44F152D99@SINTEFXCH01.sintef.no>
References: <39417DF3286A66428FA558987839F44F152D99@SINTEFXCH01.sintef.no>
Content-Type: text/plain
Message-Id: <1097229854.4893.4.camel@pegasus>
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
Date: Fri, 08 Oct 2004 12:04:17 +0200

Hi Dag,

> If I enable both flow control and send break with hciattach:
> hciattach -b ttyS1 csr 921600 flow
> 
> The unit fails to initialize. This does not happen if I disable flow
> control, or send break.
> The problem is also solved by setting a sleep of 0.5 seconds after the
> tcsendbreak command in the hciattach.c code.
> 
> This is on an Intel XScale platform.
> 
> I use bluez libs and bluez utils 2.9 on a 2.4.21 kernel with the mh9
> patch.
> 
> Any ideas for another solution than the usleep, or is this the best
> solution?

maybe this is CSR specific, I don't know. Actually I wasn't aware of
that the -b option is really used. However if the 0.5 seconds sleep is
needed then send me a patch for it and I will apply it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
