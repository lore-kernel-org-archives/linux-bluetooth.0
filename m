Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464DCCC4.90300@nnytech.net>
Date: Fri, 18 May 2007 11:56:52 -0400
From: John Feig <feig@nnytech.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200705170207.52710.bluez-devel@huitl.de>	
	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>	
	<200705171521.38889.bluez-devel@huitl.de>	
	<464C7616.9070900@nnytech.net>
	<d89ddf300705180613u5c24ed8brab0acf3f7ee65280@mail.gmail.com>
In-Reply-To: <d89ddf300705180613u5c24ed8brab0acf3f7ee65280@mail.gmail.com>
Subject: Re: [Bluez-devel] Frequent headset disconnects
Reply-To: feig@nnytech.net,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1621289797=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1621289797==
Content-Type: multipart/alternative;
	boundary="------------010409040107040309060808"

This is a multi-part message in MIME format.
--------------010409040107040309060808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brad Midgley wrote:
> *John
>
> *
>
>
>     I've been using the a2dpd app for a couple of weeks now, and
>     really like
>     it. I have a few issues though, with the main one being that after a
>     couple of minutes of playback, my headphones (HT820) turn off
>
>
> it looks like alsa_transfer_raw returns -1 once and then a2dpd closes 
> the connection. Maybe we should be checking for an error state that 
> indicates we can retry or maybe we should retry a few times regardless.
>
> it could be the set turns off because of the way we terminate the 
> connection. This is mostly Frederic's playground but I remember 
> locking up headsets with a2play by accidentally sending data on the 
> stream fd after we had signaled a stream close on the control fd.
>
> brad
Brad, thank you for the reply. To try to understand this, you're saying 
that when I get:

a2dp_transfer_raw: Wrote -1 not 603 bytes (sbc.len=118)
transfer_outgoing_packets: Error in transfer (transfer=-1)

The issue could be that the headset is expecting a value of a certain 
length, and since the value -1 is not that length, the headset doens't 
like that, and shuts down? If this is the case, where should I look to 
change that value, and what should it be changed to? I wouldn't mind 
sending some dummy data and have it drop out for a second once in a 
while, as long as I don't have to keep restarting the thing. At least it 
would be a temporary fix.

I found the IF block in a2dpd_output_a2dp.c:

if (a2dp->sk > 0) {
    // Pause?
    // The value 0 have finally been tested ;)
    // However, we may safely simulate a failed write
    if (!a2dp->pause_writing) {
        // Send our data
            if ((written = write(a2dp->sk, a2dp->buf, a2dp->len)) != 
a2dp->len) {
                // Error while sending data
                    DBG("Wrote %d not %d bytes (sbc.len=%d)", written, 
a2dp->len, a2dp->sbc.len);
                        // Return the error
                        result = written;
            }
...

That seems to be the only place that contains that string, that I could 
find. I can't find out where the function "write" is defined either.

I'll keep looking, and if you guys can give me some suggestions of 
things to try and what I should be looking at, I will and let you all 
know how it goes.

Thanks again,
John

--------------010409040107040309060808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Brad Midgley wrote:
<blockquote
 cite="mid:d89ddf300705180613u5c24ed8brab0acf3f7ee65280@mail.gmail.com"
 type="cite">
  <div><span class="gmail_quote"><b class="gmail_sendername">John<br>
  <br>
  </b></span>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
I've been using the a2dpd app for a couple of weeks now, and really
like
    <br>
it. I have a few issues though, with the main one being that after a<br>
couple of minutes of playback, my headphones (HT820) turn off<br>
  </blockquote>
  </div>
  <br>
it looks like alsa_transfer_raw returns -1 once and then a2dpd closes
the connection. Maybe we should be checking for an error state that
indicates we can retry or maybe we should retry a few times regardless.
  <br>
  <br>
it could be the set turns off because of the way we terminate the
connection. This is mostly Frederic's playground but I remember locking
up headsets with a2play by accidentally sending data on the stream fd
after we had signaled a stream close on the control fd.
  <br>
  <br>
brad<br>
</blockquote>
Brad, thank you for the reply. To try to understand this, you're saying
that when I get:<br>
<pre wrap="">a2dp_transfer_raw: Wrote -1 not 603 bytes (sbc.len=118)
transfer_outgoing_packets: Error in transfer (transfer=-1)
</pre>
The issue could be that the headset is expecting a value of a certain
length, and since the value -1 is not that length, the headset doens't
like that, and shuts down? If this is the case, where should I look to
change that value, and what should it be changed to? I wouldn't mind
sending some dummy data and have it drop out for a second once in a
while, as long as I don't have to keep restarting the thing. At least
it would be a temporary fix.<br>
<br>
I found the IF block in a2dpd_output_a2dp.c:<br>
<br>
if (a2dp-&gt;sk &gt; 0) {<br>
&nbsp;&nbsp;&nbsp; // Pause?<br>
&nbsp;&nbsp;&nbsp; // The value 0 have finally been tested ;)<br>
&nbsp;&nbsp;&nbsp; // However, we may safely simulate a failed write<br>
&nbsp;&nbsp;&nbsp; if (!a2dp-&gt;pause_writing) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // Send our data<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if ((written = write(a2dp-&gt;sk, a2dp-&gt;buf,
a2dp-&gt;len)) != a2dp-&gt;len) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // Error while sending data<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DBG("Wrote %d not %d bytes (sbc.len=%d)", written,
a2dp-&gt;len, a2dp-&gt;sbc.len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // Return the error<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result = written;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
...<br>
<br>
That seems to be the only place that contains that string, that I could
find. I can't find out where the function "write" is defined either. <br>
<br>
I'll keep looking, and if you guys can give me some suggestions of
things to try and what I should be looking at, I will and let you all
know how it goes.<br>
<br>
Thanks again,<br>
John<br>
</body>
</html>

--------------010409040107040309060808--


--===============1621289797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1621289797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1621289797==--
