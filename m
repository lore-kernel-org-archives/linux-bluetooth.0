Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Using two sco-channels
From: Marcel Holtmann <marcel@holtmann.org>
To: Jonas Tsang <d99jots@stud.hh.se>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001301c398bb$b5aa9eb0$0300a8c0@neonmura>
References: <001301c398bb$b5aa9eb0$0300a8c0@neonmura>
Content-Type: text/plain
Message-Id: <1066849199.16179.17.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 22 Oct 2003 20:59:53 +0200

Hi Jonas,

> I'm trying to make an easy application to connect a bt-device with two different headsets through sco-channels. The application is mainly based on hstest. Connection to the first headset works fine, but as soon as I try to open another sco-channel to the 2nd headset, it fails.I get an error message saying: "address already in use". I found that an error occurs when I try to bind a new socket to the same source-address (the bt-device). Does anyone know if it's possible to use two sco-channels simultaneously? (I'm not using any bluetooth USB dongle and creating two different RFCOMM-channels works fine.) Any suggestions?

this is a bug in sco.o kernel module.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
