Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
In-Reply-To: <2D887441-23BB-4560-AEA4-BF0C9EC23B8C@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <OF788B477D.1FF38FBA-ON4825737D.0028CF7D-8825737D.007D2034@mxic.com.cn>
From: KyoYin@mxic.com.cn
Date: Tue, 23 Oct 2007 00:53:55 -0700
Subject: Re: [Bluez-devel] bluetooth headset not working
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0638519725=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multipart message in MIME format.
--===============0638519725==
Content-Type: multipart/alternative;
	boundary="=_alternative 007D202E8825737D_="

This is a multipart message in MIME format.
--=_alternative 007D202E8825737D_=
Content-Type: text/plain; charset="US-ASCII"

hi Johan
    the crash of bluetoothd-service-audio has been resolved now.i think it 
is a bug.in avdtp_stream_get_transport(),the mtu pointer will be 
unaccessible.
In a2dp_setup_complete(),avdtp_stream_get_transport() wants to pass the 
address of cfg->pkt_len.but the cfg is a packed struct.so the normal 
pointer of uint16(pointer mtu in avdtp_stream_get_transport is this type) 
should not be used here.of cause my cpu is arm.

 
thanks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Kyo Yin(Jian)
MXIC Technology Co.,Ltd.
NO.5, Xinhai street, Suzhou Industrial Park 
Tel: 86-512-87650888-3463
E-Mail: kyoyin@mxic.com.cn
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Johan Hedberg <johan.hedberg@nokia.com> 
Sent by: bluez-devel-bounces@lists.sourceforge.net
2007-10-23 00:22
Please respond to
BlueZ development <bluez-devel@lists.sourceforge.net>


To
BlueZ development <bluez-devel@lists.sourceforge.net>
cc

Subject
Re: [Bluez-devel] bluetooth headset not working






(resending since the first try seems to have gotten stuck somewhere 
between gmail and sourceforge)

On Oct 20, 2007, at 5:10, KyoYin@mxic.com.cn wrote:
>       Do u mean the bluetoothd-service-audio will read .asoundrc?

No. The values in .asoundrc are given to the bluetooth alsa plugin 
which then passes them over to the audio service using a unix socket.

>       could you tell me how to write .asoundrc if i want to use 
> a2dp and
> hsp.now my .asoundrc is:
>
>       pcm.headset {
>       type bluetooth
>       }
>
>       ctl.headset {
>       type bluetooth
>       }
>
>       pcm.bluetooth {
>       type bluetooth
>       device 00:0D:3C:EB:53:F0
>       }

If you want to have one alsa device for A2DP and another for HSP it 
might be a good idea to explicitly state the profile you want to use 
for each device. You do this by providing a line such as "profile 
a2dp" in addition to the device and type lines. I just checked the 
code and the plugin will map "hifi" and "a2dp" to A2DP and "voice" 
and "hfp" to HSP (it's actually a bug that it doesn't recognize "hsp").

> when i use  "aplay -D bluetooth -f S16_LE /1.wav ",i will get the 
> following
> error.
<snip>
> audio[837]: START request succAlignment trap: bluetoothd-serv (837)
> PC=0x0001ce50 Instr=0xe1c320b0 Address=0xbe871a89 FSR 0x813
> eeded
> audio[837]: SBC Source: Start_Cfm
> audio[837]: SBC Source SEP 0x376b8 locked
> hcid[825]: Service owner exited: :1.1

Looks like the audio service crashed. What architecture are you 
running this on and what compiler did you use? It would be good if 
you could try to reproduce this by running bluetoothd-audio-service 
through valgrind or gdb and get a proper backtrace of the crash. To 
do this remove the /etc/bluetooth/audio.service file (hcid should 
detect this and unregister the service but if it doesn't you need to 
restart hcid), and run "/usr/lib/bluetooth/bluetoothd-service-audio - 
s" either through gdb or valgrind.

Johan


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


--=_alternative 007D202E8825737D_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">hi </font><tt><font size=2>Johan</font></tt>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; the crash of bluetoothd-service-audio
has been resolved now.i think it is a bug.in avdtp_stream_get_transport(),the
mtu pointer will be unaccessible.</font>
<br><font size=2 face="sans-serif">In a2dp_setup_complete(),avdtp_stream_get_transport()
wants to pass the address of cfg-&gt;pkt_len.but the cfg is a packed struct.so
the normal pointer of uint16(pointer mtu in avdtp_stream_get_transport
is this type) should not be used here.of cause my cpu is arm.</font>
<br>
<br><font size=2 face="sans-serif">&nbsp;<br>
thanks<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
Kyo Yin(Jian)<br>
MXIC Technology Co.,Ltd.<br>
NO.5, Xinhai street, Suzhou Industrial Park <br>
Tel: 86-512-87650888-3463<br>
E-Mail: kyoyin@mxic.com.cn<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Johan Hedberg &lt;johan.hedberg@nokia.com&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: bluez-devel-bounces@lists.sourceforge.net</font>
<p><font size=1 face="sans-serif">2007-10-23 00:22</font>
<table border>
<tr valign=top>
<td bgcolor=white>
<div align=center><font size=1 face="sans-serif">Please respond to<br>
BlueZ development &lt;bluez-devel@lists.sourceforge.net&gt;</font></div></table>
<br>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">BlueZ development &lt;bluez-devel@lists.sourceforge.net&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: [Bluez-devel] bluetooth headset
not working</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>(resending since the first try seems to have gotten
stuck somewhere &nbsp;<br>
between gmail and sourceforge)<br>
<br>
On Oct 20, 2007, at 5:10, KyoYin@mxic.com.cn wrote:<br>
&gt; &nbsp; &nbsp; &nbsp; Do u mean the bluetoothd-service-audio will read
.asoundrc?<br>
<br>
No. The values in .asoundrc are given to the bluetooth alsa plugin &nbsp;<br>
which then passes them over to the audio service using a unix socket.<br>
<br>
&gt; &nbsp; &nbsp; &nbsp; could you tell me how to write .asoundrc if i
want to use &nbsp;<br>
&gt; a2dp and<br>
&gt; hsp.now my .asoundrc is:<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; pcm.headset {<br>
&gt; &nbsp; &nbsp; &nbsp; type bluetooth<br>
&gt; &nbsp; &nbsp; &nbsp; }<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; ctl.headset {<br>
&gt; &nbsp; &nbsp; &nbsp; type bluetooth<br>
&gt; &nbsp; &nbsp; &nbsp; }<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; pcm.bluetooth {<br>
&gt; &nbsp; &nbsp; &nbsp; type bluetooth<br>
&gt; &nbsp; &nbsp; &nbsp; device 00:0D:3C:EB:53:F0<br>
&gt; &nbsp; &nbsp; &nbsp; }<br>
<br>
If you want to have one alsa device for A2DP and another for HSP it &nbsp;<br>
might be a good idea to explicitly state the profile you want to use &nbsp;<br>
for each device. You do this by providing a line such as &quot;profile
&nbsp;<br>
a2dp&quot; in addition to the device and type lines. I just checked the
&nbsp;<br>
code and the plugin will map &quot;hifi&quot; and &quot;a2dp&quot; to A2DP
and &quot;voice&quot; &nbsp;<br>
and &quot;hfp&quot; to HSP (it's actually a bug that it doesn't recognize
&quot;hsp&quot;).<br>
<br>
&gt; when i use &nbsp;&quot;aplay -D bluetooth -f S16_LE /1.wav &quot;,i
will get the &nbsp;<br>
&gt; following<br>
&gt; error.<br>
&lt;snip&gt;<br>
&gt; audio[837]: START request succAlignment trap: bluetoothd-serv (837)<br>
&gt; PC=0x0001ce50 Instr=0xe1c320b0 Address=0xbe871a89 FSR 0x813<br>
&gt; eeded<br>
&gt; audio[837]: SBC Source: Start_Cfm<br>
&gt; audio[837]: SBC Source SEP 0x376b8 locked<br>
&gt; hcid[825]: Service owner exited: :1.1<br>
<br>
Looks like the audio service crashed. What architecture are you &nbsp;<br>
running this on and what compiler did you use? It would be good if &nbsp;<br>
you could try to reproduce this by running bluetoothd-audio-service &nbsp;<br>
through valgrind or gdb and get a proper backtrace of the crash. To &nbsp;<br>
do this remove the /etc/bluetooth/audio.service file (hcid should &nbsp;<br>
detect this and unregister the service but if it doesn't you need to &nbsp;<br>
restart hcid), and run &quot;/usr/lib/bluetooth/bluetoothd-service-audio
- <br>
s&quot; either through gdb or valgrind.<br>
<br>
Johan<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Splunk Inc.<br>
Still grepping through log files to find problems? &nbsp;Stop.<br>
Now Search log events and configuration files using AJAX and a browser.<br>
Download your FREE copy of Splunk now &gt;&gt; http://get.splunk.com/<br>
_______________________________________________<br>
Bluez-devel mailing list<br>
Bluez-devel@lists.sourceforge.net<br>
https://lists.sourceforge.net/lists/listinfo/bluez-devel<br>
</font></tt>
<br>
--=_alternative 007D202E8825737D_=--


--===============0638519725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0638519725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0638519725==--
