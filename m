Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 07 Aug 2006 12:29:40 -0500
From: digitalfredy <digitalfredy@debiancolombia.org>
In-reply-to: <20060806203043.GA17698@refinery.twat.com.ar>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1154971782.4625.6.camel@YODA>
MIME-version: 1.0
References: <20060803043158.GA13259@refinery.twat.com.ar>
	<1154888079.7923.13.camel@YODA>
	<20060806203043.GA17698@refinery.twat.com.ar>
Subject: Re: [Bluez-users] Cannot transfer files via OBEX
Reply-To: digitalfredy@debiancolombia.org,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Try get any file from the phone, for example for get any video:

obexftp -b 00:16:20:F1:47:68 -B 6 -l -c Videos

when you know the name of the videofile to like get made it

obexftp -b 00:16:20:F1:47:68 -B 6 -c Videos -g videoname.3gp

send my the log
> 
> [1038] # obexftp -b 00:16:20:F1:47:68 -B 6 -l
> Browsing 00:16:20:F1:47:68 ...
> Channel: 6
> Connecting...done
> Receiving "(null)"... <?xml version="1.0" encoding="UTF-8"?>
> <!DOCTYPE folder-listing SYSTEM "obex-folder-listing.dtd">
> <!--
>  XML Coder, Nov 14 2005, 23:41:10, (C) 2001 Sony Ericsson Mobile Communications AB 
> -->
> <folder-listing version="1.0"><folder name="Pictures"/>
> <folder name="Sounds"/>
> <folder name="Themes"/>
> <folder name="Videos"/>
> <folder name="Other"/>
> </folder-listing>
> done
> Disconnecting...done


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
