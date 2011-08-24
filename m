Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 22:15:21 +0800 (CST)
From: xz_explorer <xz_explorer@163.com>
To: maxk@qualcomm.com, marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc: "yulei.cao" <yulei.cao@samsung.com>
Message-ID: <47b5ec47.192c7.131fc2533dd.Coremail.xz_explorer@163.com>
Subject: About bluez
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_316004_1937702520.1314195321821"
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_316004_1937702520.1314195321821
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

hello,gentlemen:
    I have just used bluez for developing, now I have several question which puzzled me these days. 
    I use bluez-4.96 release.
    1.How can I compile and install the bluez?
       I have download the bluez-4.96package and run ./configure, and make && make install on ubuntu, and I found these do nothing but generate a libbluetooth.so, won't this copy some header files to system directory for develope to include?
 
    2.Whether health directory is built?
       I find Makefile generated while configure don't contain the health? It is been commented.
 
    3.What is the output of bluez after build? a static library or a dynamic library? If this, which header files should is include? Need I copy them from source code package? because I can't find them in other system directory after  make install.
 
    4.How do I use health? Is therr develop guide for studying?
 
    sorry for ask so many simple questions, but I find no answer by all ways,google etc. and expect your replay. Tank you very much.
 
    Good wishes!!!
 
                                                                                                                        Cao lei
                                                                                                                        24th Aug.
------=_Part_316004_1937702520.1314195321821
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial"><DIV>hello,gentlemen:</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I have just used bluez for developing, now I have several question which puzzled me these days.&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I use bluez-4.96 release.</DIV>
<DIV>&nbsp;&nbsp;&nbsp; 1.How can I compile and install the bluez?</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have download the bluez-4.96package and run ./configure, and make &amp;&amp; make install on ubuntu, and I found these do nothing but generate a libbluetooth.so, won't this copy some header files to system directory for develope to include? </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; 2.Whether health directory is built?</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I find Makefile generated while configure don't contain the health? It is been commented.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; 3.What is the output of bluez after build? a static library or a dynamic library? If this, which header files should is include? Need I copy them from source code package? because I can't find them in other system directory after&nbsp; make install.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; 4.How do I use health? Is therr develop guide for studying?</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; sorry for ask so many simple questions, but I find no answer by all ways,google etc. and expect your replay. Tank you very much.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Good wishes!!!</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cao lei</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24th Aug.</DIV></div><br><br><span title="neteasefooter"><span id="netease_mail_footer"></span></span>
------=_Part_316004_1937702520.1314195321821--
