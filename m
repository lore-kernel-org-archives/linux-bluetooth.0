Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN data corruption
From: Fredrik Noring <noring@nocrew.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1074941532.6007.22.camel@localhost.localdomain>
References: <1074941532.6007.22.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1074945187.6007.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 24 Jan 2004 12:53:07 +0100

>    - Using scp, copying more than a few megabytes often gives 
>      "Corrupted MAC on input".
> 
>    - Using netcat, copying a 53244356 byte source file results
>      in a 53243904 byte destination file. It stops 452 bytes short
>      of a complete file.

Aborting netcat gives a complete file (with a correct md5sum) so it
didn't trig a problem. The scp error remains.

Fredrik




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
