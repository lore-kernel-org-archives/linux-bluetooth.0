Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <00b801c780c0$5974c710$8935c70a@dlh.st.com>
References: <00b801c780c0$5974c710$8935c70a@dlh.st.com>
Date: Thu, 19 Apr 2007 01:43:35 +0200
Message-Id: <1176939815.6741.37.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Pairing problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Sumeet,

> > the passkey value in hcid.conf is only for incoming connections and you need to adjust the security setting. However using the auto setting might result > in a security issue since you now have a fixed PIN.
> What security setting adjustment do I need to make?
> I started the security manager # hciconfig hci0 secmgr
> I am using "user" setting in hcid.conf

don't enable the kernel secmgr. It doesn't work.

> >Using the pincodes file won't work until you have a passkey agent running since it will ask the agent for confirmation.
> I have the passkey-agent running but still the hcudump -X -V log is stuck at pin code request. I run passkey-agent as 
> # ./bluez-utils-3.9/daemon/passkey-agent --default 0000
> 
> I have now installed bluez-gnome-0.6 also. Was it required? 

No. The only thing you need is a default passkey agent. The bluez-gnome
provides one, but you can also use the passkey-agent.c example.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
