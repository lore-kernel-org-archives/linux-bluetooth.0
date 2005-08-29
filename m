Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pand Encryption
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <025601c5ac6f$2c7cc950$6c01a8c0@Vijayakumar>
References: <025601c5ac6f$2c7cc950$6c01a8c0@Vijayakumar>
Content-Type: text/plain
Message-Id: <1125308699.25073.11.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 29 Aug 2005 11:44:59 +0200

Hi Vijayakumar,

> Iam using pand version 2.17 and establishing pan connection between 2
> bluetooth devices.

update to bluez-utils-2.20 and use the latest 2.6 kernel.
 
> I find that even though I enable both authentication and encryption on
> one side and only authentication on the other side(thru hciconfig),
> still the connection gets established and iam able to transfer files
> thru this connection and read them on the other side....My doubt is
> how does connection is created even if encryption is disabled on the
> other side....

The security mode 1 says, if one side wants authentication or
encryption, the other side must do it too or disconnect.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
