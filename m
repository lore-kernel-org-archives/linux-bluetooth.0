Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Howto create SCO Connections?
Reply-To: axs203dd@excite.com
From: "mr" <axs203dd@excite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <20040604154607.F2EE73952@xprdmailfe9.nwk.excite.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri,  4 Jun 2004 11:46:07 -0400 (EDT)


I tested an SCO link using the headset profile of my mobile phone and worked fine. However, I had to connect from the desktop to the mobile using the hsmicro. My question is how to use the test tools or any other application in order to provide a listening service to the laptop and transfer the audio signal to the binded device. Will be this done using 'rfcomm listen' as well?

P.S.: The laptop has not audio support.


------------------------------------------------------------------
<br><br>at the moment you can only use the SCO seqpacket socket interface. See<br>source code of scotest.c or hstest.c for more details.<br><br>Regards<br><br>Marcel<br><br><br><br>

_______________________________________________
Join Excite! - http://www.excite.com
The most personalized portal on the Web!


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
