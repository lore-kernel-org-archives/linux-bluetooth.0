Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Power Transmit Level
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <000801c5f9a8$c9c6fb50$44cfd29b@MONFLORITE>
References: <000801c5f9a8$c9c6fb50$44cfd29b@MONFLORITE>
Content-Type: text/plain
Message-Id: <1133818276.4559.2.camel@localhost.localdomain>
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
Date: Mon, 05 Dec 2005 22:31:16 +0100

Hi Israel,

> I am using bluez-libs and utils 2.22 to measure the current transmit
> power level in my application. I get good results when the power level
> is over zero, but when a negative value should be returned, I get
> extremly high values instead; for example, 250. 
> My opinion is that this value is treated as unsigned integer when it
> is a signed integer. I am running on Debian, in case it matters.
> If somebody has observed the same, please tell me so. I don't
> know whether the problem is in my computer or in the stack.

take a look at the source code and the Bluetooth specification.

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
