Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <79be12f70708200824o14105689v2fd7097963d3bacd@mail.gmail.com>
Date: Mon, 20 Aug 2007 09:24:03 -0600
From: "John Sample" <john.m.sample@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] Fwd: hcitool scan problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0847722648=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0847722648==
Content-Type: multipart/alternative;
	boundary="----=_Part_74841_27367594.1187623443046"

------=_Part_74841_27367594.1187623443046
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Thanks for the reply.  I ran the hcidump with hcitool scan and it appears
that the inquiry retrieves all of the correct addresses, but when it does a
remote name request the addresses are all scrambled.  There is also an
occassional "Error: Invalid HCI Command Parameters" following the name
request.  Any idea what is causing this to happen?

Thanks.

Hi John,

> I am having a problem with the hcitool scan command (v3.13) using the
> 2.6.21 kernel, as well as 2.6.23.  Here is my output:
>
> Scanning ...
>         3A:5E:11:6B:00:00       n/a
>         38:C1:5E:35:3F:D9       n/a
>         C5:2B:F4:F7:3C:6A       n/a
>         3A:75:F9:65:1A:02       n/a.
>         38:C1:60:35:1A:F6       n/a
>
> All of the addresses are partially junk for some reason - for example
> 38:C1:60:35:1A:F6 should be 00:16:38:C1:60:35, and no name are
> returned.  This seems to effect other tools as well, for example if I
> do try to do a hidd search I can't detect anything even if there are
> discoverable hid devices around - I'm guessing because it doesn't have
> valid addresses.  Previously I had been using the 2.6.10 kernel and
> everything worked fine.

run "hcidump -X -V" and compare the output.

Regards

Marcel

-- 
John Sample

------=_Part_74841_27367594.1187623443046
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Marcel,</div>
<div>&nbsp;</div>
<div>Thanks for the reply.&nbsp; I ran the hcidump with hcitool scan and it appears that the inquiry retrieves all of the correct addresses, but when it does a remote name request the addresses are all scrambled.&nbsp; There is also an occassional &quot;Error: Invalid HCI Command Parameters&quot; following the name request.&nbsp; Any idea what is causing this to happen?
</div>
<div>&nbsp;</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>Hi John,<br><br>&gt; I am having a problem with the hcitool scan command (v3.13) using the<br>&gt; 2.6.21 kernel, as well as 2.6.23. &nbsp;Here is my output:<br>&gt;<br>&gt; Scanning ...<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; 3A:5E:11:6B:00:00 &nbsp; &nbsp; &nbsp; n/a
<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; 38:C1:5E:35:3F:D9 &nbsp; &nbsp; &nbsp; n/a<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; C5:2B:F4:F7:3C:6A &nbsp; &nbsp; &nbsp; n/a<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; 3A:75:F9:65:1A:02 &nbsp; &nbsp; &nbsp; n/a.<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; 38:C1:60:35:1A:F6 &nbsp; &nbsp; &nbsp; n/a<br>&gt;<br>&gt; All of the addresses are partially junk for some reason - for example
<br>&gt; 38:C1:60:35:1A:F6 should be 00:16:38:C1:60:35, and no name are<br>&gt; returned. &nbsp;This seems to effect other tools as well, for example if I<br>&gt; do try to do a hidd search I can&#39;t detect anything even if there are
<br>&gt; discoverable hid devices around - I&#39;m guessing because it doesn&#39;t have<br>&gt; valid addresses. &nbsp;Previously I had been using the 2.6.10 kernel and<br>&gt; everything worked fine.<br><br>run &quot;hcidump -X -V&quot; and compare the output.
<br><br>Regards<br><br>Marcel<br clear="all"><br>-- <br>John Sample </div>

------=_Part_74841_27367594.1187623443046--


--===============0847722648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0847722648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0847722648==--
