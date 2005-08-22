Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Rescuing a WML C09 AHR by SPI
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050821215602.GA19979@externe.net>
References: <20050821215602.GA19979@externe.net>
Content-Type: text/plain
Message-Id: <1124709049.23599.16.camel@pegasus>
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
Date: Mon, 22 Aug 2005 13:10:49 +0200

Hi Guylhem,

> I have a problem with a WML C09 AHR bluetooth module purchased from
> Segor Germany.
> 
> The problem is similar to:
> http://www.handhelds.org/hypermail/familiar/132/13253.html
> 
> I had a kernel panic while issuing commands to the module (I'm working
> on some MMC stuff hooked to the same serial port, but to
> DSR/DRT/RI/DCD lines and my stuff is not that stable)
> 
> Result: I could only write 1f9 0001 - I couldn't do the 191 part.
> 
> I tried the recommanded rescue mode from CSR forums:
> http://66.102.9.104/search?q=cache:XnYWRYWUhSsJ:www.csr.com/ubb/Forum2/HTML/000185.html+pskey+csr+but&hl=fr&client=firefox-a
> 
> Unfortunately, it didn't work. I would like to try to rescue the chip
> via its SPI port since it is easily accessible.
> 
> My problem is I don't know how to do that (any link is appreciated) on
> both the hardware side and the software side (!)
> 
> Maybe someone can help?

the CSR guys told me that sometimes the only way is to use their
BlueFlash tool (for Windows) and fully erase the flash and start over
with a new boot loader and a new firmware image.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
