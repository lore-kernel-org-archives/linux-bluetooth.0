Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F128F4.2020006@webstuhl.net>
From: Ben Pezzei <ben@webstuhl.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Again: Problems with Dongle, Headset or btsco
References: <41F0EB0A.1020302@webstuhl.net> <41F0FE84.8030401@dark-reality.de>
In-Reply-To: <41F0FE84.8030401@dark-reality.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 21 Jan 2005 17:08:20 +0100

Hi Lars,

Tnx for your reply

Lars Grunewaldt schrieb:

...

> 3. disconnect the headset by pressing the "connect" button of the
> headset again. Audio stops working until you "connect" again with the
> button.

like i said, the rfcomm connection is fine: (output from btsco <addr>):

   Device is 1:0
   Voice setting: 0x0060
   RFCOMM channel 1 connected
   recieved AT+CKPD=200
   opened hwdep
   connected SCO channel
   Setting sco fd
   Done setting sco fd
   recieved AT+VGS=04
...

after reconnecting via headset:
   disconnected SCO channel
   recieved AT+CKPD=200
   opened hwdep
   Can't connect SCO audio channel
   : Connection timed out

I always have to replug the dongle and restart btsco.

The question remains: Do I need the patch-2.6.10-mh1.gz patch?

I guess the Problem has to do with the SCO or ALSA Stuff

> If you did everything like this, it should work like described. If it
> does not, you might need another dongle :)

well, looks like the anycom 240 is fubar

greetings
ben



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
