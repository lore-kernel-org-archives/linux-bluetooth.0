Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001301c5b0be$d4717f90$0100a8c0@rdhome>
From: "Oliver Ruiz Dorantes" <urnenfel@tiscali.es>
To: <bluez-devel@lists.sourceforge.net>
References: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local> <001601c5b09c$df79dee0$0201a8c0@NBVICTOR>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Subject: [Bluez-devel] bcm2035
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
Date: Sat, 3 Sep 2005 21:36:45 +0200

Hello all,

Anybody tested the chip 2035 under BlueZ stack?

I have been playing with it with good results, but suddently i get the 
BD_ADDR as 00:00:00:00:00:00, and the dongle due to this (i think) is not 
working even in windows. All other commands or inquiry process is working

Looks like it forgot its BD_ADDR, and as far as i know there is no SW 
way(hci command) to set it again, I wonder if there is a SW way that i could 
have deleted it by mistake....

The model is BT3035 from Tecom with as i said the chip is Broadcom 2035

Any idea / advice ?

thanks 


		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
