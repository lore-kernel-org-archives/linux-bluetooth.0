Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060913154606.33909.qmail@web51406.mail.yahoo.com>
Date: Wed, 13 Sep 2006 08:46:06 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <45072378.6010609@xmission.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Poor audio quality with DBT120 and HS850
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0407069972=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0407069972==
Content-Type: multipart/alternative; boundary="0-1630618320-1158162366=:32608"
Content-Transfer-Encoding: 8bit

--0-1630618320-1158162366=:32608
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks for pointing to SCO flow thread. The patch seems to be available for 2.6.16-mh1. I have following questions regarding this.
   
  1) Does latest stable kernel 2.6.17... includes this patch already? Or do i need to install  2.6.16-mh1 and then apply this patch?
   
  2) I read that bluetooth version 1.2/ 2.0 support extended SCO (eSCO) that improves audio quality. Is this patch needed with bluetooth ver 1.2/ 2.0 dongle/headset also? Are there any known bluetooth ver 1.2. dongle/headset known to work well with bluez?
   
  Pls let me know
   
  thanks,
  Manoj

Brad Midgley <bmidgley@xmission.com> wrote:
  manojt

> I am trying to capture audio speech through throgh Motorola HS850
> headset and DLink DBT120 dongle using Bluez 3.1 stack. I am able to
> capture audio through SCO channel using program similar to scotest. I am
> using . But the audio quality is not very good and voice is choppy. I
> am running sco audio capture program with high priority.
> Has anyone experienced this before?
> Pls let me know if there is any way to improve audio quality. Is there
> any other Dongle or headset that would work better.

there were some sco flow control patches to the kernel floating around
the list about a month ago. I'm not sure if they got incorporated. they
could help with quality problems resulting from incorrect pacing.

if you have the patch you'll have to do an ioctl to turn on flow control
in your app iirc.

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 			
---------------------------------
Get your own web address for just $1.99/1st yr. We'll help. Yahoo! Small Business.
--0-1630618320-1158162366=:32608
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Thanks for pointing to SCO flow thread. The patch seems to be available for 2.6.16-mh1. I have following questions regarding this.</div>  <div>&nbsp;</div>  <div>1)&nbsp;Does latest stable kernel 2.6.17... includes this patch already?&nbsp;Or do i need to&nbsp;install &nbsp;2.6.16-mh1 and then apply this patch?</div>  <div>&nbsp;</div>  <div>2) I read that bluetooth version 1.2/ 2.0 support extended SCO (eSCO) that improves audio quality. Is this patch needed with bluetooth ver 1.2/ 2.0 dongle/headset also? Are there any known bluetooth ver 1.2. dongle/headset known to work well with bluez?</div>  <div>&nbsp;</div>  <div>Pls let me know</div>  <div>&nbsp;</div>  <div>thanks,</div>  <div>Manoj<BR><BR><B><I>Brad Midgley &lt;bmidgley@xmission.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">manojt<BR><BR>&gt; I am trying to capture audio speech through throgh Motorola HS850<BR>&gt; headset
 and DLink DBT120 dongle using Bluez 3.1 stack. I am able to<BR>&gt; capture audio through SCO channel using program similar to scotest. I am<BR>&gt; using . But the audio quality is not very good and voice is choppy. I<BR>&gt; am running sco audio capture program with high priority.<BR>&gt; Has anyone experienced this before?<BR>&gt; Pls let me know if there is any way to improve audio quality. Is there<BR>&gt; any other Dongle or headset that would work better.<BR><BR>there were some sco flow control patches to the kernel floating around<BR>the list about a month ago. I'm not sure if they got incorporated. they<BR>could help with quality problems resulting from incorrect pacing.<BR><BR>if you have the patch you'll have to do an ioctl to turn on flow control<BR>in your app iirc.<BR><BR>Brad<BR><BR>-------------------------------------------------------------------------<BR>Using Tomcat but need to do more? Need to support web services, security?<BR>Get stuff done quickly
 with pre-integrated technology to make your job easier<BR>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><BR><p>&#32;
	
		<hr size=1>Get your own <a href=" http://us.rd.yahoo.com/evt=43290/*http://smallbusiness.yahoo.com/domains"
>web address for just $1.99/1st yr</a>. We'll help. <a href="http://us.rd.yahoo.com/evt=41244/*http://smallbusiness.yahoo.com/"
>Yahoo! Small Business</a>.

--0-1630618320-1158162366=:32608--


--===============0407069972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0407069972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0407069972==--
