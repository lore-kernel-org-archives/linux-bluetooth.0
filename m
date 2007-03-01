Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0702282140j2561f505uc79584eecb7c60dd@mail.gmail.com>
Date: Thu, 1 Mar 2007 11:10:24 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1ab01fb50702282041o36bdbf55mfa073858cc9e5c77@mail.gmail.com>
MIME-Version: 1.0
References: <57c68ddc0702280731j1470f59bj2f4cba52ecd6229f@mail.gmail.com>
	<1ab01fb50702282041o36bdbf55mfa073858cc9e5c77@mail.gmail.com>
Subject: Re: [Bluez-devel] how to create rfcomm channel
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0258956497=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0258956497==
Content-Type: multipart/alternative;
	boundary="----=_Part_54143_24390352.1172727624460"

------=_Part_54143_24390352.1172727624460
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi vikas ,
            Really great to get i reply from you. I was trying to write a
program that can send file to my nokia phone. I was looking for a api that
can create a character device which can be passed to ioctl.  To do so what i
am doing right now is

i)              char cmdBuf[256];
                sprintf(cmdBuf,"mknod %s c 216 %d",tempBuf,dev);
                if (system(cmdBuf) != 0 )
                {
                    fprintf(stderr,"\nError in executng mknod\n");
                    exit(1);
                }

ii) And then
err = ioctl(ctl, RFCOMMCREATEDEV, &req);

iii) For releasing the device i am doing :-
err = ioctl(ctl, RFCOMMRELEASEDEV, &req);

These things are working fine for a single run but after 2 run (keeping the
above 3 in while(1) block) ;  while releasing the device , ioctl gives error
bad file descriptor. Please tell me what i am doing wrong.

regards
siddhant

------=_Part_54143_24390352.1172727624460
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi vikas ,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Really great to get i reply from you. I was trying to write a program that can send file to my nokia phone. I was looking for a api that can create a character device which can be passed to ioctl.&nbsp; To do so what i am doing right now is 
<br><br>i) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char cmdBuf[256];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(cmdBuf,&quot;mknod %s c 216 %d&quot;,tempBuf,dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (system(cmdBuf) != 0 )<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr,&quot;\nError in executng mknod\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>ii) And then <br>err = ioctl(ctl, RFCOMMCREATEDEV, &amp;req);<br><br>iii) For releasing the device i am doing :-<br>err = ioctl(ctl, RFCOMMRELEASEDEV, &amp;req);<br><br>These things are working fine for a single run but after 2 run (keeping the above 3 in while(1) block) ;&nbsp; while releasing the device , ioctl gives error bad file descriptor. Please tell me what i am doing wrong.
<br><br>regards<br>siddhant <br><br><br><br>

------=_Part_54143_24390352.1172727624460--


--===============0258956497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0258956497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0258956497==--
