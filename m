Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C7D8B8.1060701@messagenetsystems.com>
From: Jerry Geis <jgeis@messagenetsystems.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco.41 not compiling
References: <43C69F77.8050701@pagestation.com> <43C7D767.8080501@xmission.com>
In-Reply-To: <43C7D767.8080501@xmission.com>
Content-Type: multipart/alternative;
 boundary="------------020304080200050409030806"
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
Date: Fri, 13 Jan 2006 11:43:36 -0500

This is a multi-part message in MIME format.
--------------020304080200050409030806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

gcc -version reports 3.4.4

I am running a redhat kernel uname -r gives 2.6.9.-22.0.1-EL

My machine compiles alsa-drivers just fine. It has all kinds of
module_param_array statesments also....
Why would this be failing?

Jerry Geis
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677
(317)663-0808 Fax


Brad Midgley wrote:

>Jerry
>
>what compiler are you using again?
>
>also something may have changed from your 2.6.9 to 2.6.15. we've only
>been tracking the current kernel.
>
>brad
>
>  
>
>>I downloaded btsc.41 today. did the ./bootsrap; .configure; make ; make
>>install
>>all that was good.
>>cd kernel; make and I get the following errors from this section of code.
>>
>>
>>static int index[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -2}; /*
>>Exclude the first card */
>>
>>module_param_array(index, int, NULL, 0444);
>>MODULE_PARM_DESC(index, "Index value for Bluetooth SCO Headset
>>Soundcard.");
>>
>>
>>
>>
>>[root@geisjdell kernel]#
>>[root@geisjdell kernel]# make
>>make[1]: Entering directory `/usr/src/kernels/2.6.9-22.0.1.EL-i686'
>> CC [M]  /usr/src/btsco-0.41/kernel/btsco.o
>>/usr/src/btsco-0.41/kernel/btsco.c:88: error: invalid lvalue in unary
>>`&'
>>/usr/src/btsco-0.41/kernel/btsco.c:88: error: initializer element is not
>>constant
>>/usr/src/btsco-0.41/kernel/btsco.c:88: error: (near initialization for
>>`__param_arr_index.num')
>>make[2]: *** [/usr/src/btsco-0.41/kernel/btsco.o] Error 1
>>make[1]: *** [_module_/usr/src/btsco-0.41/kernel] Error 2
>>make[1]: Leaving directory `/usr/src/kernels/2.6.9-22.0.1.EL-i686'
>>make: *** [default] Error 2
>>[root@geisjdell kernel]#
>>
>>-----------------
>>
>>What  do I do?
>>
>>I am running centos 4.2, with kernel 2.6.9-22.0.1-EL.
>>alsa 1.0.11rc2
>>
>>Thanks,
>>
>>Jerry
>>
>>
>>
>>
>>
>>-------------------------------------------------------
>>This SF.net email is sponsored by: Splunk Inc. Do you grep through log
>>files
>>for problems?  Stop!  Download the new AJAX search engine that makes
>>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>>http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>    
>>
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

--------------020304080200050409030806
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="+1">gcc -version reports 3.4.4<br>
<br>
I am running a redhat kernel uname -r gives 2.6.9.-22.0.1-EL<br>
<br>
My machine compiles alsa-drivers just fine. It has all kinds of <br>
module_param_array statesments also....<br>
Why would this be failing?<br>
</font>
<div class="moz-signature"><font color="blue" face="Arial,Helvetica"><br>
Jerry Geis
<br>
MessageNet Systems
<br>
101 East Carmel Dr. Suite 105
<br>
Carmel, IN 46032
<br>
(317)566-1677
<br>
(317)663-0808 Fax
</font></div>
<br>
<br>
Brad Midgley wrote:
<blockquote cite="mid43C7D767.8080501@xmission.com" type="cite">
  <pre wrap="">Jerry

what compiler are you using again?

also something may have changed from your 2.6.9 to 2.6.15. we've only
been tracking the current kernel.

brad

  </pre>
  <blockquote type="cite">
    <pre wrap="">I downloaded btsc.41 today. did the ./bootsrap; .configure; make ; make
install
all that was good.
cd kernel; make and I get the following errors from this section of code.


static int index[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -2}; /*
Exclude the first card */

module_param_array(index, int, NULL, 0444);
MODULE_PARM_DESC(index, "Index value for Bluetooth SCO Headset
Soundcard.");




[root@geisjdell kernel]#
[root@geisjdell kernel]# make
make[1]: Entering directory `/usr/src/kernels/2.6.9-22.0.1.EL-i686'
 CC [M]  /usr/src/btsco-0.41/kernel/btsco.o
/usr/src/btsco-0.41/kernel/btsco.c:88: error: invalid lvalue in unary
`&amp;'
/usr/src/btsco-0.41/kernel/btsco.c:88: error: initializer element is not
constant
/usr/src/btsco-0.41/kernel/btsco.c:88: error: (near initialization for
`__param_arr_index.num')
make[2]: *** [/usr/src/btsco-0.41/kernel/btsco.o] Error 1
make[1]: *** [_module_/usr/src/btsco-0.41/kernel] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.9-22.0.1.EL-i686'
make: *** [default] Error 2
[root@geisjdell kernel]#

-----------------

What  do I do?

I am running centos 4.2, with kernel 2.6.9-22.0.1-EL.
alsa 1.0.11rc2

Thanks,

Jerry





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log
files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
<a class="moz-txt-link-freetext" href="http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click">http://ads.osdn.com/?ad_id=7637&amp;alloc_id=16865&amp;op=click</a>
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>
    </pre>
  </blockquote>
  <pre wrap=""><!---->


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

--------------020304080200050409030806--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
