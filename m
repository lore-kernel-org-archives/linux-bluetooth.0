Return-Path: <cyrus@holtmann.org>
Message-ID: <48357D9C.9080009@access-company.com>
Date: Thu, 22 May 2008 16:05:16 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48075B6A.2060308@access-company.com>	<1209058941.12684.37.camel@violet.holtmann.net>	<48355289.7070906@access-company.com>
	<5D487EED-A2B2-4AEA-AA7B-9EC8681157C0@holtmann.org>
In-Reply-To: <5D487EED-A2B2-4AEA-AA7B-9EC8681157C0@holtmann.org>
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


>> A part of the patch si to move handling of incoming setup_conn_req  
>> in kernel. In order to keep pan working with older kernel, some  
>> differenciation must be done. How to achieve this ?
>>     
>
> I don't know yet. Can we first fix the issues that don't need  
> modifications within the kernel. I prefer not modifying the kernel at  
> all at the moment.
>
>   

I understand.
My problem is that some tests require grouping several messages into 
one. In particular, the setup_conn_req can be sent together with a 
control extension TP/BNEP/CTRL/BV-19-C.
The current extension processing is to skip everything and I'm not sure 
the control message can be handled at application level.

Frederic


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
