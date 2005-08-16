Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] save_link_key in 2.19
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200508112219.12677.adam.cooper@port.ac.uk>
References: <200508112219.12677.adam.cooper@port.ac.uk>
Content-Type: text/plain
Message-Id: <1124206342.7466.14.camel@pegasus>
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
Date: Tue, 16 Aug 2005 17:32:22 +0200

Hi Adam,

> I've just spent the last couple of hours trying to figure out why my 'hcid' 
> was not storing my paired devices between restarts. I'm running gentoo and 
> the latest version of bluez utils (2.19). 
> 
> In a final act of desperation I had a good hunt through the code. Low and 
> behold the 'save_link_key' function has been commented out, along with the 
> calls to it.
> 
> Is there a specific reason this is so? 
> 
> My mobile runs with it's visibility off so not being able to save pairings is 
> a bit of a pain.

the newer hcid stores the link keys under /var/lib/bluetooth/. Check if
you see a directory with your BD_ADDR there.

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
