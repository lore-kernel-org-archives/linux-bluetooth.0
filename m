Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FE04C90.8050109@grupopie.com>
From: Paulo Marques <pmarques@grupopie.com>
MIME-Version: 1.0
To: Marc Hansen <marc.hansen@gmx.net>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Networkperformance
References: <23028.1071640737@www51.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 17 Dec 2003 12:31:12 +0000

Marc Hansen wrote:

> Hi, 
> my Networkconnection is now stable for ours. Max was right not to use the 
> alternate usbdriver! :-) 
>  
> How fast could be network over bluetooth? 
> I tried to see the performance with iptraf, but that does not work. 

Best way to test it IMHO is to setup a BNEP (PAN) connection and measure the 
speed of a FTP transfer over that link.

This will give you the "net" bandwidth an application is supposed to get over IP 
over bluetooth.

Note that even BNEP as some overhead as the IP / Ethernet headers have to go 
through the connection, even if they are compressed/simplified.

I hope this helps,

-- 
Paulo Marques
Software Development Department - Restinfor, Lda.
Phone: +351 252 290600, Fax: +351 252 290601
Web: www.grupopie.com

"In a world without walls and fences who needs windows and gates?"



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
