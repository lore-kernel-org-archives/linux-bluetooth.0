Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0705240306s1c9fc345x860dc75b9955d6f@mail.gmail.com>
References: <57c68ddc0705240306s1c9fc345x860dc75b9955d6f@mail.gmail.com>
Date: Thu, 24 May 2007 12:08:33 +0200
Message-Id: <1180001313.26519.22.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] remote device identification
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

>               I recently came upon this white paper name as
> blueprinting (titled Remote Device Identification based on Bluetooth
> Fingerprinting Techniques) which presents a way of identifying remote
> device by using sdp discovery records. 
> 
> What this paper claims is that by using combination of first 3 bytes
> of bluetooth address and number obtained by multiplying service record
> handle and rfcomm channel of OBEX push services one can identify the
> brand or make of the device. 
> 
> I would like to know how reliable this method is  , also can u suggest
> other techniques which can accomplish such thing.

it is not really reliable anymore. Too many vectors changed over the
last 2 years.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
