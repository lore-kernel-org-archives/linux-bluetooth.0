Return-Path: <Mykel@mWare.ca>
Message-ID: <411DB043.9010001@mWare.ca>
Date: Sat, 14 Aug 2004 02:25:07 -0400
From: Mykel <Mykel@mWare.ca>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple BT Keyboard?
References: <40E241EF.7000607@mWare.ca> <1088586741.22940.17.camel@pegasus>
In-Reply-To: <1088586741.22940.17.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------080200050303050408060506"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080200050303050408060506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

YAHOO!!!! :)

http://ars.userfriendly.org/cartoons/read.cgi?id=20040813&tid=1296099

So... here's what I think I did to make this work (I hope I can do this 
after I reboot :)

-> modprobe hidp
-> hcid
-> hidd --server
-> Press connect on MX900
-> hidd --connect 00:07:61:14:5C:A7
-> Wiggle mouse (I initially got stumped here because I forgot to add 
the following to my xorg.conf:
<stuff>
Section "InputDevice"
    Identifier  "MX900IMPS"
    Driver      "mouse"
    Option "Protocol"    "imps/2"
#    Option "Device"      "/dev/mouse"
     Option "Device" "/dev/input/mice"
#    Option "Resolution"        "256"
     Option "ZAxisMapping" "4 5"
     Option "Buttons" "5"
     Option "Emulate3Buttons" "false"
EndSection
...
    InputDevice 'TouchPad' 'CorePointer'
    InputDevice 'MX900IMPS' 'SendCoreEvents'
    InputDevice 'Keyboard1' 'CoreKeyboard'
</stuff>
I'm actually surprised they keyboard comes up as regular keyboard input 
(caps lock keeps sync too! :)  anyway...
-> sdpd
-> Turn on keyboard
-> hidd --connect 00:0A:95:3A:29:6D
-> hit "0000^M" very quickly
-> magic!

Now - I need some help with the PIN stuff...
I don't understand what is supposed to do what/be what...
Is my keyboard data encrypted or should I not type my passwords on it? 
(I have geek friends... who knows what evil they might enjoy one day :\)

currently, my /usr/bin/bluepin is:
root@immutable:~# cat /usr/bin/bluepin
#!/bin/sh
echo -n "PIN:0000"

aside from changing the number, is there any better I can do?

I tried compiling blue-pin (2.9) but I get this:

root@immutable:/usr/src/bluez29/bluez-pin-0.23# make
cc -O2 -g `pkg-config --cflags gtk+-2.0 libglade-2.0 dbus-glib-1 
gconf-2.0` -DGTK_DISABLE_DEPRECATED -DDBUS_API_SUBJECT_TO_CHANGE -Wall 
-Os -fomit-frame-pointer -DPACKAGE=\"bluez-pin\" -DPREFIX=\"/usr/local\" 
-DPACKAGE_LOCALE_DIR=\"/usr/local/share/locale\"   -c main.c -o main.o
Package dbus-glib-1 was not found in the pkg-config search path.
Perhaps you should add the directory containing `dbus-glib-1.pc'
to the PKG_CONFIG_PATH environment variable
No package 'dbus-glib-1' found
main.c:20:21: gtk/gtk.h: No such file or directory
main.c:22:23: dbus/dbus.h: No such file or directory
main.c:23:28: dbus/dbus-glib.h: No such file or directory
In file included from main.c:25:
... and more errors
(This is on a full install of Slackware 10)

I'm getting the impression that when I try and connect to a device that 
wants a PIN, some GTK window is supposed to prompt me for a PIN? Can 
someone give me some pointers here?

I'm still happy! Should've washed the pool cue chalk off my hands BEFORE 
I started using my white keyboard tho ;\

Myke


Marcel Holtmann wrote:

>Hi Mykel,
>
>  
>
>>I've been flagging the discussions about it in the past few weeks, but 
>>I'm not up with the whole process of what I'm supposed to do, and I 
>>haven't been able to piece it together from what I've seen.
>>
>>I have my MX900 working in 2.4.26 using bthid & hcid.... I don't seem to 
>>have hidd... (I have to press the Connect button and do a bthid -c $ADDR 
>>after leaving the mouse 20min or the first time I use it.)
>>    
>>
>
>the hidd is in bluez-utils-2.7 and needs a 2.6.7-mh1 kernel with
>activated HIDP kernel module.
>
>Pressing the connect button is only needed for the initial connection
>and after that the mouse will reconnect to you. For that you must run
>"hidd --server".
>
>  
>
>>What do I need to get the keyboard working? Is it worthwhile attempting 
>>this with 2.4? Slackware 10 is out and I'm playing with it in 2.6, but I 
>>have many other requirements (I'm an on site network tech, lots of fancy 
>>stuff in my kernel) so I'm not stable in 2.6 yet.
>>    
>>
>
>I propose that you install 2.6.7-mh1 with hidp.ko and use hidd.
>
>Regards
>
>Marcel
>
>  
>

--------------080200050303050408060506
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
YAHOO!!!! :)<br>
<br>
<a class="moz-txt-link-freetext" href="http://ars.userfriendly.org/cartoons/read.cgi?id=20040813&tid=1296099">http://ars.userfriendly.org/cartoons/read.cgi?id=20040813&amp;tid=1296099</a><br>
<br>
So... here's what I think I did to make this work (I hope I can do this
after I reboot :)<br>
<br>
-&gt; modprobe hidp<br>
-&gt; hcid<br>
-&gt; hidd --server<br>
-&gt; Press connect on MX900<br>
-&gt; hidd --connect 00:07:61:14:5C:A7<br>
-&gt; Wiggle mouse (I initially got stumped here because I forgot to
add the following to my xorg.conf:<br>
&lt;stuff&gt;<br>
Section "InputDevice"<br>
&nbsp;&nbsp;&nbsp; Identifier&nbsp; "MX900IMPS"<br>
&nbsp;&nbsp;&nbsp; Driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "mouse"<br>
&nbsp;&nbsp;&nbsp; Option "Protocol"&nbsp;&nbsp;&nbsp; "imps/2"<br>
#&nbsp;&nbsp;&nbsp; Option "Device"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "/dev/mouse"<br>
&nbsp;&nbsp;&nbsp;&nbsp; Option "Device" "/dev/input/mice"<br>
#&nbsp;&nbsp;&nbsp; Option "Resolution"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "256"<br>
&nbsp;&nbsp;&nbsp;&nbsp; Option "ZAxisMapping" "4 5"<br>
&nbsp;&nbsp;&nbsp;&nbsp; Option "Buttons" "5"<br>
&nbsp;&nbsp;&nbsp;&nbsp; Option "Emulate3Buttons" "false" <br>
EndSection<br>
...<br>
&nbsp;&nbsp;&nbsp; InputDevice 'TouchPad' 'CorePointer'<br>
&nbsp;&nbsp;&nbsp; InputDevice 'MX900IMPS' 'SendCoreEvents'<br>
&nbsp;&nbsp;&nbsp; InputDevice 'Keyboard1' 'CoreKeyboard'<br>
&lt;/stuff&gt;<br>
I'm actually surprised they keyboard comes up as regular keyboard input
(caps lock keeps sync too! :)&nbsp; anyway...<br>
-&gt; sdpd<br>
-&gt; Turn on keyboard<br>
-&gt; hidd --connect 00:0A:95:3A:29:6D<br>
-&gt; hit "0000^M" very quickly<br>
-&gt; magic!<br>
<br>
Now - I need some help with the PIN stuff...<br>
I don't understand what is supposed to do what/be what...<br>
Is my keyboard data encrypted or should I not type my passwords on it?
(I have geek friends... who knows what evil they might enjoy one day :\)<br>
<br>
currently, my /usr/bin/bluepin is:<br>
root@immutable:~# cat /usr/bin/bluepin<br>
#!/bin/sh<br>
echo -n "PIN:0000"<br>
<br>
aside from changing the number, is there any better I can do?<br>
<br>
I tried compiling blue-pin (2.9) but I get this:<br>
<br>
<a class="moz-txt-link-abbreviated" href="mailto:root@immutable:/usr/src/bluez29/bluez-pin-0.23#">root@immutable:/usr/src/bluez29/bluez-pin-0.23#</a> make<br>
cc -O2 -g `pkg-config --cflags gtk+-2.0 libglade-2.0 dbus-glib-1
gconf-2.0` -DGTK_DISABLE_DEPRECATED -DDBUS_API_SUBJECT_TO_CHANGE -Wall
-Os -fomit-frame-pointer -DPACKAGE=\"bluez-pin\"
-DPREFIX=\"/usr/local\"
-DPACKAGE_LOCALE_DIR=\"/usr/local/share/locale\"&nbsp;&nbsp; -c main.c -o main.o<br>
Package dbus-glib-1 was not found in the pkg-config search path.<br>
Perhaps you should add the directory containing `dbus-glib-1.pc'<br>
to the PKG_CONFIG_PATH environment variable<br>
No package 'dbus-glib-1' found<br>
main.c:20:21: gtk/gtk.h: No such file or directory<br>
main.c:22:23: dbus/dbus.h: No such file or directory<br>
main.c:23:28: dbus/dbus-glib.h: No such file or directory<br>
In file included from main.c:25:<br>
... and more errors<br>
(This is on a full install of Slackware 10) <br>
<br>
I'm getting the impression that when I try and connect to a device that
wants a PIN, some GTK window is supposed to prompt me for a PIN? Can
someone give me some pointers here?<br>
<br>
I'm still happy! Should've washed the pool cue chalk off my hands
BEFORE I started using my white keyboard tho ;\<br>
<br>
Myke<br>
<br>
<br>
Marcel Holtmann wrote:
<blockquote cite="mid1088586741.22940.17.camel@pegasus" type="cite">
  <pre wrap="">Hi Mykel,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I've been flagging the discussions about it in the past few weeks, but 
I'm not up with the whole process of what I'm supposed to do, and I 
haven't been able to piece it together from what I've seen.

I have my MX900 working in 2.4.26 using bthid &amp; hcid.... I don't seem to 
have hidd... (I have to press the Connect button and do a bthid -c $ADDR 
after leaving the mouse 20min or the first time I use it.)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
the hidd is in bluez-utils-2.7 and needs a 2.6.7-mh1 kernel with
activated HIDP kernel module.

Pressing the connect button is only needed for the initial connection
and after that the mouse will reconnect to you. For that you must run
"hidd --server".

  </pre>
  <blockquote type="cite">
    <pre wrap="">What do I need to get the keyboard working? Is it worthwhile attempting 
this with 2.4? Slackware 10 is out and I'm playing with it in 2.6, but I 
have many other requirements (I'm an on site network tech, lots of fancy 
stuff in my kernel) so I'm not stable in 2.6 yet.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I propose that you install 2.6.7-mh1 with hidp.ko and use hidd.

Regards

Marcel

  </pre>
</blockquote>
</body>
</html>

--------------080200050303050408060506--
