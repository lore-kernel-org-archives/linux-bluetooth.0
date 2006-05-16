Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4469C2F9.4010803@palmsource.com>
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth-alsa compile Issues
References: <50307.71.109.111.205.1147543317.squirrel@71.109.111.205> <4468D527.7020403@thewybles.com>
In-Reply-To: <4468D527.7020403@thewybles.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 16 May 2006 14:18:01 +0200

Hi,

you might look at package 0.42 available for download on sourceforge as=20
it seems that cvs.sourceforge.net is no longer used.
package 0.42 nearly compiled fine but you should get libsbc first.

Frederic


Charles Wyble a =E9crit :

> Any update on this? Is this the right place to ask questions about=20
> bluetooth alsa?
>
> charles@thewybles.com wrote:
>
>> Hello everyone,
>>
>>    I am attempting to compile bluetooth-alsa from CVS (freshly=20
>> checked out
>> before sending this e-mail). It fails. Here are the issues:
>>
>> 1. Missing config.h.in
>> 2. Missing .po files
>>
>> Is the bluetooth-alsa project still using CVS? Should I be looking
>> somewhere else other then the SF CVS repository for the code? I would
>> greatly appreciate if someone could do a fresh checkout and see if the=
y
>> can reproduce the problem. I am running debian testing. I have the=20
>> latest
>> versions of autotools as well as version 1.7 as mentioned on the=20
>> site. The
>> compile fails with both.
>>
>>
>> If I can be of any further assistance please let me know. I am more th=
en
>> happy to try with autoconf hackery etc. Whatever is needed.
>>
>> Thanks!
>



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
