Return-Path: <matrix230@yahoo.com>
Message-ID: <20040812092026.8225.qmail@web51805.mail.yahoo.com>
Date: Thu, 12 Aug 2004 02:20:25 -0700 (PDT)
From: 0|20c|=|ima|2U <matrix230@yahoo.com>
Subject: RE: [Bluez-users] it is possible to change the N inquiry <256
To: bluez-users@lists.sourceforge.net
Cc: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1091802237.20839.116.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-501576524-1092302425=:7786"
List-ID: <bluez-users.lists.sourceforge.net>

--0-501576524-1092302425=:7786
Content-Type: text/plain; charset=us-ascii

Hi there,
 
what I'm trying to do is that I want to speed up the discovery process.  As stated by Somil before, the device inquires 256 times or for 2.56 s using one Train and then switches to a different Train. There are two Inquiry Train (called as Train A or Train B).
 
What I'm trying to do is, i want to reduce the no. of times that the train must be repeated before switches to another train. For e.g. :
 
AAAAAAAAAAA.....[256x]..BBBBB...[256x]... (train A repeat 256 times then see train B)
ABABABABAB........... (this is what happen when we change Ninquiry=1)
 
this can speed up the discovery process. are there any command or some modification in the source code that we can alter to reduce the no. of Ninquiry of train A & B? ~:)
 
I've done the simulation under network simulator by changing value of Ninquiry=1, and i found that the discovery process can be speed up.
 
Regards,
 
Shukri



		
---------------------------------
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
--0-501576524-1092302425=:7786
Content-Type: text/html; charset=us-ascii

<DIV>Hi there,</DIV>
<DIV>&nbsp;</DIV>
<DIV>what I'm trying to do is that I want to speed up the discovery process.&nbsp; As stated by Somil before, the device inquires 256 times or for 2.56 s using one Train and then switches to a different Train. There are two Inquiry Train (called as Train A or Train B).</DIV>
<DIV>&nbsp;</DIV>
<DIV>What I'm trying to do is, i want to reduce the no. of times that the train must be repeated before switches to another train. For e.g. :</DIV>
<DIV>&nbsp;</DIV>
<DIV>AAAAAAAAAAA.....[256x]..BBBBB...[256x]... (train A repeat 256 times then see train B)</DIV>
<DIV>ABABABABAB........... (this is what happen when we change Ninquiry=1)</DIV>
<DIV>&nbsp;</DIV>
<DIV>this can speed up the discovery process. are there any command or some modification in the source code that we can alter to reduce the no. of Ninquiry of train A &amp; B? ~:)</DIV>
<DIV>&nbsp;</DIV>
<DIV>I've done the simulation under network simulator by changing value of Ninquiry=1, and i found that the discovery process can be speed up.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Regards,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Shukri<BR><BR></DIV><p>
		<hr size=1>Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/mail_us/taglines/100/*http://promotions.yahoo.com/new_mail/static/efficiency.html">New and Improved Yahoo! Mail</a> - 100MB free storage!
--0-501576524-1092302425=:7786--
