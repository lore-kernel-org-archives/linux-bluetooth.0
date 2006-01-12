Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C690DB.9050204@pagestation.com>
From: Jerry Geis <geisj@pagestation.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco.41 and config.log does not give a ko file
References: <43C675A7.1040308@pagestation.com> <43C68EEF.4070801@xmission.com>
In-Reply-To: <43C68EEF.4070801@xmission.com>
Content-Type: multipart/alternative;
 boundary="------------000102070405000804040705"
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
Date: Thu, 12 Jan 2006 12:24:43 -0500

This is a multi-part message in MIME format.
--------------000102070405000804040705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thanks I have been reading the README.
I was confused, typically I do the configure, make , make install.
I now see there this the step of cd kernel and make also.

when I cd into the kernel directory
and type make I get:

btsco.c:88 error: invalid lvalue in unary &
btsco.c:88 error: initalizer element is not constant
btsco.c:88 erorr: (near initialization for __param_arr_index.num

What do I do about that??

Thanks jerry



Brad Midgley wrote:

>Jerry
>
>  
>
>>I just downloaded btsco.41 did the ./configure; make; make install
>>I have no ko file in the the btsco.41 directory.
>>
>>I had a problem where it could not find ao.h. I fixed that with "up2date
>>libao-devel".
>>I am using centos 4.2 which is compatible with RHEL 4.2.
>>    
>>
>
>the libao thing shouldn't have caused problems. I guess --disable-aotest
>should have been specified when you didn't have the package
>
>cd to the directory "kernel" and run make there to get the kernel
>modules (just checked the docs; it's build step #4 on
>http://bluetooth-alsa.sourceforge.net/ )
>
>brad
>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>  
>

--------------000102070405000804040705
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="+1">Thanks I have been reading the README.<br>
I was confused, typically I do the configure, make , make install. <br>
I now see there this the step of cd kernel and make also.<br>
<br>
when I cd into the kernel directory<br>
and type make I get:<br>
<br>
btsco.c:88 error: invalid lvalue in unary &amp;<br>
btsco.c:88 error: initalizer element is not constant<br>
btsco.c:88 erorr: (near initialization for __param_arr_index.num<br>
<br>
What do I do about that??<br>
<br>
Thanks jerry<br>
</font>
<div class="moz-signature"><font color="blue" face="Arial,Helvetica"><br>
</font>
</div>
<br>
<br>
Brad Midgley wrote:
<blockquote cite="mid43C68EEF.4070801@xmission.com" type="cite">
  <pre wrap="">Jerry

  </pre>
  <blockquote type="cite">
    <pre wrap="">I just downloaded btsco.41 did the ./configure; make; make install
I have no ko file in the the btsco.41 directory.

I had a problem where it could not find ao.h. I fixed that with "up2date
libao-devel".
I am using centos 4.2 which is compatible with RHEL 4.2.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
the libao thing shouldn't have caused problems. I guess --disable-aotest
should have been specified when you didn't have the package

cd to the directory "kernel" and run make there to get the kernel
modules (just checked the docs; it's build step #4 on
<a class="moz-txt-link-freetext" href="http://bluetooth-alsa.sourceforge.net/">http://bluetooth-alsa.sourceforge.net/</a> )

brad




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
<a class="moz-txt-link-freetext" href="http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click">http://ads.osdn.com/?ad_id=7637&amp;alloc_id=16865&amp;op=click</a>
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>


  </pre>
</blockquote>
</body>
</html>

--------------000102070405000804040705--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
