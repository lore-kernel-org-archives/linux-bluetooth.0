Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Pavel Ruzicka <pavouk@pavouk.org>, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hotplug USB dongle problem
References: <200402281424.55149.pavouk@pavouk.org>
In-Reply-To: <200402281424.55149.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8GKQA89/ue8tfzi"
Message-Id: <200402281512.12029.wim.delvaux@adaptiveplanet.com>
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
Date: Sat, 28 Feb 2004 15:12:12 +0100


--Boundary-00=_8GKQA89/ue8tfzi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

i 'think' that it is because hcid and sdpd are started too soon.  I have moved 
the startup of these daemons to the bluetooth.agent script too (attached)

W


--Boundary-00=_8GKQA89/ue8tfzi
Content-Type: application/x-shellscript;
  name="bluetooth.agent"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetooth.agent"

#!/bin/bash
exec 2>> /HCI_USB
set >&2
echo $* >&2

cd /etc/hotplug
. hotplug.functions

case $ACTION in
    add|register)
        # start bluetooth daemons
        sh -x /etc/init.d/bluez-utils start
        sh -x /etc/init.d/bluez-sdp start
        sh -x /etc/init.d/bluez-pan start

        # install remover
        #echo "set -x" > $REMOVER
        #echo 'exec 2> /tmp/HCI_REMOVE' >> $REMOVER
        #echo "/etc/init.d/bluez-pan stop" >> $REMOVER
        #echo "/etc/init.d/bluez-sdp stop" >> $REMOVER
        #echo "/etc/init.d/bluez-utils stop" >> $REMOVER
        #chmod 700 $REMOVER
     ;;
     unregister)
        /etc/init.d/bluez-pan stop
        /etc/init.d/bluez-sdp stop
        /etc/init.d/bluez-utils stop
     ;;
esac

--Boundary-00=_8GKQA89/ue8tfzi--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
