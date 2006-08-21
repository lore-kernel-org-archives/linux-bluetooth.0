Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Mon, 21 Aug 2006 15:11:46 +0530
Message-ID: <003501c6c506$04e4ffb0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <000801c6c2c1$85dcbaf0$9d0cc70a@dlh.st.com>
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

> Here you go. Though, it is not the latest version of files 
> that I am working
> on.
> It's a quick and dirty approach right now. Sending Host 
> Number of Completed
> Packets as soon as we receive ACL Data Packet on any 
> connection handle.
> Once this works, I'll try to send Host Number of completed 
> packets after
> reception of 8 packets.


I am still facing the same issue that since there is no event generated for
Host Number of Completed packets command and the BlueZ stack is expecting an
event for this command, the command finally times out. dmesg shows
"hci_cmd_task: hci0 command tx timeout". The ACL data transfer stops after
this. Also, when I disconnect, I see that all the remaining Host Number of
completed packets commands that were queued earlier on, are sent finally.

Regards,
Mayank


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
