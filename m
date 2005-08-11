Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Adam Cooper <adam.cooper@port.ac.uk>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200508112219.12677.adam.cooper@port.ac.uk>
Subject: [Bluez-devel] save_link_key in 2.19
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
Date: Thu, 11 Aug 2005 22:19:12 +0000

Hi there,

I've just spent the last couple of hours trying to figure out why my 'hcid' 
was not storing my paired devices between restarts. I'm running gentoo and 
the latest version of bluez utils (2.19). 

In a final act of desperation I had a good hunt through the code. Low and 
behold the 'save_link_key' function has been commented out, along with the 
calls to it.

Is there a specific reason this is so? 

My mobile runs with it's visibility off so not being able to save pairings is 
a bit of a pain.

Thanks 
Adam Cooper


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
