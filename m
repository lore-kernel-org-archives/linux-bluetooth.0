Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000901c52fa7$1a47bc80$52cc13ac@stu.nus.edu.sg>
From: "Khoo Teck Ping" <eng10166@nus.edu.sg>
To: <bluez-devel@lists.sourceforge.net>
References: <20050323115636.85967.qmail@web52406.mail.yahoo.com>
Subject: Re: [Bluez-devel] file transfer using ObexFTP
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
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
Date: Wed, 23 Mar 2005 20:51:54 +0800

hullo Jose

You may run the following

#obexftp -b 00:0a:d9:xx:xx:xx -B 10 -g telecom/pb.vcf

to download the entire address book from a Sony Ericsson T610/T630.

where -b <bluetooth address>
and -B <rfcomm ports 1~30>
and -g <file location on phone>

On the T630 ports 10 and 15 are open, as in you may connect to them without 
pairing.

You may try downloading other types of files.

Teck Ping


----- Original Message ----- 
From: "jose" <twblr@yahoo.com>
To: <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, March 23, 2005 7:56 PM
Subject: [Bluez-devel] file transfer using ObexFTP


> hi,
>
> how do i transfer files using obexFTP, from pc to pc
> (both running linux), or from pc (running linux) to a
> bluetooth enabled mobile.
>
> Rgds,
> Jose.
>
>
>
> __________________________________
> Do you Yahoo!?
> Make Yahoo! your home page
> http://www.yahoo.com/r/hs
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
> Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
> for the chance to win $25,000 and application distribution. Enter today at
> http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel 



-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
