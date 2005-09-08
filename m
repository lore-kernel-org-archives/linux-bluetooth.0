Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Converting a PC in a multiradio access point
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <01C5B49E.6F5C7590.emonturus@teltronic.es>
References: <01C5B49E.6F5C7590.emonturus@teltronic.es>
Content-Type: text/plain
Message-Id: <1126221207.5286.63.camel@blade>
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
Date: Fri, 09 Sep 2005 01:13:27 +0200

Hi Esteban,

> 	I want to configure a PC to work as multiradio access point. In order to 
> do that, I have plugged two USB dongles to a PC and entered the command 
> "pand --listen --role PANU". When I establish the first PAN connection from 
> another computer the bnep0 interface appears in both PC's and there is no 
> trouble. Without terminating this connection, I try to establish a new one 
> with the other dongle of the acces-point-computer and it fails. In the 
> /var/log/messages file of the access-point-computer appears the following 
> error message: pand[7546]: Connection failed. File exists(17). It is not 
> relevant whether the computer I try to connect from is the same as in the 
> first PAN connection. I don't understand this limitation because if both 
> connections are established from the computer that has two dongles 
> everything works well.

send in the output of "hciconfig -a" and run "hcidump -X -V" when you
try to connect.

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
