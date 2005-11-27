Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multiple rfcomm listeners
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <438A2C5B.9050306@xmission.com>
References: 
	 <Pine.LNX.4.33.0511271455120.20980-100000@redbean.intranet.gw-instruments.de>
	 <1133116410.13629.6.camel@blade>  <438A21B2.40609@xmission.com>
	 <1133128026.13629.18.camel@blade>  <438A2C5B.9050306@xmission.com>
Content-Type: text/plain
Message-Id: <1133129290.13629.37.camel@blade>
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
Date: Sun, 27 Nov 2005 23:08:10 +0100

Hi Brad,

> > You can do whatever you like. Use UUID-128 to identify your service and
> > use PSM numbers starting with 4097 (0x1001).
> 
> I'm trying to have it coexist with gps clients (like pocketpc pda) that
> are looking for the real rfcomm on psm 3. I suspect from looking in the
> kernel that the rfcomm kernel module really has to be unloaded before
> you can bind a server socket with psm 3. That's just a little too gross.

as I said, you can have multiple connections to the same PSM. However
these must be handled by the same listener. So you need to replace (or
unload) the RFCOMM module. However this will not give you anything,
because you still have to speak RFCOMM to these clients.

What you might wanna do is to modify the sdpd server to handle out
different service records (based on the remote BD_ADDR).

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
