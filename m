Return-Path: <fabchevalier@free.fr>
Message-ID: <45643B58.7070305@free.fr>
Date: Wed, 22 Nov 2006 12:58:16 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Continued : SCO flow control patch design questions
References: <45635EE4.2090208@silicom.fr>	 <1164179670.23477.31.camel@localhost>  <45640CC5.6050907@silicom.fr>	 <1164185074.23477.34.camel@localhost>  <45641282.60509@silicom.fr> <1164186631.23477.39.camel@localhost>
In-Reply-To: <1164186631.23477.39.camel@localhost>
Content-Type: multipart/alternative;
 boundary="------------090208000702050004050303"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090208000702050004050303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


All & Marcel,

I'm moving a discution with Marcel on the list, as others might which to 
jump in the discutions.
> Hi Fabien,
>
>   
>>> No. I only need to understand some of your decisions why you did
>>> something in this particular way.
>>>  
>>>   
>>>       
>> Ok, i'm gonna try to come up with something. 
>> If you have some particular questions that you would like to be
>> answered,
>> please send them to me, this will avoid me to play the
>> 'guess-what-he-wants-me-to-explain'
>> game :-)
>>     
>
> the important one is about the callback to signal when a packet actually
> has been send. This is too ugly for me. I would prefer if we don't need
> this at all. If we need it, we have to do it a little bit different and
> much more cleaner.
>
> The other questions is for what we actually use the hrtimer and some
> things about the buffer settings on the socket.
>
> Regards
Ok, now i see what you mean, so here are a few answers:

Point 1 : Why rely on hrtimers ?
As discussed previously on the list, there is no transport agnostic way 
to throttle ourselves to send data at the right rate.
SCO flow control support at HCI level is optionnal, thus we cannot rely 
on it.
Relying on isochronous USB transfer is not good as well, as it poses 
some architectural issues underlined by Marcel's previous e-mails. 
Moreover i suspect this to rely on USB host controller clock, which is 
unrelated to the bluetooth chip clock, and thus will  suffer the same 
clock offset drawback that a timer based approach.
So at some point we have to throttle ourselves, and timers can be used 
for that.

Point 2 : What about buffer settings ?
Audio API expects the application to specify a 'buffer size' and 'period 
size'.
Period size is the size of data that sound card hardware processes at a 
time.
Buffer size is a multiple of the period size, and is shared by both ALSA 
and the hardware
to move data from one to another.
One important thing to understand is that the biggest the buffer, the 
longer the added latency added.
That's why xmms's playing buffer default to 500 ms, while Ekiga's one is 
as small as two period sizes.
As it's up to the application to choose its buffer size, there is a need 
for SCO sockets to expose and API
to change the size of the buffer. There already exist such an API, which 
is SO_SNDBUF and SO_RCVBUF
setsockopt options, however the measurment does include the size of 
in-kernel data structures, which means the application has no way to 
tell the exact size of the buffer without knowing how big are the kernel 
data structures.
For ALSA this is not acceptable.
So i introduces SCO_TXBUFS and SCO_RXBUFS socket options to be able to 
specify a number of sco packets.
There is a nice tutorial on this subject by ALSA project that can be 
found on:
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html

Point 3 : Why is there a callback ?
Yes i agree this is not the cleanest design ever.
This design fullfills two constraints posed by Marcel:
 * keep the packet list in the core, and stream it from there.
 * open the door to a user level implementation that would not rely on 
sockets

The callbask just says : ok one packet is sent, there is room on my 
internal queue, send me one more!
I have an idea on how to do it without introducing a callback, however 
this would make it rely on sockets flow control, and thus would break 
second item.
Streaming packets from the socket queue directly would make the thing 
really easy to implement, but would break both items :-(. If you 
remember, this was the spirit of my first patch ;-)
Marcel : Your opinion is welcomed on this point. If you say bye bye to 
second item, i can come up with a solution without callbacks.

Marcel & All,

Your comments are of course welcome :-)
Yet another thing : if we could agree on a design before i start coding 
again, that would really be great ;-)

Cheers,

Fabien

--------------090208000702050004050303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
All &amp; Marcel,<br>
<br>
I'm moving a discution with Marcel on the list, as others might which
to jump in the discutions.<br>
<blockquote cite="mid1164186631.23477.39.camel@localhost" type="cite">
  <pre wrap="">Hi Fabien,

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">No. I only need to understand some of your decisions why you did
something in this particular way.
 
  
      </pre>
    </blockquote>
    <pre wrap="">Ok, i'm gonna try to come up with something. 
If you have some particular questions that you would like to be
answered,
please send them to me, this will avoid me to play the
'guess-what-he-wants-me-to-explain'
game :-)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
the important one is about the callback to signal when a packet actually
has been send. This is too ugly for me. I would prefer if we don't need
this at all. If we need it, we have to do it a little bit different and
much more cleaner.

The other questions is for what we actually use the hrtimer and some
things about the buffer settings on the socket.

Regards</pre>
</blockquote>
Ok, now i see what you mean, so here are a few answers:<br>
<br>
Point 1 : Why rely on hrtimers ?<br>
As discussed previously on the list, there is no transport agnostic way
to throttle ourselves to send data at the right rate.<br>
SCO flow control support at HCI level is optionnal, thus we cannot rely
on it.<br>
Relying on isochronous USB transfer is not good as well, as it poses
some architectural issues underlined by Marcel's previous e-mails.
Moreover i suspect this to rely on USB host controller clock, which is
unrelated to the bluetooth chip clock, and thus will&nbsp; suffer the same
clock offset drawback that a timer based approach.<br>
So at some point we have to throttle ourselves, and timers can be used
for that. <br>
<br>
Point 2 : What about buffer settings ?<br>
Audio API expects the application to specify a 'buffer size' and
'period size'.<br>
Period size is the size of data that sound card hardware processes at a
time.<br>
Buffer size is a multiple of the period size, and is shared by both
ALSA and the hardware<br>
to move data from one to another.<br>
One important thing to understand is that the biggest the buffer, the
longer the added latency added.<br>
That's why xmms's playing buffer default to 500 ms, while Ekiga's one
is as small as two period sizes.<br>
As it's up to the application to choose its buffer size, there is a
need for SCO sockets to expose and API<br>
to change the size of the buffer. There already exist such an API,
which is SO_SNDBUF and SO_RCVBUF<br>
setsockopt options, however the measurment does include the size of
in-kernel data structures, which means the application has no way to
tell the exact size of the buffer without knowing how big are the
kernel data structures.<br>
For ALSA this is not acceptable.<br>
So i introduces SCO_TXBUFS and SCO_RXBUFS socket options to be able to
specify a number of sco packets.<br>
There is a nice tutorial on this subject by ALSA project that can be
found on:<br>
<a class="moz-txt-link-freetext" href="http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html">http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html</a><br>
<br>
Point 3 : Why is there a callback ?<br>
Yes i agree this is not the cleanest design ever. <br>
This design fullfills two constraints posed by Marcel:<br>
&nbsp;* keep the packet list in the core, and stream it from there.<br>
&nbsp;* open the door to a user level implementation that would not rely on
sockets<br>
<br>
The callbask just says : ok one packet is sent, there is room on my
internal queue, send me one more!<br>
I have an idea on how to do it without introducing a callback, however
this would make it rely on sockets flow control, and thus would break
second item.<br>
Streaming packets from the socket queue directly would make the thing
really easy to implement, but would break both items :-(. If you
remember, this was the spirit of my first patch ;-)<br>
Marcel : Your opinion is welcomed on this point. If you say bye bye to
second item, i can come up with a solution without callbacks.<br>
<br>
Marcel &amp; All,<br>
<br>
Your comments are of course welcome :-)<br>
Yet another thing : if we could agree on a design before i start coding
again, that would really be great ;-)<br>
<br>
Cheers,<br>
<br>
Fabien<br>
</body>
</html>

--------------090208000702050004050303--
