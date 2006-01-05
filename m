Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43BD6E9C.9040002@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco 0.4 and choke me.
References: <43BD536E.4070902@pagestation.com>
In-Reply-To: <43BD536E.4070902@pagestation.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 05 Jan 2006 12:08:12 -0700

Jerry

The "choke me" stuff is a delightful easter egg in autoconf.

It might be complaining that your c compiler can't also do c++. It's too
bad since we don't even have any c++ in our project. I'm not familiar
enough with autoconf to be sure.

Brad

> I download btsco.0.4 and attempted to install on centos 4.2.
> I get an error on configure about failed program.
> 
> #ifndef __cplusplus
>  choke me
> #endif
> 
> What do I do about that?
> 
> THanks,
> 
> Jerry
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
