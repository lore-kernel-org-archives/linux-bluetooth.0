Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Support for stored link keys
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1114094787.32265.11.camel@pegasus>
References: <1114094787.32265.11.camel@pegasus>
Content-Type: text/plain
Message-Id: <1114712900.12012.365.camel@baythorne.infradead.org>
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
Date: Thu, 28 Apr 2005 19:28:20 +0100

On Thu, 2005-04-21 at 16:46 +0200, Marcel Holtmann wrote:
> Another thing is if we should use /var/lib64/bluetooth on 64-bit
> platforms? What is the deal for the /var directory on these
> architectures?

Only arch-specific binary stuff which is 64-bit should go in lib64.
Since none of that should be in /var anyway, I think there is
no /var/lib64.


-- 
dwmw2




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
