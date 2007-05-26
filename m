Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46580A33.3030701@idlum.be>
References: <46580A33.3030701@idlum.be>
Date: Sat, 26 May 2007 13:01:29 +0200
Message-Id: <1180177290.21432.42.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] New Serial DBus API - how to choose dongle used?
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

Hi Pierre-Yves,

> Since bluez-utils v3.10, the new Serial API is included, and the 
> previous RFCOMM API has been removed. The first semms to functionnaly 
> replace the latter.
> 
> If I'm right, some calls previously done in the RFCOMM hierarchy now 
> have to be done in the Serial one. For some of them, changes look like this:
> 
> RFCOMM: String Connect(String address, String service);
> Serial: String ConnectService(String address, String pattern);
> 
> RFCOMM: String ConnectByChannel(String address, byte channel);
> Serial: No equivalent so far

simply use ConnectService(<bdaddr>, channel). The pattern matching works
the that if you give a decimal number that it connects to the specified
channel.

> RFCOMM: void Disconnect(String device);
> Serial: void DisconnectService(String device);
> 
> RFCOMM: void CancelConnect(String address, String service);
> Serial: void CancelConnectService(String address, String pattern);
> 
> Apart for the missing "ConnectByChannel", it seems looks indeed very 
> similar.

It is fully compatible.

> But there is somethig different: object path for RFCOMM was 
> /org/bluez/{hci0,hci1,...} (eg. one RFCOMM object for each physical 
> Adapter). But according to the doc, object path for Serial is 
> /org/bluez/serial (eg, IIUC one single Manager).
> 
> So, my question: how do I choose which dongle to use to perform the 
> connection with the new implementation, in case several are connected to 
> the system?

We don't support this. At least not yet. At some point, we might have
additional methods that let you choose a source address. However that is
not our priority at the moment.

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
