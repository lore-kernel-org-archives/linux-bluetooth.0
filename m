Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: read_RSSI and others not thread-safe?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4166BA03.9050106@uni-paderborn.de>
References: <41668ADE.7010004@uni-paderborn.de>
	 <4166A8D8.3080707@uni-paderborn.de> <1097249347.4407.21.camel@pegasus>
	 <4166B45C.1000802@uni-paderborn.de> <1097250057.4407.25.camel@pegasus>
	 <4166BA03.9050106@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1097251600.4407.29.camel@pegasus>
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
Date: Fri, 08 Oct 2004 18:06:40 +0200

Hi Stefan,

> Ok, but I don't understand why my problem occurs. Look at this:
> - thread T1 does hci_send_req(read_RSSI), waits for event E1
> - thread T2 does hci_send_req(read_RSSI), waits for event E2
> - Lets assume E2 comes earlier than E1
> Why do BOTH threads receive E2? When is an event consumed?

both are waiting for the next RSSI event and if one occurs both return
with that value. As you already noticed there is no comparison of the
connection handle. All outstanding events are discarded when the socket
descriptor is closed.

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
