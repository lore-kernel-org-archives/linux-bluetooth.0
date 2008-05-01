Return-Path: <cyrus@holtmann.org>
Message-ID: <46f855150805010936i3f339a37s2da7c144bc5e4faa@mail.gmail.com>
Date: Thu, 1 May 2008 12:36:16 -0400
From: "Chris Carlin" <volkris@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300805010703x5ec18761xd2f80bf2b31fab1f@mail.gmail.com>
MIME-Version: 1.0
References: <48171A58.8060200@powercraft.nl> <4817DAE3.6050406@gmail.com>
	<d89ddf300804291959m6589b95fse31e8227c37c8f1f@mail.gmail.com>
	<4818E1B3.6000900@powercraft.nl>
	<46f855150805010641q1e164d86h46d2bc8352d6ed37@mail.gmail.com>
	<d89ddf300805010703x5ec18761xd2f80bf2b31fab1f@mail.gmail.com>
Subject: Re: [Bluez-users] step by step - how to get your bluetooth stereo
	headset fully working with the bluez software stack under linux
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0341548193=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0341548193==
Content-Type: multipart/alternative;
	boundary="----=_Part_7065_17524716.1209659776080"

------=_Part_7065_17524716.1209659776080
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> does "sudo hcitool con" also show your adapter as master on all the
> connections? It's often been a scatternet (the computer's bt adapter
> switching from one piconet to another) that causes the problem.
>

Yes. Always.


> I would think so. A smaller bandwidth stream has less demand for
> continuous data flow.
>

Well the old a2dpd had a note in the configuration file saying the
following. Is there a way to adjust it in the current a2dp implementation?

# Allows to specify the sbc bitpool, this can help reducing bandwith
# 8 Allows to run on a 115200 bauds with corresponding quality ;)
# 64 needs USB or 921600 bauds
# Recommended value from Bluetooth spec. is 53
sbcbitpool=53


~Chris

------=_Part_7065_17524716.1209659776080
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">does &quot;sudo hcitool con&quot; also show your adapter as master on all the<br>

connections? It&#39;s often been a scatternet (the computer&#39;s bt adapter<br>
switching from one piconet to another) that causes the problem.<br>
<div class="Ih2E3d"></div></blockquote><div><br>Yes. Always.<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I would think so. A smaller bandwidth stream has less demand for<br>

continuous data flow.<br>
</blockquote><div><br>Well the old a2dpd had a note in the configuration file saying the following. Is there a way to adjust it in the current a2dp implementation?<br><br># Allows to specify the sbc bitpool, this can help reducing bandwith<br>
# 8 Allows to run on a 115200 bauds with corresponding quality ;)<br># 64 needs USB or 921600 bauds<br># Recommended value from Bluetooth spec. is 53<br>sbcbitpool=53<br><br><br>~Chris</div></div>

------=_Part_7065_17524716.1209659776080--


--===============0341548193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0341548193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0341548193==--
