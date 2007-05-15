Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6669365c0705150801g1868b3c4v40c59eba01e6e832@mail.gmail.com>
References: <6669365c0705150801g1868b3c4v40c59eba01e6e832@mail.gmail.com>
Date: Tue, 15 May 2007 17:31:41 +0200
Message-Id: <1179243101.10069.23.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] BCM2035 on UART at speeds higher than 230400
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

Hi Daniel,

> I am working on bluetooth support for the Motorola EZX platform
> (a780/e680 phones) and i am unable to hciattach bcm2035 at baud rates
> higher than 230400.
> 
> I reverse engineered the original firmware and found that it uses a
> different argument to the hci command that sets the baud rate when
> setting 460800 and 921600, i have changed hciattach.c and it works at
> full speed for me now.
> 
> What i want to know is if anyone is using this chip at rates higher
> than 230400 before submiting my patch, so it doesnt break anyone else
> work. Currently i know that the EZX platform and most Palm handhelds
> use this chip on the UART port. My patch works for EZX and i am
> waiting feedback from the hackndev guys about the palms. 
> 
> My patch also adds support for setting the bdaddr on chip init,
> otherwise this chip gets 00:00:00:00:00:00.

post your patch and I will integrate it.

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
