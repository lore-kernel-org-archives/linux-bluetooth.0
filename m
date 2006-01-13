Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C80A35.3000101@messagenetsystems.com>
From: Jerry Geis <jgeis@messagenetsystems.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco.41 not compiling
References: <43C69F77.8050701@pagestation.com> <43C7D767.8080501@xmission.com> <43C7D8B8.1060701@messagenetsystems.com> <43C7D992.7040401@xmission.com>
In-Reply-To: <43C7D992.7040401@xmission.com>
Content-Type: multipart/alternative;
 boundary="------------080708020901080402010106"
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
Date: Fri, 13 Jan 2006 15:14:45 -0500

This is a multi-part message in MIME format.
--------------080708020901080402010106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Brad,


I backd off to 0.4 and it compiles. however, when I run depmod all is OK
then run modprobe snd-bt-sco and I get an error about

snd_bt_sco: disagrees about version of symbol  snd_ctl_add
unknown symbol snd_ctl_add.

There are a number of others also, snd_card_register, etccc....

What is wrong with that? alsa works fine on my machine...

Jerry Geis
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677
(317)663-0808 Fax


Brad Midgley wrote:

>Jerry Geis wrote:
>  
>
>>gcc -version reports 3.4.4
>>
>>I am running a redhat kernel uname -r gives 2.6.9.-22.0.1-EL
>>
>>My machine compiles alsa-drivers just fine. It has all kinds of
>>module_param_array statesments also....
>>Why would this be failing?
>>    
>>
>
>so it uses module_params_array similarly? is index declared in the same way?
>
>this stuff was part of a submission i accepted a few months ago to
>prevent the btsco adapter from making itself the first adapter. you
>could look in cvs for the version before the change.
>
>brad
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

--------------080708020901080402010106
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="+1">Brad,<br>
<br>
<br>
I backd off to 0.4 and it compiles. however, when I run depmod all is OK<br>
then run modprobe snd-bt-sco and I get an error about<br>
<br>
snd_bt_sco: disagrees about version of symbol&nbsp; snd_ctl_add<br>
unknown symbol snd_ctl_add.<br>
<br>
There are a number of others also, snd_card_register, etccc....<br>
<br>
What is wrong with that? alsa works fine on my machine...<br>
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
<blockquote cite="mid43C7D992.7040401@xmission.com" type="cite">
  <pre wrap="">Jerry Geis wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">gcc -version reports 3.4.4

I am running a redhat kernel uname -r gives 2.6.9.-22.0.1-EL

My machine compiles alsa-drivers just fine. It has all kinds of
module_param_array statesments also....
Why would this be failing?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
so it uses module_params_array similarly? is index declared in the same way?

this stuff was part of a submission i accepted a few months ago to
prevent the btsco adapter from making itself the first adapter. you
could look in cvs for the version before the change.

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

--------------080708020901080402010106--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
