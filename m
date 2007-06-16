Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <467297DF.2030401@access-company.com>
References: <467297DF.2030401@access-company.com>
Date: Sat, 16 Jun 2007 09:31:20 +0200
Message-Id: <1181979080.6846.53.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Input service signals
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

Hi Frederic,

> I am using the Input service. It is very helpful.
> 
> But Connected/Disconnected signals from Device interface are currently 
> only sent when connection/disconnection are done through the Device 
> interface methods. They are not sent when remote device 
> connects/disconnects.
> 
> I wrote a patch that move common code between server.c and device.c into 
> a new file session.c. This allows to send those signals for all 
> connect/disconnect.

I haven't looked at your patch, but I agree that we should send the
signals when the remote device re-connects. I wait for Claudio's or
Johan's comments on that patch.

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
